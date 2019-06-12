using System.ComponentModel.DataAnnotations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class TraitementVM3
    {
        public String Id { get; set; }
        public String DossierID { get; set; }
        public String DiagnosticId { get; set; }
        [Display(Name = "Diagnostic médical")]
        public String Diagnostic { get; set; }
        [Display(Name = "Nom du patient")]
        public String NomPatient { get; set; }
        [Display(Name = "Spécialiste ayant émis le diagnostic")]
        public String SpecialisteDiagnostic { get; set; }
        [Display(Name = "Spécialiste émettant le traitement")]
        [Required]
        public String SpecialisteTraitement { get; set; }
        [Required]
        [Display(Name = "Traitement recommandé")]
        public string Traitement { get; set; }

        public List<TraitementVM> Traitements { get; set; }
    }
}