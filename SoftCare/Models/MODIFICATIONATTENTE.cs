using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("MODIFICATIONATTENTE")]
    public class MODIFICATIONATTENTE
    {
        public String ModificationAttenteID { get; set; }
        public virtual UTILISATEUR AncienSpecialiste { get; set; }
        public virtual UTILISATEUR NouveauSpecialiste { get; set; }
        public virtual ATTENTE Attente { get; set; }
        [Required]
        public DateTime DateModification { get; set; }
        [Required]
        public String Motif { get; set; }
    }
}