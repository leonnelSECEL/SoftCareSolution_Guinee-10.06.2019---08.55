using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class RendezVousVM4
    {
        [Required]
        public String DossierId { get; set; }
        [Required]
        public String SpecialisteID { get; set; }
        public String nomPatient { get; set; }
        public String nomSpecialiste { get; set; }
        public String ObjetRDV { get; set; }
        public DateTime Horaire { get; set; }
    }
}