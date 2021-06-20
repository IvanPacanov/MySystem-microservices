using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Chat.Domain.Entities
{
   public class Message
    {
        public int MessageId { get; set; }

        public int ChatsId { get; set; }

        public string UserSend { get; set; }

        public string UserReceiver { get; set; }

        public DateTime DateOfSendMessage { get; set; }

        public string Text { get; set; }

    }
}
