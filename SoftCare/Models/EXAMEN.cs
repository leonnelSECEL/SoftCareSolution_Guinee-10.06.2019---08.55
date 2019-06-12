using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("EXAMEN")]
    public class EXAMEN
    {
        public String ExamenID { get; set; }
        public virtual EXAMENTYPE ExamenType { get; set; }
        public virtual DOSSIER Dossier { get; set; }
        public virtual UTILISATEUR Utilisateur { get; set; }
        public virtual SERVICE Service { get; set; }
        public virtual DIAGNOSTIC Diagnostic { get; set; }
        public String Reference { get; set; }
        public Boolean EstRealise { get; set; }
        public DateTime DateExamen { get; set; }
        public String Description { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}