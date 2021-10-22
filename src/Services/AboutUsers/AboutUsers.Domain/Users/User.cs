using AboutUsers.Domain.Common;
using System.Collections.Generic;

namespace AboutUsers.Domain.Users
{
   public class User : AuditableEntity
    {
        public User(string userName)
        {
            UserName = userName;
        }

        public int Id { get; set; }

        public string UserName { get; set; }

        public ICollection<Friend> FriendlyUsers { get; set; }

        public ICollection<GroupOfUsers> GroupOfUsers { get; set; }
    }
}
