using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.Domain.Users
{
   public class Message
    {

        public int Id { get; set; }

        public string SendingBy { get; set; }

        public string Text { get; set; }

        public DateTime? Sending { get; set; }
    }
}
