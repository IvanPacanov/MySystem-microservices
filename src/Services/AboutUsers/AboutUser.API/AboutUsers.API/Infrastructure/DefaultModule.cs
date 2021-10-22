using AboutUsers.API.Controllers;
using AboutUsers.ApplicationServices.UseCases;
using AboutUsers.Infrastructure.BuilderQuery;
using AboutUsers.Infrastructure.DataModel;
using AboutUsers.Infrastructure.Domain;
using AboutUsers.Infrastructure.Queries;
using Autofac;
using EnsureThat;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using Module = Autofac.Module;

namespace AboutUsers.API.Infrastructure
{
    public class DefaultModule : Module
    {
        private readonly string _connectionString;

        public DefaultModule(string connectionString)
        {
            Ensure.String.IsNotNullOrWhiteSpace(connectionString, nameof(connectionString));

            _connectionString = connectionString;
        }

        protected override void Load(ContainerBuilder builder)
        {
            builder.RegisterType<QueryDispatcher>().AsImplementedInterfaces();
            builder.RegisterType<CommandDispatcher>().AsImplementedInterfaces();

            RegisterContext(builder);
            RegisterDatabaseAccess(builder);
            RegisterServices(builder);
            RegisterControllers(builder);
            RegisterUseCases(builder);
            RegisterQueries(builder);
          //  RegisterQueriesHome(builder);
            RegisterRepositories(builder);
          //  RegisterRepositoriesHome(builder);
        }

        private static void RegisterTransientDependenciesAutomatically(
             ContainerBuilder builder,
             Assembly assembly,
             string nameSpace)
        { 

            builder.RegisterAssemblyTypes(assembly)
                .Where(t => !string.IsNullOrEmpty(t.Namespace) && t.Namespace.StartsWith(nameSpace, StringComparison.InvariantCulture))
                .AsSelf()
                .AsImplementedInterfaces()
                .InstancePerDependency();
        }

        private void RegisterContext(ContainerBuilder builder)
        {
            var options = new DbContextOptionsBuilder<AboutUserContext>();
            options.UseSqlServer(_connectionString);

            builder.Register(container => new AboutUserContext(options.Options)).InstancePerLifetimeScope();
        }

        private void RegisterDatabaseAccess(ContainerBuilder builder)
        {
            builder
                .Register<IDbConnection>(c => new SqlConnection(_connectionString))
                .InstancePerLifetimeScope();
            builder
                .RegisterType<BuilderSqlQuery>()
                .InstancePerDependency();
        }

        private void RegisterServices(ContainerBuilder builder)
        {
      //      builder.RegisterType<CurrentUserService>().AsImplementedInterfaces().InstancePerLifetimeScope();
        }

        private static void RegisterControllers(ContainerBuilder builder)
        {
            RegisterTransientDependenciesAutomatically(
                builder,
                typeof(UsersController).Assembly,
                "AboutUsers.API.Controllers");
        }

        private static void RegisterUseCases(ContainerBuilder builder)
        {
            RegisterTransientDependenciesAutomatically(
                builder,
                typeof(GetUsersUseCase).Assembly,
                "AboutUsers.ApplicationServices.UseCases");
        }
        //private static void RegisterUseCases(ContainerBuilder builder)
        //{
        //    RegisterTransientDependenciesAutomatically(
        //        builder,
        //        typeof(GetHomeUseCase).Assembly,
        //        "Insig.ApplicationServices.UseCases");
        //}

        private static void RegisterQueries(ContainerBuilder builder)
        {
            RegisterTransientDependenciesAutomatically(
                builder,
                typeof(UserQuery).Assembly,
                "AboutUsers.Infrastructure.Queries");
        }

        //private static void RegisterQueriesHome(ContainerBuilder builder)
        //{
        //    RegisterTransientDependenciesAutomatically(
        //        builder,
        //        typeof(HomeQuery).Assembly,
        //        "Insig.Infrastructure.Queries");
        //}

        private void RegisterRepositories(ContainerBuilder builder)
        {
            RegisterTransientDependenciesAutomatically(
                builder,
                typeof(AboutUserRepository).Assembly,
                "AboutUsers.Infrastructure.Domain");
        }

        //private void RegisterRepositoriesHome(ContainerBuilder builder)
        //{
        //    RegisterTransientDependenciesAutomatically(
        //        builder,
        //        typeof(HomeRepository).Assembly,
        //        "Insig.Infrastructure.Domain");
        //}
    }
}
