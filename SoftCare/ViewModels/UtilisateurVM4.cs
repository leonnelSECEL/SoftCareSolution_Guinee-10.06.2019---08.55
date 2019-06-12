using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class UtilisateurVM4
    {
        public String Id { get; set; }
        public Boolean Actif { get; set; }
        public String NomUtilisateur { get; set; }
        public String Contact { get; set; }
        public String Role { get; set; }
        public DateTime DateCreation { get; set; }
    }
}