using AboutUsers.Domain.Enum;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.Domain.Users
{
    public class Friend
    {
        public int Id { get; set; }

        public EnumRoleOfUser EnumRoleOfUser { get; set; }

        public string UserName { get; set; }

        public ICollection<Message> messages { get; set; }
    
    }
}
