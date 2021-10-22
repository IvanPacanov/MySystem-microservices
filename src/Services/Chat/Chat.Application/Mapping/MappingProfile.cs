using AutoMapper;
using Chat.Application.Features.Queries.GetChatList;
using Chat.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Chat.Application.Mapping
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Chats, ChatsVm>().ReverseMap();
        }
    }
}
