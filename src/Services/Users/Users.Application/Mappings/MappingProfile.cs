using AutoMapper;
using System;
using System.Collections.Generic;
using System.Text;
using Users.Application.Features.Users.Commands.CreateUser;
using Users.Application.Features.Users.Commands.UpdateUser;
using Users.Application.Features.Users.Queries.GetUsersList;
using Users.Domain.Entities;

namespace Users.Application.Mappings
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<User, UserVm>().ReverseMap();
            CreateMap<User, CreateUserCommand>().ReverseMap();
            CreateMap<User, UpdateUserCommand>().ReverseMap();
        }
    }
}
