using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.PublishedLanguage.Dots
{
  public  class FriendDTO
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public ICollection<MessageDTO> messageDTOs{ get; set; }
    }
}
