using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("PERSONNE")]
    public class PERSONNE
    {
        public String PersonneID { get; set; }
        [Required]
        public string Nom { get; set; }
        public string Prenom { get; set; }
        [DataType(DataType.PhoneNumber)]
        public string TelephonePrincipal { get; set; }
        [DataType(DataType.PhoneNumber)]
        public string TelephoneSecondaire { get; set; }
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }
        public string Adresse { get; set; }
        public DateTime DateNaissance { get; set; }
        public string LieuNaissance { get; set; }
        [Required]
        public int Sexe { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }



    }
}