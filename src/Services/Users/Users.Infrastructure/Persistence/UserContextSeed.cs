using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Users.Domain.Entities;

namespace Users.Infrastructure.Presistance
{
    public class UserContextSeed
    {
        public static async Task SeedAsync(UserContext userContext, ILogger<UserContextSeed> logger)
        {
            if (!userContext.Users.Any())
            {
                userContext.Users.AddRange(GetPreconfiguredUser());
                await userContext.SaveChangesAsync();
                logger.LogInformation("Seed database associated with context {DbContextName}", typeof(UserContext).Name);
            }
        }

        public static IEnumerable<User> GetPreconfiguredUser()
        {
            return new List<User>
            {
                new User() {UserName = "Admin", UserPassword = "Admin" }
            };
        }
    }
}
