using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("TYPEGROUPE")]
    public class TYPEGROUPE
    {
        public String TypeGroupeID { get; set; }
        public String Objet { get; set; }

        

    }
}