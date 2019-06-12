using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class RendezVousVM
    {

        public String RdvId { get; set; }
        public String DossierId { get; set; }
        public String SpecialisteID { get; set; }
        public String Horaire { get; set; }
        public String Specialiste { get; set; }
        public String Patient { get; set; }
        public String Objet { get; set; }
        public Boolean Recu { get; set; }
        public Boolean Actif { get; set; }
        public Boolean Manque { get; set; }


    }
}