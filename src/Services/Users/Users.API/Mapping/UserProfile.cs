using AutoMapper;
using EventBus.Messages.Events;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Users.Application.Features.Users.Queries.GetUsersList;

namespace Users.API.Mapping
{
    public class UserProfile : Profile
    {
        public UserProfile()
        {
            CreateMap<UserVm, LoginCheckoutEvent>().ReverseMap();
        }
    }
}
