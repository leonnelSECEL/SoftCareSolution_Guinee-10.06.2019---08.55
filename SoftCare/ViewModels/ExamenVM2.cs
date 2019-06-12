using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ExamenVM2
    {
        public String Id { get; set; }
        public String ExamenTypeId { get; set; }
        [Display(Name = " Type Examen")]
        public String ExamenType { get; set; }
        public String DossierId { get; set; }
        public String MedecinId { get; set; }
        public String ServiceId { get; set; }
        public String CodeDossier { get; set; }
        public String Service { get; set; }
        public String Description { get; set; }
        public String Reference { get; set; }
        public String Patient { get; set; }
        public String Medecin { get; set; }
        [Display(Name = " Prix Examen")]
        public decimal PrixExamen { get; set; }
        [Display(Name = " Date Examen")]
        public DateTime DateExamen { get; set; }
        [Display(Name = " Est Réalisé")]
        public Boolean EstRealise { get; set; }


        public List<ExamenDetailsVM> Examens { get; set; }
    }
}