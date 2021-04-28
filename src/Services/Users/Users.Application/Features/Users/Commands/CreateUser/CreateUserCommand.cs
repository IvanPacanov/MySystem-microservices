using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Application.Features.Users.Commands.CreateUser
{
    public class CreateUserCommand : IRequest<int>
    {
        public string UserName { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string EmailAddress { get; set; }

        public string Country { get; set; }
    }
}
