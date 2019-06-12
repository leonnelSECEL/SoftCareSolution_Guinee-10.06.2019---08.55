using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class PathologieVM
    {
        [Required]
        public int Genre { get; set; }
        [Required]
        public Tranche Tranche { get; set;}
        [Required]
        public Periode Periode { get; set; }
        public String[] MaladiesId {get; set;}


    }
        public class Tranche
        {
            [Required]
            [Range(0,120)]
            [Display(Name = "Age minimum")]
            public int inf {get; set;}
            [Required]
            [Range(0, 120)]
            [Display(Name="Age maximum")]
            public int sup {get; set;}
        }

        public class Periode
        {
            [Required]
            [Display(Name = "Période allant de")]
            public DateTime inf { get; set; }
            [Required]
            [Display(Name = "A")]
            public DateTime sup { get; set; }
        }
}