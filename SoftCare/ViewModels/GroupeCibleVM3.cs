using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class GroupeCibleVM3
    {
        public String Id { get; set; }
        [Display(Name = "Code du groupe")]
        public String Intitule { get; set; }
        public String Code { get; set; }
        [Display(Name = "Type de groupe")]
        public String Type { get; set; }
        [Display(Name = "Créé le")]
        public String DateCreationGroupe { get; set; }
        [Display(Name = "Clos le")]
        public String DateClotureGroupe { get; set; }
        [Display(Name = "Nombre de membres")]
        public int Taille { get; set; }
        [Display(Name = "Administré par")]
        public String Administrateur { get; set; }
    }
}