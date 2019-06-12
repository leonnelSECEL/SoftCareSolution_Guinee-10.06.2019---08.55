using System;
using System.ComponentModel.DataAnnotations;

namespace SoftCare.ViewModels
{
    public class TraitementVM2
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

    }
}