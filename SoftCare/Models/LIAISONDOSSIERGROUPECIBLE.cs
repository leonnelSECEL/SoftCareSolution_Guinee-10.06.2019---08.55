using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("LIAISONDOSSIERGROUPECIBLE")]
    public class LIAISONDOSSIERGROUPECIBLE
    {
        public String LiaisonDossierGroupeCibleID { get; set; }
        public virtual DOSSIER Dossier { get; set; }
        public virtual GROUPECIBLE GC { get; set; }
        public DateTime DateIntegration { get; set; }
        public DateTime DateDepart { get; set; }
        public Boolean Actif { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }

    }
}