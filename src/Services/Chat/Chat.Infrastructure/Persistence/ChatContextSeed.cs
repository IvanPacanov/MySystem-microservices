using Chat.Domain.Entities;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chat.Infrastructure.Persistence
{
    public class ChatContextSeed
    {

        public static async Task SeedAsync(ChatContext chatContext, ILogger<ChatContextSeed> logger)
        {
            if (!chatContext.Chat.Any())
            {
                chatContext.Chat.AddRange(GetPreconfiguredChats());
                await chatContext.SaveChangesAsync();
                logger.LogInformation("Seed database associated with context {DbContextName}", typeof(ChatContext).Name);
            }
        }

        public static IEnumerable<Chats> GetPreconfiguredChats()
        {
            return new List<Chats>
            {
                new Chats()
                {
                    UserName = "Admin",
                    ChatsId = 1,
                    Conversation =  new List<Conversation>() 
                    {
                                     new Conversation()
                                     {
                                         CommunicationWithUserName = "Guest",
                                         Message = new List<Message>()
                                         {
                                            new Message()
                                            {
                                                DateTime = DateTime.Now, 
                                                SenderOfMessage = "Admin", 
                                                ReceiverOfMessage = "Guest", 
                                                Text= "Test message One"
                                            }
                                         }
                                     }
                    }
                }
            };
        }
    }
}

  
