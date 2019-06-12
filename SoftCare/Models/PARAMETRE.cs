using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("PARAMETRE")]
    public class PARAMETRE
    {
        public String ParametreID { get; set; }
        public virtual DOSSIER Dossier { get; set; }
        public string Tension { get; set; }
        public Double Temperature { get; set; }
        public Double Pouls { get; set; }
        public Double Poids { get; set; }
        public string Avis { get; set; }
        [Required]
        public DateTime DatePrise { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }


    }
}