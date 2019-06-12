using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("VISITEPRENATALE")]
    public class VISITEPRENATALE
    {
        public String VisitePrenataleID { get; set; }
        public virtual GROSSESSE Grossesse { get; set; }
        public virtual RENDEZVOUS Rdv { get; set; }
        public String Observation { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }

    }
}