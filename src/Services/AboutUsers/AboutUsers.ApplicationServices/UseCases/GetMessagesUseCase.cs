using AboutUsers.ApplicationServices.Boundaries.Users;
using AboutUsers.Common.CQRS;
using AboutUsers.PublishedLanguage.Dots;
using AboutUsers.PublishedLanguage.Queries;
using EnsureThat;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.ApplicationServices.UseCases
{
   public class GetMessagesUseCase : IQueryHandler<MessagesParameters, List<MessageDTO>>
    {
        private readonly IUserQuery _userQuery;

        public GetMessagesUseCase(IUserQuery userQuery)
        {
            EnsureArg.IsNotNull(userQuery, nameof(userQuery));
            _userQuery = userQuery;
        }

        public async Task<UserDTO> Handle(UserParameters query)
        {
            return await _userQuery.GetUserData(query);
        }

        public async Task<List<MessageDTO>> Handle(MessagesParameters query)
        {
            return await _userQuery.GetUserMessagesData(query);
        }
    }
}
