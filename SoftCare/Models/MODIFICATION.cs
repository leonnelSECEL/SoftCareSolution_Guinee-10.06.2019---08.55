using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("MODIFICATION")]
    public class MODIFICATION
    {
        public String ModificationID { get; set; }
        public virtual DOSSIER Dossier { get; set; }
        [Required]
        public DateTime DateModification { get; set; }
        public virtual UTILISATEUR Auteur { get; set; }

    }
}