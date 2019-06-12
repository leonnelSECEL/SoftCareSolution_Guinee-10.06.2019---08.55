using System;
using System.Collections.Generic;

namespace SoftCare.ViewModels
{
    public class DiagnosticVM2
    {
        public String Id { get; set; }
        public String DossierID { get; set; }
        public String Diagnostic { get; set; }
        public String Specialiste { get; set; }
        public DateTime DateDiagnostic { get; set; }
        public Boolean isArchived { get; set; }
        public List<TraitementVM> Traitements { get; set; }

    }
}