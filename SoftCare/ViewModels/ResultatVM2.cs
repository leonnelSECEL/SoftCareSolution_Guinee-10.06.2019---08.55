using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ResultatVM2
    {
        public String Id { get; set; }
        public String ExamenId { get; set; }
        public Boolean EstNegatif { get; set; }
        public String Description { get; set; }
    }
}