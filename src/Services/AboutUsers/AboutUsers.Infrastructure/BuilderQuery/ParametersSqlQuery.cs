using Dapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.Infrastructure.BuilderQuery
{
   public class ParametersSqlQuery : DynamicParameters
    {
        private int _parameterGenerator;

        public ParametersSqlQuery()
        {
            _parameterGenerator = 0;
        }

        public string GetNextParameterName()
        {
            _parameterGenerator++;

            return "@p" + _parameterGenerator;
        }

        public void Add(string name, object value)
        {
            base.Add(name, value);
        }
    }
}