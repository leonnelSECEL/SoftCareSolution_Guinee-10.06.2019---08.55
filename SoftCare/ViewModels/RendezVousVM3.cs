using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class RendezVousVM3
    {
        public String rdvId { get; set; }
        [Display(Name = "Nom du patient")]
        public String nomPatient { get; set; }
        [Display(Name = "Spécialiste à rencontrer")]
        public String nomSpecialiste { get; set; }
        [Display(Name = "Objet du rendez-vous")]
        public String ObjetRDV { get; set; }
        [Display(Name = "Précedente horaire de rendez-vous")]
        public DateTime AncienHoraire { get; set; }
        [Display(Name = "Nouvelle date de rendez-vous")]
        [Required]
        public DateTime NouvelleHoraire { get; set; }
        [Display(Name = "Heure (entre 0 et 23)")]
        [Required]
        [Range(0, 23)]
        public int NouvelleHeure { get; set; }
        [Display(Name = "Minute (entre 0 et 59)")]
        [Required]
        [Range(0, 59)]
        public int NouvelleMinute { get; set; }
    }
}