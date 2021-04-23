using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Application.Features.Users.Queries.GetUsersList
{
  public class GetUsersListQuery : IRequest<List<UserVm>>
    {

        public string UserName { get; set; }

        public GetUsersListQuery(string userName)
        {
            UserName = userName ?? throw new ArgumentNullException(nameof(userName));
        }
    }
}
