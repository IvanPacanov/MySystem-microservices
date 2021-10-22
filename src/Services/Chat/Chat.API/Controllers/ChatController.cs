using Chat.Application.Features.Queries.GetChatList;
using Chat.Domain.Entities;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;

namespace Chat.API.Controllers
{
    [ApiController]
    [Route("ap/v1/[controller]")]
    public class ChatController : ControllerBase
    {
        private readonly IMediator _mediator;

        public ChatController(IMediator mediator)
        {
            _mediator = mediator ?? throw new ArgumentNullException(nameof(mediator));
        }

        [HttpGet("{userName}", Name = "GetChatsForUser")]
        [ProducesResponseType(typeof(List<Chats>), (int)HttpStatusCode.OK)]
        public async Task<ActionResult<List<Chats>>> GetChatsForUser(string userName)
        {
            var query = new GetChatListQuery(userName);
            var result = await _mediator.Send(query);
            return Ok(result);
        }
    }
}
