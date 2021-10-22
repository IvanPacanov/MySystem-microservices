using AboutUsers.ApplicationServices.Boundaries.Users;
using AboutUsers.Common.CQRS;
using AboutUsers.Infrastructure.DataModel;
using AboutUsers.Infrastructure.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace AboutUsers.Infrastructure
{
    public static class InfrastructureServiceRegistration
    {
        public static IServiceCollection AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddDbContext<AboutUserContext>(options =>
                options.UseSqlServer(configuration.GetConnectionString("Insig")));

            services.AddScoped<IUserRepository, AboutUserRepository>();


            return services;
        }
    }
}
