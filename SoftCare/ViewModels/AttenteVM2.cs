using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class AttenteVM2
    {
        public String AttenteId { get; set; }
        public Boolean EtatAttente{ get; set; }
        public Boolean StatutAttente { get; set; }
        public String SpecialisteID { get; set; }
        public String Specialiste { get; set; }
        public String CodePatient { get; set; }
        public String NomPatient { get; set; }
        public String Horaire { get; set; }
        
    }
}