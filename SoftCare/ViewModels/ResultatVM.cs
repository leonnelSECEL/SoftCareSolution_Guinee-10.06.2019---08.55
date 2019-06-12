using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ResultatVM 
    {
        public String Id { get; set; }
        public String ExamenId { get; set; }
        public String ExamenDetailsId { get; set; }
        public String Examen { get; set; }
        [Display(Name = " Type Examen")]
        public String ExamenType { get; set; }
        public String Patient { get; set; }
        public String Description { get; set; }
        [Display(Name = " Reférence Examen")]
        public String ReferenceExam { get; set; }
        public String Reference { get; set; }
        public String Medecin { get; set; }
        public Boolean EstNegatif { get; set; }
        public DateTime DateCreation { get; set; } 

        public List<ExamenDetailsVM> Examens { get; set; }
    }
}