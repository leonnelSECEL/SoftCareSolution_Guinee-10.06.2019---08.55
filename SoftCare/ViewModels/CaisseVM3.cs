using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class CaisseVM3
    {
        public String Id { get; set; }
        public String CaissierId { get; set; }
        public Boolean IsOpen { get; set; }
        public String NomCaisse { get; set; }
        public String NomCaissier { get; set; }
        public DateTime DateOuverture { get; set; }
        public decimal SoldeOuverture { get; set; }
        public DateTime DateFermeture { get; set; }
        public decimal SoldeFermeture { get; set; }
        public decimal SoldeAttendu { get; set; }
        public decimal SoldeManquant { get; set; }
        public String TypeManquant { get; set; }
        public String CommentaireOuverture { get; set; }
        public String CommentaireFermeture { get; set; }
        public String hn { get; set; }
    }
}