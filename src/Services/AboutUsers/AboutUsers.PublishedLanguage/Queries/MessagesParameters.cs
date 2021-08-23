using AboutUsers.Common.CQRS;
using AboutUsers.PublishedLanguage.Dots;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.PublishedLanguage.Queries
{
    public class MessagesParameters : IQuery<List<MessageDTO>>
    {
        public int friendID { get; set; }
    }
}
