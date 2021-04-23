using MediatR;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Threading;
using Users.Application.Contracts.Persistence;
using AutoMapper;

namespace Users.Application.Features.Users.Queries.GetUsersList
{
    public class GetUsersListQuertHandler : IRequestHandler<GetUsersListQuery, List<UserVm>>
    {
        private readonly IUserRepository _userRepository;
        private readonly IMapper _mapper;

        public GetUsersListQuertHandler(IUserRepository userRepository, IMapper mapper)
        {
            _userRepository = userRepository ?? throw new ArgumentNullException(nameof(userRepository));
            this._mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        public async Task<List<UserVm>> Handle(GetUsersListQuery request, 
            CancellationToken cancellationToken)
        {

            // Don't forget to define MappingProfille -> I created it in the Mappings folder. Because if, it's not defined, we getting the mapping error.
            var usersList = await _userRepository.GetUsersByUserName(request.UserName);
            return _mapper.Map<List<UserVm>>(usersList);
        }
    }
}
