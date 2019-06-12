using SoftCare.ViewModels;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("TRAITEMENT")]
    public class TRAITEMENT
    {
        public String TraitementID { get; set; }
        public virtual UTILISATEUR Specialiste { get; set; }
        public virtual DIAGNOSTIC Diagnostic { get; set; }
        [Required]
        public DateTime DateTraitement { get; set; }
        [Required]
        public string Recommandation { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }


    }
}