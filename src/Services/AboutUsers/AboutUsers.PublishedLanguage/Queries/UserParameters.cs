using AboutUsers.Common.CQRS;
using AboutUsers.PublishedLanguage.Dots;
using System.Collections.Generic;

namespace AboutUsers.PublishedLanguage.Queries
{
    public class UserParameters : IQuery<UserDTO>
    {
        public string UnserName { get; set; }
    }
}
