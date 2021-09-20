using AboutUsers.ApplicationServices.Boundaries.Users;
using AboutUsers.Common.Exceptions;
using AboutUsers.Domain.Users;
using AboutUsers.Infrastructure.DataModel;
using Microsoft.EntityFrameworkCore;
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

        public async Task<User> GetUser(int userId)
        {
            var listingImages = _context.Users.Where(u=> u.Id == userId)
                .Include(x=>x.FriendlyUsers)
                .FirstOrDefault();

            return await Task.FromResult(listingImages);
        }

        public async Task<User> GetUser(string name)
        {
            var listingImages = _context.Users.Where(u => u.UserName == name)
                .Include(x => x.FriendlyUsers)
                .FirstOrDefault();

            return await Task.FromResult(listingImages);
        }

        public async Task<List<Friend>> GetFriends(User user)
        {
            var listingImages = _context.Friends.Where(f => f.UserName == user.UserName)
                .ToList();

            return await Task.FromResult(listingImages);
        }

        public void Store(User user)
        {
            _context.Users.Add(user);
        }
    }
}
