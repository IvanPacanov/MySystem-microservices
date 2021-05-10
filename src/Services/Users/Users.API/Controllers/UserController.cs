using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Users.Application.Features.Users.Commands.CreateUser;
using Users.Application.Features.Users.Commands.DeleteUser;
using Users.Application.Features.Users.Commands.UpdateUser;
using Users.Application.Features.Users.Queries.GetUsersList;

namespace Users.API.Controllers
{
    [ApiController]
    [Route("ap/v1/[controller]")]
    public class UserController  : ControllerBase
    {
        private readonly IMediator _mediator;

        public UserController(IMediator mediator)
        {
            _mediator = mediator ?? throw new ArgumentNullException(nameof(mediator));
        }

        [HttpGet("{userName}", Name = "GetUser")]
        [ProducesResponseType(typeof(UserVm), (int)HttpStatusCode.OK)]
        public async Task<ActionResult<UserVm>> GetUserByUserName(string userName)
        {
            var query = new GetUsersListQuery(userName);
            var user = await _mediator.Send(query);
            return Ok(user);
        }

        [HttpPost("[action]")]
        [ProducesResponseType((int)HttpStatusCode.OK)]
        public async Task<ActionResult<int>> CreateUser([FromBody] CreateUserCommand command)
        {            
            var result = await _mediator.Send(command);
            return Ok(result);
        }

        [HttpPost("[action]")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesDefaultResponseType]
        public async Task<ActionResult> UpdateUser([FromBody] UpdateUserCommand command)
        {
            var result = await _mediator.Send(command);
            return NoContent();
        }


        [HttpDelete("{id}", Name = "DeleteUser")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesDefaultResponseType]
        public async Task<ActionResult> DeleteUser(int id)
        {
            var command = new DeleteUserCommand() { Id = id };
            var result = await _mediator.Send(command);
            return NoContent();
        }
    }
}
