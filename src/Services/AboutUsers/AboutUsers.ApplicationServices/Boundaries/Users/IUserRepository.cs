using AboutUsers.Domain.Users;
using System.Threading.Tasks;

namespace AboutUsers.ApplicationServices.Boundaries.Users
{
      public interface IUserRepository
    {
        Task<User> GetUser(string name);
        Task<User> GetUser(int userId);
        void EnsureThatUserDoesNotExist(string name);
        void Store(User sample);
    }
}
