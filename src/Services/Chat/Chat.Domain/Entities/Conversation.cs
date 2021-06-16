using Chat.Domain.Common;
using System;
using System.Collections.Generic;
using System.Text;

namespace Chat.Domain.Entities
{
    public class Conversation
    {
        public Conversation()
        {
            this.Message = new HashSet<Message>();
        }

        public int ChatsId { get; set; }

        public int ConversationId { get; set; }

        public string CommunicationWithUserName { get; set; }

        public ICollection<Message> Message { get; set; }
    }
}
