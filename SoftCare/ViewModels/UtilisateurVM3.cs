using SoftCare.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class UtilisateurVM3
    {
        public String Id { get; set; }
        public PersonneVM InfosPersonne { get; set; }
        public UtilisateurVM InfosConnexion { get; set; }
        public ROLE Role { get; set; }
    }
}