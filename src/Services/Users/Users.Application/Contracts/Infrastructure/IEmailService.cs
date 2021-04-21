
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Users.Application.Models;

namespace Users.Application.Contracts.Infrastructure
{
    public interface IEmailService
    {
        Task<bool> SendEmail(Email email);
    }
}
