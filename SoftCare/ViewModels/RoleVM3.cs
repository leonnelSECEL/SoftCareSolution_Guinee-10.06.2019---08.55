using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class RoleVM3
    {
        public String RoleID { get; set; }
        [Required]
        [Display(Name = "Intitulé du rôle")]
        public String Intitule { get; set; }
        [Display(Name = "Ajouté le")]
        public String DateCreation { get; set; }
        [Required]
        public int[] TableauPrivilegeId { get; set; }


        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            bool valider = false;
            foreach (var t in TableauPrivilegeId)
            {
                if (t != 0)
                    valider = true;
            }

            if(!valider)
                yield return new ValidationResult("Vous devez sélectionner au moins un privilège", new[] { "TableauPrivilegeId" });
            // etc.
        }
    }


}