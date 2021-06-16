using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Chat.Domain.Entities
{
   public class Message
    {
        [Key]
        public int IdMessage { get; set; }

        public DateTime DateTime { get; set; }

        public string SenderOfMessage { get; set; }

        public string ReceiverOfMessage { get; set; }

        public string Text { get; set; }

    }
}
