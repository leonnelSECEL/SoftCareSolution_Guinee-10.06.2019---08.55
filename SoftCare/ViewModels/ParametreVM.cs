using System;
using System.ComponentModel.DataAnnotations;

namespace SoftCare.ViewModels
{
    public class ParametreVM
    {
        public String Id { get; set; }
        public String DossierID { get; set; }
        [Display(Name = "Température (°C)")]
        public float Temperature { get; set; }
        public float Pouls { get; set; }
        //[RegularExpression("^([0-9]{3}/[0-9]{2})$")]
        public String Tension { get; set; }
        [Display(Name = "Poids (Kg)")]
        public float Poids { get; set; }
        [Display(Name = "Motif de la visite")]
        public string Avis { get; set; }
        public String SpecialisteID { get; set; }
        public String CleIdentity { get; set; }

    }
}