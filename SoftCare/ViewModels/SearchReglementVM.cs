using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class SearchReglementVM
    {
        public String CodeDossierPatient { get; set; }
        public String ReferencePaiement { get; set; }
        public String ReferenceFacture { get; set; }
    }
}