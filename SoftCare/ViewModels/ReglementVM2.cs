using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ReglementVM2
    {
        public String Id { get; set; }
        public String FactureId { get; set; }
        public String CaisseId { get; set; }  
        public String CaissierId { get; set; } 
        public String ModePaiementId { get; set; } 
        public decimal Montant { get; set; }
        public decimal MontantRecu { get; set; }
        public decimal MontantRembourse { get; set; }
        public decimal MontantARembourse { get; set; }
        public DateTime DateCreation { get; set; }
    }
}