using Chat.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Chat.Application.Contracts.Persistence
{
   public interface IChatRepository
    {
        Task<IEnumerable<Chats>> GetChatsByUserName(string userName);
    }
}
