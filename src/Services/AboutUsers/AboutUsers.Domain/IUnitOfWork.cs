using System.Threading.Tasks;

namespace AboutUsers.Domain
{
    public interface IUnitOfWork
    {
        Task Save();
    }
}
