using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftCare.Models
{
    [Table("UTILISATEUR")]
    public class UTILISATEUR
    {
        public String UtilisateurID { get; set; }
        public virtual PERSONNE Personne { get; set; }
        public virtual ROLE Role { get; set; }
        [Required]
        public string Login { get; set; }
        [Required]
        [StringLength(100, ErrorMessage = "Le mot de passe doit comporter au moins {2} caractères.", MinimumLength = 8)]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        public string Fonction { get; set; }
        [Required]
        public DateTime DateCreation { get; set; }
        [Required]
        public Boolean Actif { get; set; }

        public Boolean IsDeleted { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public DateTime DateModification { get; set; }

    }
}