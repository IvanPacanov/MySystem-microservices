
using AutoMapper;
using EventBus.Messages.Events;

namespace Authentication.API.Mapping
{
    public class UserProfile : Profile
    {
        public UserProfile()
        {
            CreateMap<UserVm, LoginCheckoutEvent>().ReverseMap();
        }
    }
}
