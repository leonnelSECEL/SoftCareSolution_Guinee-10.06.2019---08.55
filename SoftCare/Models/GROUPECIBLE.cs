using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("GROUPECIBLE")]
    public class GROUPECIBLE
    {
        public String GroupeCibleID { get; set; }
        public String Code { get; set; }
        public String Objet { get; set; }
        public String Intitule { get; set; }
        public Boolean Closed { get; set; }
        public Boolean Archived { get; set; }
        public DateTime DateCreationGroupe { get; set; }
        public DateTime DateClotureGroupe { get; set; }
        public DateTime DateArchivageGroupe { get; set; }
        public virtual TYPEGROUPE Type { get; set; }
        public virtual UTILISATEUR Administrateur { get; set; }
        public virtual UTILISATEUR Createur { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }

    }
}