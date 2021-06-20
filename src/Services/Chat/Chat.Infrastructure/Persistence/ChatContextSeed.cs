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
                    Users = new List<User>
                    {
                        new User(){ UserName = "Admin"},
                        new User(){ UserName = "Guest"}
                    },
                    ChatsId = 1,
                    Message =  new List<Message>() 
                    {
                                     new Message()
                                     {
                                       
                                                DateOfSendMessage = DateTime.Now,
                                                UserSend = "Admin",
                                                UserReceiver = "Guest",
                                                Text= "Test message One",
                                                
                                       
                                     },
                                     new Message()
                                     {

                                                DateOfSendMessage = DateTime.Now,
                                                UserSend = "Admin",
                                                UserReceiver = "Guest",
                                                Text= "Test message One22222"

                                     },
                                     new Message()
                                     {

                                                DateOfSendMessage = DateTime.Now,
                                                UserSend = "Admin",
                                                UserReceiver = "Guest",
                                                Text= "Test message One333"

                                     }
                    }
                }
            };
        }
    }
}

  
