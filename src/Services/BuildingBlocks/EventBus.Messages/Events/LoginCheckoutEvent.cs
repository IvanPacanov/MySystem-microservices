using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EventBus.Messages.Events
{
    public class LoginCheckoutEvent : IntegrationBaseEvent
    {
        public string UserName { get; set; }

        public string UserPassword { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string EmailAddress { get; set; }

        public string Country { get; set; }
    }
}
