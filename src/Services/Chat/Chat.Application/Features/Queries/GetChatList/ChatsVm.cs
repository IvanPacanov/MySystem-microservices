using Chat.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chat.Application.Features.Queries.GetChatList
{
    public class ChatsVm
    {
        public int ChatsId { get; set; }

        public string NameOfChat { get; set; }

        public ICollection<User> Users { get; set; }

        public ICollection<Message> Message { get; set; }
    }
}
