using AutoMapper;
using EventBus.Messages.Events;
using MassTransit;
using System.Text.Json;
using MediatR;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VideoCommunication.API.Hubs;

namespace VideoCommunication.API.EventBusConsumer
{
    public class CheckeLoggedConsumer : Hub, IConsumer<LoginCheckoutEvent>
    {
        private readonly IMapper _mapper;
        private readonly ILogger<CheckeLoggedConsumer> _logger;
        private readonly IConnectionHub _hub;

        public CheckeLoggedConsumer(IMapper mapper, ILogger<CheckeLoggedConsumer> logger, IConnectionHub hub)
        {
            _mapper = mapper;
            _logger = logger;
            _hub = hub;
        }

        public async Task Consume(ConsumeContext<LoginCheckoutEvent> context)
        {
            //await _hub.NewUser(context.Message.Username);
        }
    }
}
