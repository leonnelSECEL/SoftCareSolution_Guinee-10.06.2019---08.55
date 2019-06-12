using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("DOSSIER")]
    public class DOSSIER
    {
        public String DossierID { get; set; }
        public virtual UTILISATEUR Createur { get; set; }
        public virtual PERSONNE Patient { get; set; }
        public String Code { get; set; }
        [Required]
        public DateTime DateCreation { get; set; }
        public Boolean Locked { get; set; }
        public Boolean Archived { get; set; }
        public DateTime DateArchivage { get; set; }
        public String PenseBete { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }


    }
}