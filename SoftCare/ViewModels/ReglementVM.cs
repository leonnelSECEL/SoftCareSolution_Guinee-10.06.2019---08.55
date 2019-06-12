using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ReglementVM
    {
        public String FactureId { get; set; }
        public String CaissierId { get; set; }
        public String CaisseId { get; set; }
        public String Caisse { get; set; }
        public String Patient { get; set; }
        public String Caissier { get; set; }
        public String ModePaiementId { get; set; }
        public String ReferenceFacture { get; set; }
        public decimal Montant { get; set; }
        public decimal MontantRecu { get; set; }
        public decimal MontantRembourse { get; set; }
        public decimal MontantARembourse { get; set; }
        public decimal MontantARembourse2 { get; set; }
        public decimal Reste { get; set; }
        public decimal Reste2 { get; set; } 
        public DateTime DateCreation { get; set; }
    }
}