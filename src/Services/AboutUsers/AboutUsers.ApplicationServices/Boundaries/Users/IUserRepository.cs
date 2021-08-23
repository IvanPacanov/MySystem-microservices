using AboutUsers.Domain.Users;

namespace AboutUsers.ApplicationServices.Boundaries.Users
{
      public interface IUserRepository
    {
        void EnsureThatUserDoesNotExist(string name);
        void Store(User sample);
    }
}
