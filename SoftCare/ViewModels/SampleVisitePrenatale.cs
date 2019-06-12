using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class SampleVisitePrenatale
    {
        public String Id { get; set; }
        public String DateVisite { get; set; }
        public DateTime Date { get; set; }
        public String Specialiste { get; set; }
        public String Commentaire { get; set; }
        public int EtatVisite { get; set; } //1 : Visite ayant eu lieu
                                            //0 : Visite manquée
                                            //-1 : Visite en attente
                                            //-2 : Visite annulée
    }
}