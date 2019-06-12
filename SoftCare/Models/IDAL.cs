using SoftCare.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SoftCare.Models
{
    //Cette interface ressemble la bibliothèque de toutes les méthodes invoquées dans la solution
    public interface IDAL : IDisposable
    {
        /*
         * 31 Déc 2017 - @Hn
         */

        #region OC 
        DOSSIER RecupererDossierPersonne(PERSONNE personne);
        SearchDossier ConvertirDossierSearchDossier(DOSSIER dossier);
        DateTime TrouverDateDerniereVisitePatient(DOSSIER dossier);
        List<DIAGNOSTIC> RecupererTousLesDiagnosticDossier(DOSSIER dossier);
        DOSSIER ObtenirDossierParCode(string code);
        List<PERSONNE> RechercherCorrespondancesNomPersonne(string nomOUprenom);
        DOSSIER ObtenirDossierParId(String id);
        DossierVM ConvertirDossierDossierVM(DOSSIER dossier, Boolean shrinkText);
        List<PARAMETRE> RecupererTousLesParametresDossier(DOSSIER dossier);
        DiagnosticVM ConvertirDiagnosticDiagnosticVM(DIAGNOSTIC diagnostic);
        List<TRAITEMENT> RecupererTousLesTraitementsDiagnostic(DIAGNOSTIC diagnostic);
        TraitementVM ConvertirTraitementTraitementVM(TRAITEMENT traitement, Boolean decrypter);
        String EnregistrerPersonne(PERSONNE personne);
        UTILISATEUR ObtenirUtilisateurParId(String id);
        String EnregistrerDossier(DOSSIER dossier);
        TRAITEMENT ObtenirTraitementParId(String id);
        TraitementVM2 ConvertirTraitementTraitementVM2(TRAITEMENT traitement);
        List<SpecialisteVM> ObtenirTousLesSpecialistes();
        void EnregistrerParametre(PARAMETRE parametre);
        void EnregistrerAttente(ATTENTE attente);
        DIAGNOSTIC ObtenirDiagnosticParId(String id);
        DiagnosticVM2 ConvertirDiagnosticDiagnosticVM2(DIAGNOSTIC diagnostic);
        String EnregistrerDiagnostic(DIAGNOSTIC diagnostic);
        String EnregistrerTraitement(TRAITEMENT traitement);

        /*
         * 02 Jan 2018 - @Hn
         */

        ATTENTE ObtenirAttenteParId(String id);
        AttenteVM3 ConvertirAttenteAttenteVM3(ATTENTE attente);
        String ConvertirDateChaine(DateTime date);
        void ModifierAttente(String attenteID, String specialisteID);
        void EnregistrerModificationAttente(MODIFICATIONATTENTE modificationAttente);
        List<ATTENTE> ObtenirListeAttente(DateTime date);
        AttenteVM2 ConvertirAttenteAttenteVM2(ATTENTE attente);
        List<ATTENTE> ObtenirListeAttente(DateTime date, String specialisteID, int etat);
        void DesactiverAttente(String attenteID);
        void PrendreEnCharge(String attenteID);


        /*
         * 03 Jan 2018 - @Hn
         */
        List<RENDEZVOUS> ObtenirTousLesRdvDossier(String dossierID);
        RendezVousVM ConvertirRendezVousRendezVousVM(RENDEZVOUS rdv);
        String EnregistrerRendezVous(RENDEZVOUS rendezvous);
        DateTime ConstruireDate(DateTime date, int heure, int minute);
        Boolean VerifierDisponibilite(String specialisteID, String patientID, DateTime horaire);
        RENDEZVOUS ConvertirRendezVousVM2RendezVous(RendezVousVM2 rendezvousVM2);
        RendezVousVM4 ConvertirRendezVousVM2RendezVousVM4(RendezVousVM2 rendezvousVM2);

        /*
         * 05 Jan 2018 - @Hn
         */
        RENDEZVOUS ObtenirRendezVousParId(String rdvId);
        void ModifierRendezVous(RENDEZVOUS rendezvous);
        RendezVousVM3 ConvertirRendezVousRendezVousVM3(RENDEZVOUS rendezvous);

        /*
         * 10 Jan 2018 - @Hn
         */
        Double ConvertirChaineDouble(String chaine);
        List<DOSSIER> ObtenirLeRegistreMedical(String firstdossierid, Boolean sens, Boolean archived);
        int ObtenirNombreDossier();

        /*
         * 11 Jan 2018 - @Hn
         */
        String ReduireTaille(String texte, int taille);
        String GenerationCodeDossier(DateTime dateCreation, char systeme, int lieu);

        /*
         * 12 Jan 2018 - @Hn
         */
        String ObtenirIdDernierDossier();
        String ObtenirIdPremierDossier();
        void CreerGroupeMaladie(GROUPEMALADIE groupe);
        void CreerMaladie(MALADIE maladie);
        List<GROUPEMALADIE> ObtenirTousLesGroupesMaladies();
        List<MALADIE> ObtenirToutesLesMaladies();
        List<MALADIE> ObtenirToutesLesMaladiesDunGroupe(String idgroupe);
        void ArchiverDossierParId(String idDossier, String utilisateur);
        void EnregistrerModification(MODIFICATION modification);

        /*
         * 13 Jan 2018 - @Hn
         */
        List<RENDEZVOUS> ObtenirTousLesRdv(String idspecialiste, int? etatRdv, DateTime? dateRdv);
        /*
         * 15 Jan 2018 - @Hn
         */
        //void VerifierEtatRendezVous();
        MaladieVM ConvertirMaladieMaladieVM(MALADIE maladie);
        MALADIE ObtenirMaladieParId(String idmaladie);
        UTILISATEUR ObtenirUtilisateurAvecIdentifiants(string login, string password);

        /*
         * 18 Jan 2018 - @Hn
         */
        PERSONNE ObtenirPersonneParId(String personneID);

        /*
        * 19 Jan 2018 - @Hn
        */
        PARAMETRE ObtenirParametreParId(String parametreID);
        ParametreVM2 ConvertirParametreParametreVM2(PARAMETRE parametre);

        /*
         * 23 Jan 2018 - @Hn
         */
        List<UTILISATEUR> ObtenirTousLesUtilisateurs();
        List<TYPEGROUPE> ObtenirTousLesTypesDeGC();
        List<GROUPECIBLE> ObtenirTousLesGroupeCibles();
        TYPEGROUPE ObtenirTypeGroupeParId(String idType);
        String EnregistrerGroupeCible(GROUPECIBLE groupeCible);
        GROUPECIBLE ObtenirGroupeCibleParId(String idGroupe);
        GroupeCibleVM2 ConvertirGroupeCibleGroupeCibleVM2(GROUPECIBLE groupeCible);
        List<LIAISONDOSSIERGROUPECIBLE> ObtenirToutesLesLiaisonsDunGroupeParId(String idGroupe, int etatLiaison);
        List<GROSSESSE> ObtenirInfosGrossesseParLiaison(String idLiaison);
        MembreGroupeCible ConvertirGrossesseMembreGroupeCible(GROSSESSE grossesse);

        /*
         * 24 Jan 2018 - @Hn
         */
        UtilisateurVM2 ConvertirUtilisateurUtilisateurVM2(UTILISATEUR user);
        void ModifierGroupeCible(GROUPECIBLE groupe);
        List<SearchDossier> ObtenirListeDesPersonnesAdmissiblesAuGroupeFemmeEnceinte(GROUPECIBLE groupe);
        List<DOSSIER> ObtenirTousLesDossiers(Boolean IsArchived);
        Boolean VerifierPresenceDossierListeDossier(List<DOSSIER> liste, DOSSIER dossier);
        Boolean VerifierPresenceActiveDossierGroupe(DOSSIER dossier, GROUPECIBLE groupe);
        void EnregistrerLiaisonDossierGroupeCible(LIAISONDOSSIERGROUPECIBLE ldgc);
        GROUPECIBLE ObtenirGroupeCibleParCode(String code);
        List<LIAISONDOSSIERGROUPECIBLE> ObtenirLesGroupesCiblesDunPatient(String DossierId);
        LIAISONDOSSIERGROUPECIBLE ObtenirLiaisonDossierGroupeParId(String id);
        GroupeCibleVM3 ConvertirGroupeCibleGroupeCibleVM3(GROUPECIBLE groupe);
        int ObtenirTailleGroupe(GROUPECIBLE groupe);
        List<GROUPECIBLE> ObtenirTousLesGroupesCibles(int IsArchived);


        /*
         * 25 Jan 2018 - @Hn
         */
        GROSSESSE ObtenirGrossesseParId(String idgrossesse);
        List<VISITEPRENATALE> ObtenirToutesLesVisitesPrenatalesGrossesse(GROSSESSE grossesse);
        String GetEtatGrossesse(GROSSESSE grossesse);
        SampleVisitePrenatale ConvertirVisitePrenataleSampleVisitePrenatale(VISITEPRENATALE visite);
        String EnregistrerVisitePrenatale(VISITEPRENATALE visite);

        /*
         * 26 Jan 2018 - @Hn
         */
        TraitementVM3 ConvertirTraitementTraitementVM3(TRAITEMENT traitement);

        /*
         * 29 Jan 2018 - @Hn
         */
        void ModifierGrossesse(GROSSESSE grossesse);
        void ModifierLiaisonDossierGroupe(LIAISONDOSSIERGROUPECIBLE liaisonDossierGC);

        /*
         * 30 Jan 2018 - @Hn
         */
        String GenererCle(DateTime dateEnregistrement, String nomTable, char lieuLogique, int lieuPhysique);
        String getCleTable(String nomTable);
        String getCodeFormat(String Code);

        /*
         * 01 Fev 2018 - @Hn
         */
        void ModifierDossier(DOSSIER dossier, String UtilisateurID);

        /*
         * 02 Fev 2018 - @Hn
         */
        String NettoyerChaine(String chaine);
        List<DOSSIER> ObtenirListeDossierParCode(String code);
        ROLE ObtenirRoleParId(String roleID);
        String EnregistrerUtilisateur(UTILISATEUR utilisateur);
        UtilisateurVM4 ConvertirUtilisateurUtilisateurVM4(UTILISATEUR utilisateur);
        List<UTILISATEUR> ObtenirTousLesUtilisateurs(int etat, String Role);

        /*
         * 05 Fev 2018 - @Hn
         */
        UtilisateurVM3 ConvertirUtilisateurUtilisateurVM3(UTILISATEUR utilisateur);
        void DesactiverUtilisateur(UTILISATEUR utilisateur);
        List<ROLE> ObtenirTousLesRoles();
        RoleVM ConvertirRoleRoleVM(ROLE role);
        UtilisateurVM5 ConvertirUtilisateurUtilisateurVM5(UTILISATEUR user);
        List<PRIVILEGE> ObtenirTousLesPrivileges();
        List<ACCES> ObtenirTousLesAccesParRole(ROLE role);
        
        RoleVM2 ConvertirRoleRoleVM2(ROLE role, Boolean chargerListe);
        AccesVM ConvertirAccesAccesVM(ACCES acces);
        Boolean ExisteRole(String intitule);
        ACCES ObtenirAccesParRoleIdParPrivilegeId(String RoleID, int PrivilegeID);


        /*
         * 07 Fev 2018 - @Hn
         */
        PRIVILEGE ObtenirPrivilegeParId(int PrivilegeID);
        List<PRIVILEGE> OperandeListePrivilege(List<PRIVILEGE> ListePrivilegeA, List<PRIVILEGE> ListePrivilegeB);
        void ModifierRole(ROLE role);

        /*
         * 08 Fev 2018 - @Hn
         */
        List<PRIVILEGE> ObtenirListePrivilegesParListeAcces(List<ACCES> listeacces);
        void RetirerAcces(ACCES acces);
        ACCES ObtenirAccesParId(String AccesId);
        void CreerAcces(String RoleId, int PrivilegeID);
        String CreerRole(ROLE role);

        /*
         * 09 Fev 2018 - @Hn
         */
        Boolean VerifierAccesParUtilisateurIdParPrivilegePeut(String UtilisateurID, String Peut);
        PRIVILEGE ObtenirPrivilegeParPeut(String peut);
        GROUPEMALADIE ObtenirGroupeMaladieParId(String GroupeMaladieID);
        void ModifierMaladie(MALADIE maladie);
        void ModifierGroupeMaladie(GROUPEMALADIE groupemaladie);
        GroupeMaladieVM ConvertirGroupeMaladieGroupeMaladieVM(GROUPEMALADIE groupemaladie);

        /*
         * 23 Fev 2018 - @Hn
         */
        Boolean ExisteGroupeMaladieParNom(String nom);

        /*
         * 23 Avril 2018 - @Hn
         * 
         */
        String FormateAge(DateTime datetime);

        /*
        * 26 Avril 2018 - @Hn
        * 
        */
        int CalculAge(DateTime datetime);

        /*
        * 27 Avril 2018 - @Hn
        * 
        */
        GROSSESSE ObtenirGrossesseParLiaisonId(String LiaisonId);

        /*
        * 25 Mai 2018 - @Hn
        * 
        */
        String EnregistrerGrossesse(LIAISONDOSSIERGROUPECIBLE temp_ldgc);

        /*
        * 07 Juillet 2018 - @Hn
        * 
        */
        int getLongeur();

        /*
        * 29 Août 2018 - @Hn
        * 
        */
        string getErrorMessageFailedAuthorization();
        string ObtenirIdDernierDossierArchived();
        string ObtenirIdPremierDossierArchived();
        int ObtenirNombreDossierArchived();
        string getErrorMessageArchivedFolder();

        #endregion

        /*
        * 27 Avril 2019 - @Hn
        * 
        */
        #region SAVING
        String EnregistrerStock(STOCK Stock);
        String EnregistrerStockType(STOCKTYPE StockType);
        String EnregistrerProduit(PRODUIT Produit);
        String EnregistrerFabricant(FABRICANT Fabricant);
        String EnregistrerProduitEnStock(STOCKDETAILS Stockdetails);
        String EnregistrerMouvementStock(STOCKMOUVEMENT StockMouvement);
        String EnregistrerMouvementStockDetails(STOCKMOUVEMENTDETAILS StockMouvementDetails);
        String EnregistrerTransfertStock(STOCKTRANSFERT TransfertStock);
        String EnregistrerTransfertStockDetails(STOCKTRANSFERTDETAILS TransfertStockDetails);
        String EnregistrerInventaire(INVENTAIRE Inventaire);
        String EnregistrerCaisse(CAISSE Caisse);
        String EnregistrerCaisseMouvements(CAISSEMOUVEMENT CaisseMouvements);
        String EnregistrerCaisseOuvertureFermetures(CAISSEOUVERTUREFERMETURE CaisseOuvertureFermeture);
        String EnregistrerExamen(EXAMEN Examen);
        String EnregistrerResultat(RESULTAT Resultat); 
        String EnregistrerExamenMedical(EXAMENMEDICAL ExamenMedical);
        String EnregistrerExamenType(EXAMENTYPE ExamenType);
        String EnregistrerExamenResultat(EXAMENRESULTAT ExamenResultat);
        String EnregistrerInventaireDetail(INVENTAIREDETAILS InventaireDetail);
        String EnregistrerFacture(FACTURE Facture);
        String EnregistrerFactureDetail(FACTUREDETAILS FactureDetails);
        String EnregistrerRayon(RAYON Rayon);
        String EnregistrerModePaiement(MODEPAIEMENT ModePaiement);
        String EnregistrerLaboratoireOutil(LABORATOIREOUTILS LaboratoireOutils);
        String EnregistrerLaboratoire(LABORATOIRE Laboratoire);
        String EnregistrerReglement(REGLEMENT Reglement);
        #endregion



        #region Select by ID
         STOCKTYPE ObtenirStockTypeParId(String StockTypeId);
         STOCK ObtenirStockParId(String StockId);
         SERVICE ObtenirServiceParId(String ServiceId); 
         FABRICANT ObtenirFabricantParId(String FabricantId);
         STOCKDETAILS ObtenirStockDetailsParId(String StockDetailId);
         STOCKDETAILS ObtenirStockDetailsParProduitIdEtParStockId(String ProduitId, String StockId);
         List<STOCKDETAILS> ObtenirStockDetailsParProduitEtParStock(String ProduitId, String StockId);
         List<STOCKDETAILS> ObtenirStockDetailsParProduitParStockParDateExpiration(String ProduitId, String StockId, DateTime DateExpiration);
         PRODUIT ObtenirProduitParId(String ProduitId);
         List<PRODUIT> ObtenirProduitParReference(String ReferenceProduit);
         List<PRODUIT> ObtenirProduitParFabricantId(String FabricantId);
         List<PRODUIT> ObtenirProduitParStockId(String StockId);
         List<PRODUIT> ObtenirProduitParReferenceEtStocktType(String Ref, String StocktTypeId);
         List<PRODUIT> ObtenirProduitParFabricantEtStocktType(String FabricantId, String StocktTypeId);
         List<PRODUIT> ObtenirProduitParStocktTypeId(String StocktTypeId);
         STOCKMOUVEMENT ObtenirStockMouvementParId(String StockMouvementId);
         STOCKMOUVEMENT ObtenirStockMouvementParDirection(String Direction);
         STOCKMOUVEMENTDETAILS ObtenirStockMouvementDetailsParId(String StockMouvementDetailId);
         STOCKTRANSFERT ObtenirTransfertStockParId(String TransfertStockId);
         STOCKTRANSFERTDETAILS ObtenirTransfertStockDetailsParId(String TransfertStockDetailId);
         INVENTAIRE ObtenirInventaireParId(String InventaireId);
         CAISSE ObtenirCaisseParId(String CaisseId);
         CAISSEMOUVEMENT ObtenirCaisseMouvementParId(String CaisseMouvementId);
         CAISSEOUVERTUREFERMETURE ObtenirCaisseOuvertureFermeturesParId(String CaisseOuvertureFermetureId);
         EXAMEN ObtenirExamenParId(String ExamenId);
         RESULTAT ObtenirResultatParId(String ResultatId);
         RESULTAT ObtenirResultatParExamenId(String ExamenId);
         EXAMENMEDICAL ObtenirExamenMedicalParId(String ExamenMedicalId);
         EXAMENTYPE ObtenirExamenTypeParId(String ExamenTypeId);
         EXAMENRESULTAT ObtenirExamenResultatParId(String ExamenResultatId);
         INVENTAIREDETAILS ObtenirInventaireDetailParId(String InventaireDetailId);
         FACTURE ObtenirFactureParId(String FactureId);
         FACTURE ObtenirFactureParReference(String Reference);
         FACTUREDETAILS ObtenirFactureDetailParId(String FactureDetailId);
         RAYON ObtenirRayonParId(String RayonId);
         MODEPAIEMENT ObtenirModePaiementParId(String ModePaiementId);
         LABORATOIREOUTILS ObtenirLaboratoireOutilParId(String LaboratoireOutilId);
         LABORATOIRE ObtenirLaboratoireParId(String LaboratoireId);
        List<FACTUREDETAILS> ObtenirTousLesFactureDetailsParFactureId(String FactureId);
        REGLEMENT ObtenirReglementParId(String ReglementId);
        List<REGLEMENT> ObtenirReglementParFactureId(String FactureId);
        REGLEMENT ObtenirReglementParReference(String Reference);
        List<REGLEMENT> ObtenirTousLesReglementsParFactureId(String DossierId);
        List<FACTURE> ObtenirFactureParDossierId(String DossierId);
        EXAMENDETAILS ObtenirExamenDetailsParId(String ExamenDetailsId);
        String EnregistrerExamenDetails(EXAMENDETAILS examenDetails);
        List<EXAMENDETAILS> ObtenirExamenDetailsParExamenId(String ExamenId);
        List<EXAMEN> ObtenirExamenParDossier(DOSSIER Dossier);

        #endregion



        #region selecting all

        STOCK ObtenirStockPrincipal();
        STOCK ObtenirStockPharmacie();
        STOCK ObtenirStockLaboratoire();
        List<SERVICE> ObtenirTousLesServices();
        List<STOCK> ObtenirTousLesStocks();
         List<STOCKTYPE> ObtenirTousLesStockTypes();
         List<STOCKDETAILS> ObtenirTousLesStockDetails();
         List<PRODUIT> ObtenirTousLesProduits();
         List<FABRICANT> ObtenirTousLesFabricants();
         List<STOCKMOUVEMENT> ObtenirTousLesStockMouvements();
         List<STOCKMOUVEMENTDETAILS> ObtenirTousLesStockMouvementDetails();
         List<STOCKTRANSFERT> ObtenirTousLesTransfertStocks();
         List<STOCKTRANSFERTDETAILS> ObtenirTousLesTransfertStockDetails();
         List<INVENTAIRE> ObtenirTousLesInventaires();
         List<CAISSE> ObtenirTousLesCaisses();
         List<CAISSEMOUVEMENT> ObtenirTousLesCaisseMouvements();
         List<CAISSEOUVERTUREFERMETURE> ObtenirTousLesCaisseOuvertureFermetures();
         List<EXAMEN> ObtenirTousLesExamens();
         List<RESULTAT> ObtenirTousLesResultats(); 
         List<EXAMENMEDICAL> ObtenirTousLesExamenMedicaux();
         List<EXAMENTYPE> ObtenirTousLesExamenTypes();
         List<EXAMENRESULTAT> ObtenirTousLesExamenResultats();
         List<INVENTAIREDETAILS> ObtenirTousLesInventaireDetails();
         List<FACTURE> ObtenirTousLesFactures();
         List<FACTUREDETAILS> ObtenirTousLesFactureDetails();
         List<RAYON> ObtenirTousLesRayons();
         List<MODEPAIEMENT> ObtenirTousLesModePaiements();
         List<LABORATOIREOUTILS> ObtenirTousLesLaboratoireOutils();
         List<LABORATOIRE> ObtenirTousLesLaboratoire();
         List<REGLEMENT> ObtenirTousLesReglements();
        #endregion



        #region Utilities
        String GenererFactureConsultation(DOSSIER Dossier);
        CAISSEOUVERTUREFERMETURE ObtenirDernierEtatCaisseParHn(String hn);
        CAISSE CaisseOuverteParCaissierId(String CaissierId);
        Boolean MettreAJourFactureReglee(REGLEMENT Reg);
        void MettreStockStockPrincipal(STOCK Stock);
        Boolean FermerCaisse(CaisseVM3 caisseVM);
        Boolean OuvrirCaisse(CaisseVM3 caisseVM);
        decimal SommeTotalePayeeParFacture(FACTURE Facture);
        #endregion



        #region Convert M to VM
        ProduitVM ConvertirProduitProduitVM(PRODUIT Produit);
        ProduitVM2 ConvertirProduitProduitVM2(PRODUIT Produit);        
        ProduitVM2 ConvertirProduitProduitVM20(PRODUIT Produit);        
        StockVM ConvertirStockStockVM(STOCK Stock);
        StockVM2 ConvertirStockStockVM2(STOCK Stock);
        RayonVM ConvertirRayonRayonVM(RAYON Rayon);
        FabricantVM ConvertirFabricantFabricantVM(FABRICANT Fabricant);
        CaisseVM2 ConvertirCaisseCaisseVM2(CAISSE Caisse);
        CaisseVM3 ConvertirCaisseCaisseVM3(CAISSE Caisse);
        FactureVM2 ConvertirFactureFactureVM2(FACTURE Facture);
        ReglementVM3 ConvertirReglementReglementVM3(REGLEMENT Reglement);
        ReglementVM4 ConvertirReglementReglementVM4(REGLEMENT Reglement);
        ExamenMedicalVM ConvertirExamenMedicalExamenMedicalVM(EXAMENMEDICAL ExamenMedical);
        ExamenVM ConvertirExamenExamenVM(EXAMEN Examen);
        ExamenVM2 ConvertirExamenExamenVM2(EXAMEN Examen);
        ResultatVM3 ConvertirResultatResultatVM(RESULTAT Resultat);
        ExamenDetailsVM ConvertirExamenDetailsExamenDetailsVM(EXAMENDETAILS ExamenDetails);

        #endregion








        #region  To remove 
        int EnregistrerPrivilege(PRIVILEGE Privilege); 
        #endregion

    }
}
