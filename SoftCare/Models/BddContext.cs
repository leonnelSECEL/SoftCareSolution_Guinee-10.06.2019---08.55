using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    //Cette classe représente les tables de la base de données (et leurs contenus) 

    public class BddContext : DbContext
    {
        #region
        public DbSet<ATTENTE> Attentes { get; set; }
        public DbSet<MODIFICATIONATTENTE> ModificationAttentes { get; set; }
        public DbSet<DIAGNOSTIC> Diagnostics { get; set; }
        public DbSet<DOSSIER> Dossiers { get; set; }
        public DbSet<MODIFICATION> Modifications { get; set; }
        public DbSet<PARAMETRE> Parametres { get; set; }
        public DbSet<PERSONNE> Personnes { get; set; }
        public DbSet<RAPPELRDV> RappelRdvs { get; set; }
        public DbSet<RENDEZVOUS> RendezVous { get; set; }
        public DbSet<TRAITEMENT> Traitements { get; set; }
        public DbSet<UTILISATEUR> Utilisateurs { get; set; }
        public DbSet<MALADIE> Maladies { get; set; }
        public DbSet<GROUPEMALADIE> GroupeMaladies { get; set; }
        public DbSet<GROUPECIBLE> GroupeCibles { get; set; }
        public DbSet<GROSSESSE> Grossesses { get; set; }
        public DbSet<VISITEPRENATALE> VisitePrenatales { get; set; }
        public DbSet<LIAISONDOSSIERGROUPECIBLE> LiaisonDossierGroupes { get; set; }
        public DbSet<TYPEGROUPE> TypeGroupes { get; set; }
        public DbSet<CLETABLE> CleTables { get; set; }
        public DbSet<ROLE> Roles { get; set; }
        public DbSet<PRIVILEGE> Privileges { get; set; }
        public DbSet<ACCES> Acces { get; set; }

#endregion
        /*

         * Date du 27 Avril 2019 - @Hn

         */

        public DbSet<CAISSE> Caisses { get; set; }
        public DbSet<CAISSEMOUVEMENT> CaisseMouvements { get; set; }
        public DbSet<CAISSEOUVERTUREFERMETURE> CaisseOuvertureFermetures { get; set; }
        public DbSet<EXAMEN> Examens { get; set; }
        public DbSet<EXAMENTYPE> ExamenTypes { get; set; }
        public DbSet<EXAMENRESULTAT> ExamenResultats { get; set; }
        public DbSet<FABRICANT> Fabricants { get; set; }
        public DbSet<INVENTAIRE> Inventaires { get; set; }
        public DbSet<INVENTAIREDETAILS> InventaireDetails { get; set; }
        public DbSet<FACTURE> Factures { get; set; }
        public DbSet<FACTUREDETAILS> FactureDetails { get; set; }
        public DbSet<PRODUIT> Produits { get; set; }
        public DbSet<STOCK> Stocks { get; set; }
        public DbSet<STOCKTYPE> StockTypes { get; set; }
        public DbSet<STOCKDETAILS> StockDetails { get; set; }
        public DbSet<STOCKMOUVEMENT> StockMouvements { get; set; }
        public DbSet<STOCKMOUVEMENTDETAILS> StockMouvementDetails { get; set; }
        public DbSet<STOCKTRANSFERT> TransfertStocks { get; set; }
        public DbSet<STOCKTRANSFERTDETAILS> TransfertStockDetails { get; set; }
        public DbSet<LABORATOIRE> Laboratoires { get; set; }
        public DbSet<LABORATOIREOUTILS> LaboratoireOutils { get; set; } 
        public DbSet<MODEPAIEMENT> ModePaiements { get; set; }
        public DbSet<RAYON> Rayons { get; set; }
        public DbSet<REGLEMENT> Reglements { get; set; }
        public DbSet<EXAMENMEDICAL> ExamenMedicaux { get; set; }
        public DbSet<SERVICE> Services { get; set; }
        public DbSet<EXAMENDETAILS> ExamenDetails { get; set; } 
        public DbSet<RESULTAT> Resultats { get; set; } 


    }
}