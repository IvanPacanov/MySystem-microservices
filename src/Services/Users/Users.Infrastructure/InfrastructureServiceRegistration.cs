using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Text;
using Users.Application.Contracts.Infrastructure;
using Users.Application.Contracts.Persistence;
using Users.Application.Models;
using Users.Infrastructure.Mail;
using Users.Infrastructure.Presistance;
using Users.Infrastructure.Repositories;

namespace Users.Infrastructure
{
    public static class InfrastructureServiceRegistration
    {
        public static IServiceCollection AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddDbContext<UserContext>(options =>
                options.UseSqlServer(configuration.GetConnectionString("UserConnectionString")));

            services.AddScoped(typeof(IAsyncRepository<>), typeof(RepositoryBase<>));
            services.AddScoped<IUserRepository, UserRepository>();

            services.Configure<EmailSettings>(c => configuration.GetSection("EmailSettings"));
            services.AddTransient<IEmailService, EmaliService>();

            return services;
        }
    }
}
