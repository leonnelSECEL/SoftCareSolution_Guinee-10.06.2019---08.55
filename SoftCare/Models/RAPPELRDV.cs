using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("RAPPELRDV")]
    public class RAPPELRDV
    {
        public String RappelRdvID { get; set; }
        public virtual RENDEZVOUS Rdv { get; set; }
        [Required]
        public DateTime DateRappel { get; set; }



    }
}