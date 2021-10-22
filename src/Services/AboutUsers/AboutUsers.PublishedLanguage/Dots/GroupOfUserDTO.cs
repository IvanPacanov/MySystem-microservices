using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.PublishedLanguage.Dots
{
   public class GroupOfUserDTO
    {

        public string GroupName { get; set; }
        public ICollection<UserDTO> userDTOs{ get; set; }
        public ICollection<MessageDTO> messageDTOs { get; set; }
    }
}
