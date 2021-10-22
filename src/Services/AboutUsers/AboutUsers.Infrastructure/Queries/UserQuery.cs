using AboutUsers.ApplicationServices.Boundaries.Users;
using AboutUsers.Infrastructure.BuilderQuery;
using AboutUsers.PublishedLanguage.Dots;
using AboutUsers.PublishedLanguage.Queries;
using EnsureThat;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.Infrastructure.Queries
{
    public class UserQuery : IUserQuery
    {

        private readonly BuilderSqlQuery _sqlQueryBuilder;

        public UserQuery(BuilderSqlQuery sqlQueryBuilder)
        {
            EnsureArg.IsNotNull(sqlQueryBuilder, nameof(sqlQueryBuilder));
            _sqlQueryBuilder = sqlQueryBuilder;
        }

        public async Task<UserDTO> GetUserByID(int id)
        {
            var c = await _sqlQueryBuilder
                 .Select("*")
                 .From("Users")
                 .Where("Id", id.ToString())
                 .BuildQuery<UserDTO>().ExecuteSingle();

            var c1 = await _sqlQueryBuilder
            .Select("*")
            .From("Friends")
            .Where("UserId", c.Id.ToString())
            .BuildQuery<FriendDTO>()
            .ExecuteToList();
            c.FriendDTOs = c1;

            return c;
        }

        public async Task<UserDTO> GetUserData(string unserName)
        {
            var c = await _sqlQueryBuilder
                 .Select("*")
                 .From("Users")
                 .Where("UserName", unserName)
                 .BuildQuery<UserDTO>().ExecuteSingle();

            var c1 = await _sqlQueryBuilder
             .Select("*")
             .From("Friends")
             .Where("UserId", c.Id.ToString())
             .BuildQuery<FriendDTO>()
             .ExecuteToList();


            foreach (var item in c1)
            {
                item.messageDTOs =  await _sqlQueryBuilder
                    .Select("TOP 1 *")
                    .From("Messages")
                    .Where("FriendId", item.Id.ToString())
                    .BuildQuery<MessageDTO>()
                    .ExecuteToList();

            }

            c.FriendDTOs = c1;
            
            return c;
        }

        public async Task<List<MessageDTO>> GetUserMessagesData(MessagesParameters query)
        {
           return await _sqlQueryBuilder
                  .Select("*")
                  .From("Messages")
                  .Where("FriendId", query.friendID.ToString())
                  .BuildQuery<MessageDTO>().ExecuteToList();
        }
    }
}
