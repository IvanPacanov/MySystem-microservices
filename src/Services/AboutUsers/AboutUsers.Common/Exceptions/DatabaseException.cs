using System;

namespace AboutUsers.Common.Exceptions
{
    public class DatabaseException : Exception
    {
        public DatabaseException(string message, Exception innerException)
            : base(message, innerException)
        {
        }
    }
}
