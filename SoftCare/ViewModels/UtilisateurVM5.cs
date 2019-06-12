using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class UtilisateurVM5
    {
        public String Id { get; set; }
        public Boolean Actif { get; set; }
        [Display(Name = "Nom de l'utilisateur")]
        public String NomUtilisateur { get; set; }
        [Display(Name = "Login ou identifiant de connexion")]
        public String Login { get; set; }
        [Display(Name = "Mot de passe")]
        public String Password { get; set; }
        public String RoleID { get; set; }
    }
}