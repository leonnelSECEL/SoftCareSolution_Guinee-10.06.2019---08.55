using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ExamenMedicalVM
    {
        public String Id { get; set; }
        public String ExamenTypeId { get; set; }
        [Display(Name = " Type Examen")]
        public String ExamenType { get; set; }
        public String Code { get; set; }
        public String Libele { get; set; }
        public String Description { get; set; }
        public decimal Prix { get; set; }
        [Display(Name = " Date de ceation")]
        public DateTime DateCreation { get; set; }
    }
}

