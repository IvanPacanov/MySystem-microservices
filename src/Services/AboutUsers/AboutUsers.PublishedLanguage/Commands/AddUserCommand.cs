using AboutUsers.Common.CQRS;

namespace AboutUsers.PublishedLanguage.Commands
{
    public class AddUserCommand : ICommand
    {
        public string UserName { get; set; }
    }
}
