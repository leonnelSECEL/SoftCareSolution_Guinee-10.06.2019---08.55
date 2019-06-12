using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace SoftCare.ViewModels
{
    public class PersonneVM :IValidatableObject
    {
        public String Id { get; set; }
        [Required(ErrorMessage="Vous devez saisir le nom de la personne")]
        [Display(Name = "Nom de la personne")]
        public string Nom { get; set; }
        [Display(Name = "Prénom")]
        public string Prenom { get; set; }
        [Display(Name="Numéro de télephone principal")]
        [RegularExpression("^(((0{2}[-. ]?)|([+][-. ]?))237[-. ]?)?((2[-. ]?(3|4)|6[-. ]?(5|6|7|8|9))(([-. ]?[0-9]){7}))$")]
        [DataType(DataType.PhoneNumber)]
        public string TelephonePrincipal { get; set; }
        [Display(Name = "Télephone secondaire")]
        [RegularExpression("^(((0{2}[-. ]?)|([+][-. ]?))237[-. ]?)?((2[-. ]?(3|4)|6[-. ]?(5|6|7|8|9))(([-. ]?[0-9]){7}))$")]
        [DataType(DataType.PhoneNumber, ErrorMessage = "Veuillez saisir un numéro de télephone valide")]
        public string TelephoneSecondaire { get; set; }
        [RegularExpression(".+\\@.+\\..+")]
        [DataType(DataType.EmailAddress)]
        public string Email { get; set; }
        public string Adresse { get; set; }
        [Display(Name = "Né le ")]
        public DateTime DateNaissance { get; set; }
        [Display(Name = "A")]
        public string LieuNaissance { get; set; }
        public int Sexe { get; set; }
        [Display(Name = "Infos utiles sur le patient (allergies connues, ...)")]
        public string PenseBete { get; set; }
        [Display(Name = "Intégrer ce Patient à un Programme SOS")]  
        public string ProgrammeSOS { get; set; }


        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            if (string.IsNullOrWhiteSpace(TelephonePrincipal) && string.IsNullOrWhiteSpace(TelephoneSecondaire) && string.IsNullOrWhiteSpace(Email))
                yield return new ValidationResult("Vous devez saisir au moins un moyen de contacter le patient", new[] { "TelephonePrincipal", "TelephoneSecondaire", "Email" });
            // etc.
        }


    }
}