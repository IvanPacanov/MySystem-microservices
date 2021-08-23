using Microsoft.AspNetCore.SignalR;
using System.Collections.Generic;
using System.Text.Json;
using System.Threading.Tasks;
using System.Linq;
using VideoCommunication.API.Models;
using System;

namespace VideoCommunication.API.Hubs
{
    public class CallOffer
    {
        public User Caller { get; set; }
        public User Callee { get; set; }
    }

    public class User
    {
        public string Username { get; set; }
        public string ConnectionId { get; set; }
        public bool InCall { get; set; }
        public List<User> FriendList { get; set; }
    }

    public class UserCall
    {
        public List<User> Users { get; set; }
    }



    public interface IHub
    {
        public Task LogginUser(string userName);
    }
    public class HubController : Hub, IHub
    {

        private readonly List<User> _Users = new List<User>() {

        new User(){
            Username = "guest",
            ConnectionId = "sdfsadewr",
        FriendList = new List<User>(){ new User() { Username = "Admin" } }
        } };


        private readonly List<UserCall> _UserCalls;
        private readonly List<CallOffer> _CallOffers;

        public HubController(List<User> users, List<UserCall> userCalls, List<CallOffer> callOffers)
        {
            _Users = new List<User>() {

        new User(){
            Username = "guest",
            ConnectionId = "sdfsadewr",
        FriendList = new List<User>(){ new User() { Username = "Admin" } }
        } };
            _UserCalls = userCalls;
            _CallOffers = callOffers;
        }

        public async Task LogginUser(string username)
        {
            string c = Context.ConnectionId;
            _Users.Add(new User
            {
                Username = username,
                ConnectionId = c,
                FriendList = new List<User>()

            }) ;
         //   await Clients.All.SendAsync("AnswerAfterLoggin", "Powitanko");
            // Send down the new list to all clients
            await SendUserListUpdate(username, c);
        }

        public async Task loginToSignalR(string user)
        {
            //  var userInfo = new UserInfo() { userName = username, connectionId = Context.ConnectionId };
            var test = new { userName = user, connectionId = Context.ConnectionId };
            await Clients.All.SendAsync("AnswerAfterLoggin", JsonSerializer.Serialize(test));
            await Clients.Client(user).SendAsync("OnlineUser");
        }

        public async Task SendSignal(string signal, string user)
        {
            await Clients.Client(user).SendAsync("SendSignal", Context.ConnectionId, signal);
        }

        public override async Task OnDisconnectedAsync(System.Exception exception)
        {
            await Clients.All.SendAsync("UserDisconnect", Context.ConnectionId);
            await base.OnDisconnectedAsync(exception);
        }

        private async Task SendUserListUpdate(string username, string c)
        {

                var a = _Users.Where(p => p.ConnectionId != null && p.FriendList.Any(k => k.Username == username)).Select(c => new { c.Username, c.ConnectionId }).ToList();
    
                
            await Clients.Client(c).SendAsync("LogginUser", JsonSerializer.Serialize(a));
        }

        private UserCall GetUserCall(string connectionId)
        {
            var matchingCall =
                _UserCalls.SingleOrDefault(uc => uc.Users.SingleOrDefault(u => u.ConnectionId == connectionId) != null);
            return matchingCall;
        }
    }
}
