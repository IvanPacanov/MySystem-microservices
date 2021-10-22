using Chat.Application.Contracts.Persistence;
using Chat.Infrastructure;
using Chat.Infrastructure.Persistence;
using Chat.Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Text;

namespace Chat.Infrastructure
{
    public static class InfrastructureServiceRegistration
    {
        public static IServiceCollection AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddDbContext<ChatContext>(options =>
                options.UseSqlServer(configuration.GetConnectionString("UserConnectionString")));

            services.AddScoped(typeof(IAsyncRepository<>), typeof(RepositoryBase<>));
            services.AddScoped<IChatRepository, ChatRepository>();

         

            return services;
        }
    }
}
