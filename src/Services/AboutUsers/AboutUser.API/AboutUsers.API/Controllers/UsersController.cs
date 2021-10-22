using AboutUsers.Common.CQRS;
using Microsoft.AspNetCore.Mvc;
using EnsureThat;
using System.Threading.Tasks;
using AboutUsers.PublishedLanguage.Queries;
using AboutUsers.PublishedLanguage.Dots;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;
using AboutUsers.PublishedLanguage.Commands;

namespace AboutUsers.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly IQueryDispatcher _queryDispatcher;
        private readonly ICommandDispatcher _commandDispatcher;

        public UsersController(IQueryDispatcher queryDispatcher, ICommandDispatcher commandDispatcher)
        {
            EnsureArg.IsNotNull(queryDispatcher, nameof(queryDispatcher));
            EnsureArg.IsNotNull(commandDispatcher, nameof(commandDispatcher));


            _queryDispatcher = queryDispatcher;
            _commandDispatcher = commandDispatcher;
        }

     //   [Authorize(Policies.Consumer)]
        [HttpGet("users")]
        public async Task<IActionResult> GetUserInfo([FromQuery] UserParameters userParameters)
        {
            UserDTO list =  await _queryDispatcher.Dispatch(userParameters);
            return Ok(list);
        }

        [HttpGet("mesagess")]
        public async Task<IActionResult> GetMesages([FromQuery] MessagesParameters messagesParameters)
        {
            List<MessageDTO> list = await _queryDispatcher.Dispatch(messagesParameters);
            return Ok(list);
        }
        [HttpPut("usersFriend")]
        public async Task<IActionResult> AddNewFriend([FromBody] AddNewFriendCommand userParameters)
        {
            await _commandDispatcher.Dispatch(userParameters);
            return Ok();
        }

    }
}
