using Microsoft.AspNetCore.SignalR;
using System.Text.Json;
using System.Threading.Tasks;
using VideoCommunication.API.Models;

namespace VideoCommunication.API.Controllers
{
    public class VideoController : Hub
    {
        public async Task NewUser(string username)
        {
          //  var userInfo = new UserInfo() { userName = username, connectionId = Context.ConnectionId };
            var test = new { userName = username, connectionId = Context.ConnectionId };
            await Clients.Others.SendAsync("NewUserArrived", JsonSerializer.Serialize(test));
        }

        public async Task HelloUser(string userName, string user)
        {
            //  var userInfo = new UserInfo() { userName = username, connectionId = Context.ConnectionId };
            var test = new { userName = userName, connectionId = Context.ConnectionId };
            await Clients.Client(user).SendAsync("UserSaidHello", JsonSerializer.Serialize(test));
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
    }
}
