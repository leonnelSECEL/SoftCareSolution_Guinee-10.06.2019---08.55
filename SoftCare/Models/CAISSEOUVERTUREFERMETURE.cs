using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    [Table("CAISSEOUVERTUREFERMETURE")]
    public class CAISSEOUVERTUREFERMETURE
    {
        public String CaisseOuvertureFermetureID { get; set; }
        public virtual CAISSE Caisse { get; set; }
        public virtual UTILISATEUR Utilisateur { get; set; }
        public DateTime DateOuverture { get; set; }
        public decimal SoldeOuverture { get; set; }
        public DateTime DateFermeture { get; set; }
        public decimal SoldeFermeture { get; set; }
        public decimal SoldeAttendu { get; set; }
        public decimal SoldeManquant { get; set; }
        public String TypeManquant { get; set; }
        public String CommentaireOuverture { get; set; }
        public String CommentaireFermeture { get; set; }
        public DateTime DateCreation { get; set; }
        public DateTime DateModification { get; set; }
        public DateTime DateSuppression { get; set; }
        public Boolean IsModified { get; set; }
        public Boolean IsDeleted { get; set; }

    }
}