using SoftCare.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ParametreVM2
    {
        public String Id { get; set; }
        public String DossierID { get; set; }
        public String CodeDossier { get; set;}
        [Display(Name = "Température (°C) ")]
        public float Temperature { get; set; }
        public float Pouls { get; set; }
        [RegularExpression("^([0-9]{3}/[0-9]{2})$")]
        public String Tension { get; set; }
        [Display(Name = "Poids (Kg)")]
        public float Poids { get; set; }
        [Display(Name = "Avis de l'infirmière")]
        public string Avis { get; set; }
        [Display(Name = "Nom du patient")]
        public String Patient { get; set; }
        public Boolean isArchived { get; set; }
        public List<PARAMETRE> ListeParametres { get; set; }
    }
}