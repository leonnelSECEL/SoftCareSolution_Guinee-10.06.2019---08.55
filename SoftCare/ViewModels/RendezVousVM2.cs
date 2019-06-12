using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class RendezVousVM2
    {
        [Required]
        public String DossierId { get; set; }
        [Required]
        public String SpecialisteID { get; set; }
        [Required]
        public int heureRDV { get; set; }
        [Required]
        public int minuteRDV { get; set; }
        [Required]
        public DateTime dateRDV { get; set; }
        [Display(Name = "Nom du patient à recevoir")]
        public String nomPatient { get; set; }
        [Display(Name = "Objet de la rencontre")]
        public String ObjetRDV { get; set; }
        public Boolean verified { get; set; }
        public DateTime Horaire { get; set; }
    }
}