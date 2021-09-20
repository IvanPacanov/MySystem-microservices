using AboutUsers.ApplicationServices.Boundaries.Users;
using AboutUsers.Common.CQRS;
using AboutUsers.Domain;
using AboutUsers.Domain.Users;
using AboutUsers.PublishedLanguage.Commands;
using AboutUsers.PublishedLanguage.Dots;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AboutUsers.ApplicationServices.UseCases
{
    public class AddNewFriendUseCase : ICommandHandler<AddNewFriendCommand>
    {
        private readonly IUserRepository _userRepository;
        private readonly IUnitOfWork _unitOfWork;
        private readonly IUserQuery _userQuery;

        public AddNewFriendUseCase(IUserRepository userRepository, IUnitOfWork unitOfWork, IUserQuery userQuery)
        {
            _userQuery = userQuery;
            _userRepository = userRepository;
            _unitOfWork = unitOfWork;
        }

        public async Task Handle(AddNewFriendCommand command)
        {
            var user = await _userRepository.GetUser(command.Id);
            var friend = await _userRepository.GetUser(command.UserName);
            if (friend != null)
            {
                user.FriendlyUsers.Add(new Friend { UserName = command.UserName, EnumRoleOfUser = Domain.Enum.EnumRoleOfUser.Family, messages = new List<Message>() });
                await _unitOfWork.Save();
            }else
                throw new ArgumentException("No find user");
        }
    }
}
