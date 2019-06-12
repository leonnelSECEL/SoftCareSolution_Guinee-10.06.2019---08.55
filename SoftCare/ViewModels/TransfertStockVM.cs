using SoftCare.Models;
using System;
using System.Collections.Generic;

namespace SoftCare.ViewModels
{
    public class TransfertStockVM
    {
        public String Id { get; set; }
        public String StockFromId { get; set; }
        public String StockToId { get; set; }
        public String MagasinierId { get; set; }
        public List<ProduitVM> Produits { get; set; }

    }
}