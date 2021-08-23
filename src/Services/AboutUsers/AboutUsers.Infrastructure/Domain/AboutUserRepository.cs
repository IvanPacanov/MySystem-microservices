using AboutUsers.ApplicationServices.Boundaries.Users;
using AboutUsers.Common.Exceptions;
using AboutUsers.Domain.Users;
using AboutUsers.Infrastructure.DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.Infrastructure.Domain
{
    public class AboutUserRepository : IUserRepository
    {
        private readonly AboutUserContext _context;
        public AboutUserRepository(AboutUserContext context)
        {
            _context = context;
        }

        public void EnsureThatUserDoesNotExist(string name)
        {
            var sample = _context.Users.FirstOrDefault(r => r.UserName == name);
            if (sample != null)
            {
                throw new DomainException($"Provided sample name: \"{name}\" already exist.");
            }
        }

        public void Store(User user)
        {
            _context.Users.Add(user);
        }
    }
}
