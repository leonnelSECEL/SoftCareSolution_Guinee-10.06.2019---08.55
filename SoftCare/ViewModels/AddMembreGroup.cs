using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class AddMembreGroup
    {
        [Required]
        public String IdGroupe{ get; set;}
        [Required]
        public String[] IdsMembresAAjouter { get; set; }
    }
}