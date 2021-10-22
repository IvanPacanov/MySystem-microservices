using AboutUsers.Common.CQRS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.PublishedLanguage.Commands
{
    public class AddNewFriendCommand : ICommand
    {
        public int Id { get; set; }
        public string UserName { get; set; }
    }
}
