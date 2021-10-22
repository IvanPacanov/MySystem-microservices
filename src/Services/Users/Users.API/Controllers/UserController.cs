using AutoMapper;
using EventBus.Messages.Events;
using MassTransit;
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
        private readonly IMapper _mapper;
        private readonly IPublishEndpoint _publishEndpoint;

        public UserController(IMediator mediator, IMapper mapper, IPublishEndpoint publishEndpoint)
        {
            _mediator = mediator;
            _mapper = mapper;
            _publishEndpoint = publishEndpoint;
        }

        [HttpGet("{userName}", Name = "GetUser")]
        [ProducesResponseType(typeof(UserVm), (int)HttpStatusCode.OK)]
        public async Task<ActionResult<UserVm>> GetUserByUserName(string userName)
        {
            var query = new GetUsersListQuery(userName);
            var user = await _mediator.Send(query);
            if(user == null)
            {
                return NotFound(userName);
            }
            var eventMessage = _mapper.Map<LoginCheckoutEvent>(user[0]);
            await _publishEndpoint.Publish(eventMessage);

            return Accepted();
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
