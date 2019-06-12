using SoftCare.Models;
using System;
using System.Collections.Generic;

namespace SoftCare.ViewModels
{
    public class ApprovisionnementStockVM
    {
        public String Id { get; set; }
        public String StockId { get; set; }
        public String NomStock { get; set; }
        public List<ProduitVM> Produits { get; set; }

    }
}