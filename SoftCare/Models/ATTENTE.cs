using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("ATTENTE")]
    public class ATTENTE
    {
        public String AttenteID { get; set; }
        public virtual UTILISATEUR Specialiste { get; set; }
        public virtual DOSSIER Patient { get; set; }
        [Required]
        public DateTime DateAttente { get; set; }
        [Required]
        public Boolean Etat { get; set; }
        [Required]
        public Boolean Statut { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }


    }
}