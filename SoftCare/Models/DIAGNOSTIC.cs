using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("DIAGNOSTIC")]
    public class DIAGNOSTIC
    {
        public String DiagnosticId { get; set; }
        public virtual UTILISATEUR Auteur { get; set; }
        public virtual DOSSIER Dossier { get; set; }
        public virtual MALADIE Maladie { get; set; }
        [Required]
        public DateTime DateDiagnostic { get; set; }
        [Required]
        public string Avis { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }


    }
}