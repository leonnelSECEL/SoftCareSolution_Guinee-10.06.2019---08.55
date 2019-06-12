using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("RENDEZVOUS")]
    public class RENDEZVOUS
    {
        public String RendezVousID { get; set; }
        public virtual DOSSIER Recepteur { get; set; }
        public virtual UTILISATEUR Emetteur { get; set; }
        [Required]
        public DateTime Horaire { get; set; }
        public String Commentaire { get; set; }
        [Required]
        public Boolean Recu { get; set; }
        [Required]
        public Boolean Actif { get; set; }
        [Required]
        public Boolean Manque { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }


    }
}