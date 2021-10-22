using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.Common.CQRS
{
    public interface ICommandDispatcher
    {
        Task Dispatch<TCommand>(TCommand command) where TCommand : ICommand;
    }
}
