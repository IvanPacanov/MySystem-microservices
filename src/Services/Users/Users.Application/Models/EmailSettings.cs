using System;
using System.Collections.Generic;
using System.Text;

namespace Users.Application.Models
{
    public class EmailSettings
    {
        public string ApiKey { get; set; }

        public string FromAddress { get; set; }

        public string FromName { get; set; }
    }
}
