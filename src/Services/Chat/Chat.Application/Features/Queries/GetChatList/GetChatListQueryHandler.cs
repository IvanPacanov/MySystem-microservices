using AutoMapper;
using Chat.Application.Contracts.Persistence;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Chat.Application.Features.Queries.GetChatList
{
    public class GetChatListQueryHandler : IRequestHandler<GetChatListQuery, List<ChatsVm>>
    {
        private readonly IChatRepository _chatRepository;
        private readonly IMapper _mapper;

        public GetChatListQueryHandler(IChatRepository chatRepository, IMapper mapper)
        {
            _chatRepository = chatRepository ?? throw new ArgumentNullException(nameof(chatRepository));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        public async Task<List<ChatsVm>> Handle(GetChatListQuery request, CancellationToken cancellationToken)
        {
            var chatList = await _chatRepository.GetChatsByUserName(request.UserName);
            return _mapper.Map<List<ChatsVm>>(chatList);
        }
    }
}
