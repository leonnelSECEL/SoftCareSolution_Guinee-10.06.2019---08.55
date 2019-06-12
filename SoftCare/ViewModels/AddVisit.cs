using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class AddVisit
    {
        [Required]
        public String GrossesseID { get; set; }
        [Required]
        public DateTime DateVisite { get; set; }
        [Required]
        public String SpecialisteID { get; set; }
    }
}