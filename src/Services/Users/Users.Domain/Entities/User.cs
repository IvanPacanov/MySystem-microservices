using System;
using System.Collections.Generic;
using System.Text;
using Users.Domain.Common;

namespace Users.Domain.Entities
{
    public class User: EntityBase
    {
        public string UserName { get; set; }

        public string UserPassword { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string EmailAddress { get; set; }

        public string Country { get; set; }


    }
}
