using SoftCare.Models;
using System;
using System.Collections.Generic;

namespace SoftCare.ViewModels
{
    public class ApprovisionnementStockVM2
    {
        public String ProduitId { get; set; }
        public int Quantite { get; set; }
        public DateTime DateExpiration { get; set; }
       
    }
}