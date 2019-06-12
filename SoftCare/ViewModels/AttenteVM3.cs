using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class AttenteVM3
    {
        public String AttenteId { get; set; }
        public String AncienSpecialisteID { get; set; }
        public String NouveauSpecialisteID { get; set; }
        public String NomAncienSpecialiste { get; set; }
        public String CodePatient { get; set; }
        public String NomPatient { get; set; }
        public String Horaire { get; set; }
        [Required]
        public String Motif { get; set; }
    }
}