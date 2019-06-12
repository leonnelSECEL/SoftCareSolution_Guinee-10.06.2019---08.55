using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class GroupeMaladieVM
    {
        [Required]
        public String GroupeMaladieID { get; set; }
        [Required]
        public String IntituleGroupe { get; set; }
        public String DateCreation { get; set; }

        public List<MaladieVM> ListMaladie { get; set; }
    }
}