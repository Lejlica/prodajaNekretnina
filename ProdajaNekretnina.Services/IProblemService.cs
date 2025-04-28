using ProdajaNekretnina.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProdajaNekretnina.Services
{
    public interface IProblemService : ICRUDService<Model.Problem, Model.SearchObjects.ProblemiSearchObject, Model.Requests.ProblemInsertRequest, Model.Requests.ProblemUpdateRequest>
    {
       
    }
}
