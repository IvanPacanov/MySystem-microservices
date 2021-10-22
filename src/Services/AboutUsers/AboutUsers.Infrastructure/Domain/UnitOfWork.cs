using AboutUsers.Common.Exceptions;
using AboutUsers.Domain;
using AboutUsers.Infrastructure.DataModel;
using EnsureThat;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.Infrastructure.Domain
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly AboutUserContext _context;

        public UnitOfWork(AboutUserContext context)
        {
            EnsureArg.IsNotNull(context, nameof(context));

            _context = context;
        }

        public async Task Save()
        {
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                throw new DatabaseException(ex.Message, ex.InnerException);
            }
        }
    }
}
