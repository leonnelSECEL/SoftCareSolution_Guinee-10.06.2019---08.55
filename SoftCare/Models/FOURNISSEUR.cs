using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("FOURNISSEUR")]
    public class FOURNISSEUR
    {
        public String FournisseurID { get; set; }
        public String CodeCompte { get; set; }
        public String Nom { get; set; }
        public String Adresse { get; set; }
        public String Telephone { get; set; }
        public String Fax { get; set; }
        public String Email { get; set; }
        public String EstActif { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}