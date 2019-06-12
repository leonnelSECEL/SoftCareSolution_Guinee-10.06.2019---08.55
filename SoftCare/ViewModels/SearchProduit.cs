using System;

namespace SoftCare.ViewModels
{
    public class SearchProduit
    {
        public String ProduitId { get; set; }
        public String Reference { get; set; }
        public String Stock { get; set; }
        public String Rayon { get; set; }
        public DateTime DateExpiration { get; set; }
        public String QuantiteStock { get; set; }
    }
}