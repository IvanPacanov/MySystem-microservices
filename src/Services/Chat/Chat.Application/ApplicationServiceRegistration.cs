using Chat.Application.Behaviours;
using FluentValidation;
using MediatR;
using Microsoft.Extensions.DependencyInjection;
using System.Reflection;

namespace Chat.Application
{
    public static class ApplicationServiceRegistration
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            services.AddAutoMapper(Assembly.GetExecutingAssembly());  //Add any class in Profile class -> MappingProfile
            services.AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());  // CheckoutOrderCommandValidator : AbstractValidator etc.
            services.AddMediatR(Assembly.GetExecutingAssembly());  //IRequest and IRequestHandler

            services.AddTransient(typeof(IPipelineBehavior<,>), typeof(UnhandledExceptionBehaviour<,>));
            services.AddTransient(typeof(IPipelineBehavior<,>), typeof(ValidationBehaviour<,>));

            return services;
        }
    }
}