using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class GroupeCibleVM
    {
        public String Id { get; set; }
        [Required]
        public String Intitule { get; set; }
        [Required]
        public String Objet { get; set; }
        public Boolean Closed { get; set; }
        public Boolean Archived { get; set; }
        public DateTime DateCreationGroupe { get; set; }
        [Required]
        public DateTime DateClotureGroupe { get; set; }
        public DateTime DateArchivageGroupe { get; set; }
        [Required]
        public String Type { get; set; }
        [Required]
        public String Administrateur { get; set; }
        public String CleIdentity { get; set; }
    }
}