using System;
using System.ComponentModel.DataAnnotations;

namespace SoftCare.ViewModels
{
    public class DiagnosticVM
    {
        public String Id { get; set; }
        public String DossierId { get; set; }
        public String MaladieId { get; set; }
        public String Specialiste { get; set; }
        public DateTime DateDiagnostic { get; set; }
        [Required]
        public string Avis { get; set; }
        public String CleIdentity { get; set; }

    }
}