using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace VideoCommunication.API.Models
{
    public class UserInfo : IRequest<int>
    {
       
        public string UserName { get; set; }

        public string UserPassword { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string EmailAddress { get; set; }

        public string Country { get; set; }
    }
}
