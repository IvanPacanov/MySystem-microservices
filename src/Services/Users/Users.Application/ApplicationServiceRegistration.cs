using FluentValidation;
using MediatR;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using Users.Application.Behaviours;

namespace Users.Application
{
   public static class ApplicationServiceRegistration
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            // looking for any object of Profile -> MappingProfile
            services.AddAutoMapper(Assembly.GetExecutingAssembly());

            // looking for any object of AbstractValidator
            services.AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());

            // looking for any object of IRequestHandler and IRequest 
            services.AddMediatR(Assembly.GetExecutingAssembly());

            services.AddTransient(typeof(IPipelineBehavior<,>), typeof(UnhandledExceptionBehaviour<,>));
            services.AddTransient(typeof(IPipelineBehavior<,>), typeof(ValidationBehaviour<,>));

            return services;
        }
    }
}
