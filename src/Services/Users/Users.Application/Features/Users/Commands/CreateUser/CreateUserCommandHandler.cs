using AutoMapper;
using MediatR;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Users.Application.Contracts.Infrastructure;
using Users.Application.Contracts.Persistence;
using Users.Application.Models;
using Users.Domain.Entities;

namespace Users.Application.Features.Users.Commands.CreateUser
{
    public class CreateUserCommandHandler : IRequestHandler<CreateUserCommand, int>
    {
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;
        private readonly IEmailService _emailService;
        private readonly ILogger<CreateUserCommandHandler> _logger;

        public CreateUserCommandHandler(IUserRepository userRepository, IMapper mapper, IEmailService emailService, ILogger<CreateUserCommandHandler> logger)
        {
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _emailService = emailService ?? throw new ArgumentNullException(nameof(emailService));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public async Task<int> Handle(CreateUserCommand request, CancellationToken cancellationToken)
        {
            var userEntity = _mapper.Map<User>(request);
            var newUser = await _userRepository.AddAsync(userEntity);

            _logger.LogInformation($"User {newUser.Id} is success fully created.");
            await SendMail(newUser);

            return newUser.Id;
        }

        private async Task SendMail(User newUser)
        {
            var email = new Email() { To = newUser.EmailAddress, Body = $"Account was created.", Subject = $"Welcom on Communicator" };

            try
            {
                await _emailService.SendEmail(email);
            }
            catch (Exception e)
            {
                _logger.LogError($"New user {newUser.Id} failed due to an error with the mail services: {e.Message}");
            }
        }
    }
}
