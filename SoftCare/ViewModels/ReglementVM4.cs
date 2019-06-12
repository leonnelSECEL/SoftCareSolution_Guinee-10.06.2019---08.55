using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ReglementVM4
    {
        public String Id { get; set; }
        public String PatientId { get; set; }
        public String FactureId { get; set; }
        public String Patient { get; set; }
        public String Reglement { get; set; }
        public String Facture { get; set; }
        public decimal Montant { get; set; }
        public decimal Reste { get; set; }
        public String DateCreation { get; set; }
        public Boolean EstLivre { get; set; }
    }
}