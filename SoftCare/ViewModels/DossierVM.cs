using SoftCare.Models;
using System;
using System.Collections.Generic;

namespace SoftCare.ViewModels
{
    public class DossierVM
    {
        public String Id { get; set; }
        public DOSSIER Dossier { get; set; }
        public List<PARAMETRE> Parametres { get; set; }
        public List<DiagnosticVM> Diagnostics { get; set; }
        public List<ExamenDetailsVM> ExamenDetailsVM { get; set; }
        public List<TraitementVM> Traitements { get; set; }
        public string CleIdentity { get; set; }

    }
}