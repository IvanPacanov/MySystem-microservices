using Chat.Domain.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chat.Domain.Entities
{
   public class Chats : EntityBase
    {
        public Chats()
        {
            Conversation = new HashSet<Conversation>();
        }

        public int  ChatsId { get; set; } 

        public string UserName { get; set; }

        public ICollection<Conversation> Conversation { get; set; }
    }
}
