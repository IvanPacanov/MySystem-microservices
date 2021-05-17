using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Chat.Domain.Entities;



namespace Chat.Infrastructure.Persistence
{
    public class ChatContext : DbContext
    {

        public ChatContext(DbContextOptions<ChatContext> option): base(option)
        {

        }

        public DbSet<Chats> Chat { get; set; }
    }
}
