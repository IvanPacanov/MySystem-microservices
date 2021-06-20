using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chat.Application.Features.Queries.GetChatList
{
    public class GetChatListQuery : IRequest<List<ChatsVm>>
    {
        public string UserName { get; set; }

        public GetChatListQuery(string userName)
        {
            UserName = userName ?? throw new ArgumentNullException(nameof(userName));
        }
    }
}
