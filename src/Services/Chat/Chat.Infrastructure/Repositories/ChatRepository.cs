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


        public async Task<IEnumerable<Chats>> GetChatsByUserName(string userName)
        {
          //  var userList = _dbContext.Chat.Select(c => c.Users.Where(u => u.UserName == userName).FirstOrDefault()).FirstOrDefault();
          //  var chatList = await _dbContext.Chat.ToListAsync();
           
            var chatList2 = await _dbContext.Chat.Where(chat => chat.Users.Any(u => u.UserName == userName)).ToListAsync();
            foreach (var item in chatList2)
            {
                item.Message = await _dbContext.Messages.Where(m => m.ChatsId == item.ChatsId).ToListAsync();
                item.Users = await _dbContext.User.Where(m => m.ChatsId == item.ChatsId).ToListAsync();
            }
            return chatList2;
        }

       
    }
}
