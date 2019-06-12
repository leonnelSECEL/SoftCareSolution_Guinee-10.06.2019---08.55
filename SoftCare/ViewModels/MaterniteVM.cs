using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class MaterniteVM
    {
        public int[] cle = { -4, -3, -2, -1, 0, 1, 2 };
        public String[] Intitule = { 
                                       "Grossesse à terme | Décès de la mère et de(s) l'enfant(s)", 
                                       "Grossesse à terme | Décès de la mère", 
                                       "Grossesse interrompue | Fausse couche", 
                                       "Grossesse à terme | Enfant(s) décédé(s) à la naissance",
                                       "En cours",
                                       "Grossesse à terme | Accouchement par césarienne", 
                                       "Grossesse à terme | Accouchement normal"
                                        };

        public int[] ResultatId { get; set; }
        public Plage Periode { get; set; }
        public String[] GroupeId { get; set; } 
    }

    public class Plage
    {
        [Required]
        [Display(Name = "Période allant de")]
        public DateTime inf { get; set; }
        [Required]
        [Display(Name = "A")]
        public DateTime sup { get; set; }
    }
}