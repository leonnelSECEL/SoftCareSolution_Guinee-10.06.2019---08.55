using System;
using System.ComponentModel.DataAnnotations;

namespace SoftCare.ViewModels
{
    public class TraitementVM2
    {
        public String Id { get; set; }
        public String DossierID { get; set; }
        public String DiagnosticId { get; set; }
        [Display(Name = "Diagnostic m�dical")]
        public String Diagnostic { get; set; }
        [Display(Name = "Nom du patient")]
        public String NomPatient { get; set; }
        [Display(Name = "Sp�cialiste ayant �mis le diagnostic")]
        public String SpecialisteDiagnostic { get; set; }
        [Display(Name = "Sp�cialiste �mettant le traitement")]
        [Required]
        public String SpecialisteTraitement { get; set; }
        [Required]
        [Display(Name = "Traitement recommand�")]
        public string Traitement { get; set; }

    }
}