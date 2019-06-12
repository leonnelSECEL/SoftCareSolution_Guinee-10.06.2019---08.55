using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class UtilisateurVM
    {
        [Required]
        public string Login { get; set; }
        [Required]
        [StringLength(180, ErrorMessage = "Le mot de passe doit comporter au moins {2} caractères.", MinimumLength = 1)]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        public string Fonction { get; set; }
        public Boolean Actif { get; set; }
    }
}