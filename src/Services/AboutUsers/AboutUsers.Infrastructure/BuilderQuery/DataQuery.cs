using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.Infrastructure.BuilderQuery
{
   public class DataQuery<T>
    {
        private readonly IDbConnection _connection;

        public DataQuery(IDbConnection connection, string query, DynamicParameters parameters)
        {
            _connection = connection;

            Query = query;
            Parameters = parameters;
        }

        public string Query { get; }

        public DynamicParameters Parameters { get; }

        public async Task<List<T>> ExecuteToList()
        {
            var result = await _connection.QueryAsync<T>(Query, Parameters);

            return result.ToList();
        }

        public async Task<T> ExecuteToFirstElement()
        {
            return await _connection.QueryFirstOrDefaultAsync<T>(Query, Parameters);
        }

        public async Task<T> ExecuteSingle()
        {
            return await _connection.QuerySingleAsync<T>(Query, Parameters);
        }
    }
}
