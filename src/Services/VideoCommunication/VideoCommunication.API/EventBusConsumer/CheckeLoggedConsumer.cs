using AutoMapper;
using EventBus.Messages.Events;
using MassTransit;
using MediatR;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace VideoCommunication.API.EventBusConsumer
{
    public class CheckeLoggedConsumer : IConsumer<LoginCheckoutEvent>
    {
        private readonly IMapper _mapper;
        private readonly ILogger<CheckeLoggedConsumer> _logger;

        public CheckeLoggedConsumer(IMapper mapper, ILogger<CheckeLoggedConsumer> logger)
        {
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public Task Consume(ConsumeContext<LoginCheckoutEvent> context)
        {
            Console.WriteLine("Elo mordeczko to do zrobienia jeszcze!");
            return null;
        }
    }
}
