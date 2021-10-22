using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.PublishedLanguage.Dots
{
    public class UserDTO
    {

        public int Id { get; set; }
        public string UserName { get; set; }
        public ICollection<FriendDTO> FriendDTOs { get; set; }
        public ICollection<GroupOfUserDTO> GroupOfUserDTOs { get; set; }
    }
}
