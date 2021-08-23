using EnsureThat;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.Infrastructure.BuilderQuery
{
   public class BuilderSqlQuery
    {
        private readonly IDbConnection _dbConnection;

        
        private List<string> _selectColums;
        private List<string> _whereConditions;
        private ParametersSqlQuery _parametersSql;
        private string _dataSource;
        private bool _isDistinct;

        public BuilderSqlQuery(IDbConnection dbConnection)
        {
            EnsureArg.IsNotNull(dbConnection, nameof(dbConnection));
            _dbConnection = dbConnection;
            ResetAllVariables();
        }

        public BuilderSqlQuery Select(params string[] columns)
        {
            EnsureArg.IsNotNull(columns, nameof(columns));
            var splitColumns = columns.Select(c => c.Trim());
            _selectColums.AddRange(splitColumns);
            return this;
        }

        public BuilderSqlQuery From(string dataSource)
        {
            Ensure.String.IsNotNullOrWhiteSpace(dataSource, nameof(dataSource));
            _dataSource = dataSource;
            return this;
        }
        public BuilderSqlQuery Where(string column, string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                return this;
            }

            AddFilter(column, " = ", value);

            return this;
        }

        public DataQuery<T> BuildQuery<T>()
        {
            var selectQuery = BuildSelectQuery();
            var query = new DataQuery<T>(_dbConnection, selectQuery, _parametersSql);

            ResetAllVariables();
            return query;
        }

        private string BuildSelectQuery()
        {
            var builder = new StringBuilder();
            builder.Append("SELECT ");

            if (_isDistinct)
            {
                builder.Append("DISTINCT ");
            }

            builder.Append(string.Join(", ", _selectColums.Where(c => !string.IsNullOrEmpty(c))));

            builder.Append($" FROM {_dataSource} ");

            if (_whereConditions.Any())
            {
                builder.Append(" WHERE " + string.Join(" AND ", _whereConditions.Where(c => !string.IsNullOrEmpty(c))));
            }

            return builder.ToString();
        }

        private void AddFilter(string column, string filterOperator, object valueToFilter)
        {
            Ensure.String.IsNotNullOrWhiteSpace(column, nameof(column));
            Ensure.String.IsNotNullOrWhiteSpace(filterOperator, nameof(filterOperator));
            EnsureArg.IsNotNull(valueToFilter, nameof(valueToFilter));

            var paramName = _parametersSql.GetNextParameterName();
            _parametersSql.Add(paramName, valueToFilter);

            _whereConditions.Add(string.Concat(column, filterOperator, paramName));
        }

        private void ResetAllVariables()
        {
            _selectColums = new List<string>();
            _dataSource = null;
            _whereConditions = new List<string>();
            _parametersSql = new ParametersSqlQuery();
            _isDistinct = false;
        }
    }
}
