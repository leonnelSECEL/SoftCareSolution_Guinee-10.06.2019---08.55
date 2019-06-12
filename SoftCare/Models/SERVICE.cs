using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("SERVICE")]
    public class SERVICE
    {
        public String ServiceID { get; set; }
        public String Nom { get; set; }
        public DateTime DateCreation { get; set; }
    }
}