using AboutUsers.PublishedLanguage.Queries;
using System.Collections.Generic;
using System.Threading.Tasks;
using AboutUsers.PublishedLanguage.Dots;

namespace AboutUsers.ApplicationServices.Boundaries.Users
{
    public interface IUserQuery
    {
        Task<UserDTO> GetUserData(string unserName);
        Task<UserDTO> GetUserByID(int id);
        Task<List<MessageDTO>> GetUserMessagesData(MessagesParameters query);
    }
}
