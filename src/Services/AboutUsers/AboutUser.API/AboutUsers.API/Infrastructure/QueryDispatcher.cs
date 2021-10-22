﻿using AboutUsers.Common.CQRS;
using Autofac;
using EnsureThat;
using System;
using System.Reflection;
using System.Runtime.ExceptionServices;
using System.Threading.Tasks;

namespace AboutUsers.API.Infrastructure
{
    public class QueryDispatcher : IQueryDispatcher
    {
        private readonly ILifetimeScope _lifetimeScope;

        public QueryDispatcher(ILifetimeScope lifetimeScope)
        {
            EnsureArg.IsNotNull(lifetimeScope, nameof(lifetimeScope));

            _lifetimeScope = lifetimeScope;
        }

        public async Task<TResult> Dispatch<TResult>(IQuery<TResult> query)
        {
            object handler;

            var handlerExists = TryGetQueryHandler(_lifetimeScope, query, out handler);

            if (!handlerExists)
            {
                throw new Exception($"Handler for query {GetQueryName(query)} does not exist.");
            }

            return await ExecuteHandler(handler, query);
        }

        protected virtual async Task<TResult> ExecuteHandler<TResult>(object handler, IQuery<TResult> query)
        {
            try
            {
                var result = (Task<TResult>)handler.GetType()
                    .GetRuntimeMethod("Handle", new[] { query.GetType() })
                    .Invoke(handler, new object[] { query });

                return await result;
            }
            catch (TargetInvocationException ex)
            {
                ExceptionDispatchInfo.Capture(ex.InnerException).Throw();
                throw;
            }
        }

        private static bool TryGetQueryHandler<TResult>(ILifetimeScope scope, IQuery<TResult> query, out object handler)
        {
            var asyncGenericType = typeof(IQueryHandler<,>);
            var closedAsyncGeneric = asyncGenericType.MakeGenericType(query.GetType(), typeof(TResult));

            return scope.TryResolve(closedAsyncGeneric, out handler);
        }

        private static string GetQueryName(object query)
        {
            return query.GetType().Name;
        }
    }
}
