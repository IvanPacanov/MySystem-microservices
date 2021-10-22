using AboutUsers.Common.CQRS;
using Autofac;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AboutUsers.API.Infrastructure
{
    public class CommandDispatcher : ICommandDispatcher
    {
        private readonly ILifetimeScope _lifetimeScope;

        public CommandDispatcher(ILifetimeScope lifetimeScope)
        {
            _lifetimeScope = lifetimeScope;
        }

        public async Task Dispatch<TCommand>(TCommand command) where TCommand : ICommand
        {
            using (var scope = _lifetimeScope.BeginLifetimeScope())
            {
                var handler = scope.Resolve<ICommandHandler<TCommand>>();
                await handler.Handle(command);
            }
        }
    }
}
