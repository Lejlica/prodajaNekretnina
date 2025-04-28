using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IAgentService : ICRUDService<Model.Agent, Model.SearchObjects.AgentSearchObject, Model.Requests.AgentInsertRequest, Model.Requests.AgentUpdateRequest>
    {
       
    }
}
