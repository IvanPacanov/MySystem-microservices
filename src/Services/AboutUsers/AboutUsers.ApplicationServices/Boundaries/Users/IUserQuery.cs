using AboutUsers.PublishedLanguage.Queries;
using System.Collections.Generic;
using System.Threading.Tasks;
using AboutUsers.PublishedLanguage.Dots;

namespace AboutUsers.ApplicationServices.Boundaries.Users
{
    public interface IUserQuery
    {
        Task<UserDTO> GetUserData(UserParameters query);
        Task<List<MessageDTO>> GetUserMessagesData(MessagesParameters query);
    }
}
