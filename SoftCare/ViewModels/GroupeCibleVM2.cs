using SoftCare.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class GroupeCibleVM2
    {
        public String Id { get; set; }

        //Nécessaire à l'affichage
        public String Code { get; set; }
        public String Intitule { get; set; }
        public String Objet { get; set; }
        public String DateCreationGroupe {get; set;}
        public DateTime DateClotureGroupe { get; set; }
        public TYPEGROUPE TypeGroupe { get; set; }
        public UtilisateurVM2 Admin { get; set; }


        //Nécessaire pour voir plus
        public Boolean Closed { get; set; }
        public Boolean Archived { get; set; }

        public String DateArchivage { get; set; }
        

        

        //Données modifiables (avec la date de cloture)
        [Required]
        public String Administrateur { get; set; }
        [Required]
        public String type { get; set; }
        
        
        
        

        public List<MembreGroupeCible> Membres {get; set;}

    }
}