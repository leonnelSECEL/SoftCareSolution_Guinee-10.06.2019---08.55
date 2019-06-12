using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class RoleVM
    {
        [Required]
        public String RoleID { get; set; }
        [Required]
        [Display(Name = "Intitulé du groupe")]
        public String Intitule { get; set; }
    }
}