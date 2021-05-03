using MediatR;

namespace Users.Application.Features.Users.Commands.DeleteUser
{
   public class DeleteUserCommand : IRequest
    {
        public int Id { get; set; }
    }
}
