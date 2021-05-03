 using FluentValidation.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Users.Application.Exceptions
{
    public class ValidationException : ApplicationException
    {
        public ValidationException()
            :base("One pr more validation failures gave occurred.")
        {
            Errors = new Dictionary<string, string[]>();
        }

        public ValidationException(IEnumerable<ValidationFailure> failures)
           : this()
        {
            Errors = failures
                .GroupBy(e => e.PropertyName, e => e.ErrorMessage)
                .ToDictionary(failureGroup => failureGroup.Key, failureGroup => failureGroup.ToArray());
                
        }

        public IDictionary<string, string[]> Errors { get; }
    }
}
