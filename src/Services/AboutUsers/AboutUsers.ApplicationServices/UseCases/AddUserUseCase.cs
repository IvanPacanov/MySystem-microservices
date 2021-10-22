using AboutUsers.ApplicationServices.Boundaries.Users;
using AboutUsers.Common.CQRS;
using AboutUsers.Domain;
using AboutUsers.Domain.Users;
using AboutUsers.PublishedLanguage.Commands;
using System.Threading.Tasks;

namespace AboutUsers.ApplicationServices.UseCases
{
    public class AddUserUseCase : ICommandHandler<AddUserCommand>
    {
        private readonly IUserRepository _userRepository;
        private readonly IUnitOfWork _unitOfWork;

        public AddUserUseCase(IUserRepository userRepository, IUnitOfWork unitOfWork)
        {
            _userRepository = userRepository;
            _unitOfWork = unitOfWork;
        }

        public async Task Handle(AddUserCommand command)
        {
            _userRepository.EnsureThatUserDoesNotExist(command.UserName);
            _userRepository.Store(new User(command.UserName ));
            await _unitOfWork.Save();
        }
    }
}
