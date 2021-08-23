using AboutUsers.ApplicationServices.Boundaries.Users;
using AboutUsers.Common.CQRS;
using AboutUsers.PublishedLanguage.Dots;
using AboutUsers.PublishedLanguage.Queries;
using EnsureThat;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace AboutUsers.ApplicationServices.UseCases
{
    public class GetUsersUseCase : IQueryHandler<UserParameters, UserDTO>
    {
        private readonly IUserQuery _userQuery;

        public GetUsersUseCase(IUserQuery userQuery)
        {
            EnsureArg.IsNotNull(userQuery, nameof(userQuery));
            _userQuery = userQuery;
        }

        public async Task<UserDTO> Handle(UserParameters query)
        {
            return await _userQuery.GetUserData(query);
        }
    }
}
