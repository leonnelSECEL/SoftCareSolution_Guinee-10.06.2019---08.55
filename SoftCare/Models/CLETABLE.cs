using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("CLETABLE")]
    public class CLETABLE
    {
        public int CleTableID { get; set; }
        public String NomTable { get; set; }
        public String DesignationTable { get; set; }
    }
}