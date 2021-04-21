using System.Collections.Generic;
using System.Threading.Tasks;
using Users.Domain.Entities;

namespace Users.Application.Contracts.Persistence
{
    public interface IUserRepository : IAsyncRepository<User>
    {
        Task<IEnumerable<User>> GetUser(string userLogin);
    }
}
