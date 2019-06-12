using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class CaisseVM2
    {
        public String Id { get; set; }
        public Boolean IsOpen { get; set; }
        public String NomCaisse { get; set; }
        public DateTime DateOuverture { get; set; }
        public String NomCaissier { get; set; }
    }
}