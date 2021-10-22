using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Users.Application.Contracts.Persistence;
using Users.Domain.Entities;
using Users.Infrastructure.Presistance;

namespace Users.Infrastructure.Repositories
{
    public class UserRepository : RepositoryBase<User>, IUserRepository
    {
        public UserRepository(UserContext dbContext) : base(dbContext)
        {

        }

        public async Task<IEnumerable<User>> GetUsersByUserName(string userLogin)
        {
            var userList = await _dbContext.Users.Where(user => user.UserName == userLogin).ToListAsync();
            return userList;
        }
    }
}
