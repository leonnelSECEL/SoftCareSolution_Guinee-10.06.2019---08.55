using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class ReglementVM3
    {
        public String Id { get; set; }
        public String Facture { get; set; }
        public String Reference { get; set; }
        public String Caisse { get; set; }  
        public String ModePaiement { get; set; } 
        public decimal Montant { get; set; }
        public String Reste { get; set; }
        public String DateCreation { get; set; }
        public Boolean EstLivre { get; set; }
    }
}