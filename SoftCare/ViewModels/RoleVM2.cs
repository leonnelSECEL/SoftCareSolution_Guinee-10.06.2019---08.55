using SoftCare.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class RoleVM2
    {
        [Required]
        public String RoleID { get; set; }
        [Required]
        [Display(Name="Intitulé du rôle")]
        public String Intitule { get; set; }
        [Display(Name = "Ajouté le")]
        public String DateCreation { get; set; }
        public Boolean Actif { get; set; }
        [Display(Name = "Nombre d'utilisateurs associés")]
        public int taille { get; set; }

        public int[] TableauPrivilegeId { get; set; }
        public List<PRIVILEGE> ListePrivileges { get; set; }
        
    }
}