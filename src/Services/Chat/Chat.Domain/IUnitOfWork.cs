
using System.Threading.Tasks;

namespace Chat.Domain
{
    public interface IUnitOfWork
    {
        Task Save();
    }
}
