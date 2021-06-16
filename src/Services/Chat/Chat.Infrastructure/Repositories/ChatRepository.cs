using Chat.Application.Contracts.Persistence;
using Chat.Domain.Entities;
using Chat.Infrastructure.Persistence;
using Chat.Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chat.Infrastructure
{
    public class ChatRepository : RepositoryBase<Chats>, IChatRepository
    {

        public ChatRepository(ChatContext dbContext) : base(dbContext)
        {

        }


        public async Task<IEnumerable<Chats>> GetChatByUserName(string userName)
        {
            var chatList = await _dbContext.Chat.Where(chat => chat.UserName == userName).ToListAsync();
            return chatList;
        }
    }
}
