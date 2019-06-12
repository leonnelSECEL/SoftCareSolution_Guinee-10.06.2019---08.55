using System;

namespace SoftCare.ViewModels
{
    public class SearchDossier
    {
        public String DossierId { get; set; }
        public String Code { get; set; }
        public String Nom { get; set; }
        public String LastVisit { get; set; }
        public DateTime LastDateVisit { get; set; }
        public String DateArchive { get; set; }
        public String Adresse { get; set; }
        public String Tel { get; set; }

    }
}