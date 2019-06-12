using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class MembreGroupeCible
    {
        public String Id { get; set; }
        public String LiaisonId { get; set; }
        public String DossierId { get; set; }
        public String GrossesseId { get; set; }
        public String CodeDosser { get; set; }
        public String NomPatient { get; set; }
        public String DateIntegration { get; set; }
        public String Specialiste { get; set; }
        public String EtatGrossesse { get; set; }
    }
}