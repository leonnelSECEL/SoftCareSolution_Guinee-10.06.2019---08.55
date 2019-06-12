using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;


namespace SoftCare.Models
{
    [Table("PRIVILEGE")]
    public class PRIVILEGE
    {
        public int PrivilegeID { get; set; }
        [Display(Name = "Action à Effectuer")]
        public String ActionName { get; set; }
        public String Controller { get; set; }
        public String Peut { get; set; }
        public String Libelle { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }
    }
}