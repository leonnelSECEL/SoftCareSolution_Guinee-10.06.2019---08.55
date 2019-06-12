using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ExamenDetailsVM
    {
        public String Id { get; set; }
        public String ExamId { get; set; }
        public String Code { get; set; }
        public String Libele { get; set; }
        public Boolean EstNegatif { get; set; }
        public String Description { get; set; }        
    }
}