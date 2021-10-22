using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chat.Domain.Entities
{
    public class User
    {
        public int UserId { get; set; }

        public int ChatsId { get; set; }

        public string UserName { get; set; }
        public ICollection<User> Users { get; set; }
    }
}
