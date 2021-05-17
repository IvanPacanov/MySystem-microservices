using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chat.Domain.Common
{
    public abstract class EntityBase
    {
        public int Id { get; set; }

        public string CreatedBy { get; set; }

        public DateTime CreateDate { get; set; }

        public string LastModifiedBy { get; set; }

        public DateTime? LastModifiedDate { get; set; }

    }
}
