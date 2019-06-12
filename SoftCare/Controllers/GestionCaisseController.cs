using Newtonsoft.Json;
using Rotativa;
using SoftCare.Models;
using SoftCare.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SoftCare.Controllers
{
    /*
     ------------------------------ NOTE IMPORTANTE -------------------------------------
     * 
     * TOUJOURS VERIFIER LA CONFORMITE DES DONNEES (MODELE) RENVOYEES VIA FORMULAIRE PAR
     * UN UTILISATEUR.
     * 
     * Des primitives comme ModelState.IsValid peuvent aider.
     * 
     * 
     ------------------------------------------------------------------------------------
     */


    //Cette marque rassure que seul un utilisateur authentifié puisse avoir accès à ce controlleur et donc ses actions)
    [Authorize]
    public class GestionCaisseController : Controller  //GestionCaisse
    {
        [HttpGet]
        public ActionResult AJOUTERCAISSE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_CAISSE"))
                {

                    return View("FormulaireAjoutCaisse");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult AJOUTERCAISSE(CaisseVM caisseVM)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_CAISSE"))
                {

                    if (ModelState.IsValid)
                    {
                        CAISSE caisse = new CAISSE()
                        {
                            Nom = caisseVM.NomCaisse,
                            DateCreation = DateTime.Now
                        };
                        caisse.CaisseID = dal.EnregistrerCaisse(caisse);

                        return RedirectToAction("CONSULTERLISTECAISSES");
                    }
                    else
                    {
                        return View("FormulaireAjoutCaisse");
                    }

                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }

        [HttpGet]
        public ActionResult CONSULTERLISTECAISSES()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_CAISSES"))
                {

                    List<CaisseVM2> tempListeCaissetVM = new List<CaisseVM2>();

                    List<CAISSE> tempListeCaisse = dal.ObtenirTousLesCaisses();

                    CaisseVM2 caissetVM;
                    foreach (var c in tempListeCaisse)
                    {
                        caissetVM = new CaisseVM2();
                        caissetVM = dal.ConvertirCaisseCaisseVM2(c);
                        tempListeCaissetVM.Add(caissetVM);
                    }

                    return View("ConsulterListeCaisses", tempListeCaissetVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult OUVRIRCAISSE(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "OUVRIR_CAISSE"))
                {

                    CaisseVM3 tempCaisseVM = new CaisseVM3();

                    ViewBag.ListeSpecialiste = new SelectList(dal.ObtenirTousLesSpecialistes(), "Id", "NomSpecialiste");

                    CAISSE Caisse = dal.ObtenirCaisseParId(CRYPTAGE.StringHelpers.Encrypt(Id));

                    tempCaisseVM = dal.ConvertirCaisseCaisseVM3(Caisse);

                    return View("FormulaireOuvertureCaisse", tempCaisseVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult OUVRIRCAISSE(CaisseVM3 CaisseVM)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "OUVRIR_CAISSE"))
                {

                    if (ModelState.IsValid)
                    {

                        if (dal.OuvrirCaisse(CaisseVM))
                        {
                            return RedirectToAction("CONSULTERLISTECAISSES");
                        }

                        ViewBag.ErrorMessage = "Séléctionnez la Caisse et recommencez.";
                        return View("Error");
                    }

                    ViewBag.ErrorMessage = "Séléctionnez la Caisse et recommencez.";
                    return View("Error");

                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult FERMERCAISSE(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "FERMER_CAISSE"))
                {

                    CaisseVM3 tempCaisseVM = new CaisseVM3();

                    CAISSE Caisse = dal.ObtenirCaisseParId(CRYPTAGE.StringHelpers.Encrypt(Id));

                    tempCaisseVM = dal.ConvertirCaisseCaisseVM3(Caisse);

                    return View("FormulaireFermetureCaisse", tempCaisseVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult FERMERCAISSE(CaisseVM3 CaisseVM)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "FERMER_CAISSE"))
                {

                    if (ModelState.IsValid)
                    {
                        if (dal.FermerCaisse(CaisseVM))
                        {
                            return RedirectToAction("CONSULTERLISTECAISSES");
                        }

                        ViewBag.ErrorMessage = "Erreur lors de la fermeture de la Caisse.";
                        return View("Error");
                    }
                    ViewBag.ErrorMessage = "Erreur lors de la fermeture de la Caisse.";
                    return View("Error");

                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult ENREGISTRERFACTURE(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_FACTURE"))
                {
                    FactureVM factureVM = new FactureVM();

                    DOSSIER dossierPatient = dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(Id));
                    if (dossierPatient != null)
                    {
                        factureVM.DossierID = CRYPTAGE.StringHelpers.Decrypt(dossierPatient.DossierID);
                        factureVM.CodeDossier = CRYPTAGE.StringHelpers.Decrypt(dossierPatient.Code);
                        factureVM.Patient = CRYPTAGE.StringHelpers.Decrypt(dossierPatient.Patient.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(dossierPatient.Patient.Prenom);

                        UTILISATEUR u = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);
                        if (u != null)
                        {
                            factureVM.NomCaissier = CRYPTAGE.StringHelpers.Decrypt(u.Personne.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(u.Personne.Prenom);
                            factureVM.CaissierID = CRYPTAGE.StringHelpers.Decrypt(u.UtilisateurID);
                        }
                    }

                    List<PRODUIT> ListeProduits = dal.ObtenirTousLesProduits();
                    List<ProduitVM> ListeProduitVM = new List<ProduitVM>();

                    if (ListeProduits.Count > 0)
                    {
                        ProduitVM pVM;
                        foreach (var p in ListeProduits)
                        {
                            pVM = new ProduitVM();
                            pVM = dal.ConvertirProduitProduitVM(p);
                            ListeProduitVM.Add(pVM);
                        }
                    }
                    factureVM.ListeProduits = ListeProduitVM;

                    return View("FormulaireAjoutFacture", factureVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult ENREGISTRERFACTURE(FactureVM2 factureVM, String[] IdsProduitsSelectionnes, String[] QtesProduitsSelectionnes)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_FACTURE"))
                {
                    if (ModelState.IsValid)
                    {
                        FACTURE facture = new FACTURE();

                        facture.Dossier = dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(factureVM.DossierID));
                        facture.Utilisateur = dal.ObtenirUtilisateurParId(CRYPTAGE.StringHelpers.Encrypt(factureVM.CaissierID));

                        facture.FactureID = dal.EnregistrerFacture(facture);


                        if (!String.IsNullOrEmpty(facture.FactureID) && IdsProduitsSelectionnes != null && QtesProduitsSelectionnes != null)
                        {
                            FACTURE fact = dal.ObtenirFactureParId(facture.FactureID);
                            FACTUREDETAILS factureDetails;

                            int i = 0;
                            int Quantite = 0;
                            foreach (var idProduit in IdsProduitsSelectionnes)
                            {
                                if (!String.IsNullOrEmpty(idProduit) && !String.IsNullOrEmpty(QtesProduitsSelectionnes[i]))
                                {
                                    if (idProduit != "false" && QtesProduitsSelectionnes[i] != "false")
                                    {
                                        factureDetails = new FACTUREDETAILS();

                                        factureDetails.Facture = fact;

                                        PRODUIT Prod = dal.ObtenirProduitParId(idProduit);
                                        factureDetails.Produit = Prod;
                                        factureDetails.PrixUnitaire = Prod.PrixVente;

                                        Boolean IsConverted = int.TryParse(QtesProduitsSelectionnes[i], out Quantite);

                                        if (IsConverted)
                                        {
                                            factureDetails.Quantite = Quantite;
                                            dal.EnregistrerFactureDetail(factureDetails);
                                        }
                                    }
                                }
                                i += 1;
                            }
                        }

                        return RedirectToAction("CONSULTERLISTEFACTURES");
                    }
                    else
                    {
                        return View("FormulaireAjoutFacture");
                    }

                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERLISTEFACTURES()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_FACTURES"))
                {
                    List<FactureVM2> tempListeFacturetVM = new List<FactureVM2>();

                    List<FACTURE> tempListeFacture = dal.ObtenirTousLesFactures().OrderByDescending(f => f.DateCreation).ToList();

                    FactureVM2 FacturetVM;
                    foreach (var f in tempListeFacture)
                    {
                        FacturetVM = new FactureVM2();
                        FacturetVM = dal.ConvertirFactureFactureVM2(f);
                        tempListeFacturetVM.Add(FacturetVM);
                    }

                    return View("ConsulterListeFactures", tempListeFacturetVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERFACTURE(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_FACTURE"))
                {
                    FactureVM2 FacturetVM = new FactureVM2();

                    FACTURE Facture = dal.ObtenirFactureParId(CRYPTAGE.StringHelpers.Encrypt(Id));

                    if (Facture != null)
                    {
                        FacturetVM = dal.ConvertirFactureFactureVM2(Facture);
                        
                        FacturetVM.Reste = FacturetVM.Montant - dal.SommeTotalePayeeParFacture(Facture);

                        return View("ConsulterFacture", FacturetVM);
                    }
                    return RedirectToAction("CONSULTERLISTEFACTURES");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult ENREGISTRERREGLEMENT(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_REGLEMENT"))
                {
                    CAISSE CaisseOuverte = dal.CaisseOuverteParCaissierId(HttpContext.User.Identity.Name);

                    if (CaisseOuverte != null)
                    {
                        ReglementVM RVM = new ReglementVM();

                        FACTURE fact = dal.ObtenirFactureParId(CRYPTAGE.StringHelpers.Encrypt(Id));
                        if (fact != null)
                        {
                            FactureVM2 FVM = dal.ConvertirFactureFactureVM2(fact);

                            RVM.FactureId = FVM.Id;
                            RVM.Patient = FVM.Patient;
                            RVM.ReferenceFacture = FVM.Reference;
                            RVM.Montant = FVM.Montant;
                            RVM.Reste = FVM.Montant - dal.SommeTotalePayeeParFacture(fact);
                            RVM.CaisseId = CaisseOuverte.CaisseID;
                            RVM.Caisse = CRYPTAGE.StringHelpers.Decrypt(CaisseOuverte.Nom);

                            UTILISATEUR GerantCaisse = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);
                            if (GerantCaisse != null)
                            {
                                RVM.CaissierId = GerantCaisse.UtilisateurID;
                                RVM.Caissier = CRYPTAGE.StringHelpers.Decrypt(GerantCaisse.Personne.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(GerantCaisse.Personne.Prenom);
                            }

                            ViewBag.ListeModePaiement = dal.ObtenirTousLesModePaiements();

                            return View("FormulaireAjoutReglement", RVM);
                        }
                        else
                        {
                            ViewBag.ErrorMessage = "Rassurez-vous que cette facture existe.";
                            return View("Error");
                        }

                    }
                    else
                    {
                        ViewBag.ErrorMessage = "Rassurez-vous que votre Caisse est OUVERTE et qu'elle vous a été affectée.";
                        return View("Error");
                    }
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult ENREGISTRERREGLEMENT(ReglementVM PVM)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_REGLEMENT"))
                {
                    if (ModelState.IsValid)
                    {
                        REGLEMENT Reglement = new REGLEMENT();
                        FACTURE Facture = new FACTURE();
                        CAISSE Caisse = new CAISSE();
                        MODEPAIEMENT ModePaiement = new MODEPAIEMENT();

                        Caisse = dal.ObtenirCaisseParId(PVM.CaisseId);
                        if (Caisse != null)
                        {
                            Reglement.Caisse = Caisse;
                        }
                        else
                        {
                            ViewBag.ErrorMessage = "Un problème lors de la selection de la Caisse";
                            return View("Error");
                        }

                        Facture = dal.ObtenirFactureParId(PVM.FactureId);
                        if (Facture != null)
                        {
                            if (!Facture.EstPaye)
                            {
                                Reglement.Facture = Facture;
                            }
                            else
                            {
                                ViewBag.ErrorMessage = "Cette Facture semble deja etre payée";
                                return View("Error");
                            }
                        }
                        else
                        {
                            ViewBag.ErrorMessage = "Un problème lors de la selection de la Facture";
                            return View("Error");
                        }



                        ModePaiement = dal.ObtenirModePaiementParId(PVM.ModePaiementId);
                        if (ModePaiement != null)
                        {
                            Reglement.ModePaiement = ModePaiement;
                        }
                        else
                        {
                            ViewBag.ErrorMessage = "Séléctionnez un mode de Paiement valide";
                            return View("Error");
                        }

                        List<REGLEMENT> ListePaiements = dal.ObtenirReglementParFactureId(Facture.FactureID);

                        decimal MontantGlobalRecu = 0; 
                        foreach(var reg in ListePaiements)
                        {
                            MontantGlobalRecu += reg.MontantRecu;
                        }

                        MontantGlobalRecu += PVM.MontantRecu;

                        Reglement.MontantNet = PVM.Montant;
                        Reglement.MontantRecu = PVM.MontantRecu;
                        Reglement.MontantRembourse = PVM.MontantRembourse;
                        Reglement.MontantARembourse = PVM.MontantARembourse2;
                        Reglement.MontantRestant = PVM.Reste2;


                        Reglement.ReglementID = dal.EnregistrerReglement(Reglement);
                        
                        if(MontantGlobalRecu >= Reglement.MontantNet)
                        {
                            if (Reglement.ReglementID != null)
                            {
                                dal.MettreAJourFactureReglee(Reglement);
                                return RedirectToAction("CONSULTERLISTEREGLEMENTS");
                            }
                            else
                            {
                                ViewBag.ErrorMessage = "Il y a eu un souci lors de l'enregistrement de ce Paiement. Verifiez SVP.";
                                return View("Error");
                            }
                        }

                        if(Reglement.ReglementID != null)
                        {
                            CAISSEMOUVEMENT CaisseMvt = new CAISSEMOUVEMENT();
                            CaisseMvt.Caisse = Reglement.Caisse;
                            CaisseMvt.Montant = PVM.MontantRecu;
                            CaisseMvt.Raison = "ENCAISSEMENT";
                            CaisseMvt.Direction = "IN";
                            CaisseMvt.Commentaire = "Paiement Facture Réf : " + Facture.Reference;

                            dal.EnregistrerCaisseMouvements(CaisseMvt); 
                        }

                        return RedirectToAction("CONSULTERFACTURE", new { id = CRYPTAGE.StringHelpers.Decrypt(Facture.FactureID)});


                    }
                    else
                    {
                        ViewBag.ErrorMessage = "Formulaire Semble etre mal Renseigné";
                        return View("Error");
                    }
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERLISTEREGLEMENTS()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_REGLEMENTS"))
                {
                    List<ReglementVM3> tempListeReglementVM = new List<ReglementVM3>();

                    List<REGLEMENT> tempListeReglement = dal.ObtenirTousLesReglements().OrderByDescending(f => f.DateCreation).ToList();

                    ReglementVM3 ReglementVM;
                    foreach (var r in tempListeReglement)
                    {
                        ReglementVM = new ReglementVM3();
                        ReglementVM = dal.ConvertirReglementReglementVM3(r);
                        tempListeReglementVM.Add(ReglementVM);
                    }

                    return View("ConsulterListeReglements", tempListeReglementVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERREGLEMENT(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_REGLEMENT"))
                {
                    ReglementVM3 RVM = new ReglementVM3();

                    REGLEMENT reglement = dal.ObtenirReglementParId(CRYPTAGE.StringHelpers.Encrypt(Id));

                    if (reglement != null)
                    {
                        RVM = dal.ConvertirReglementReglementVM3(reglement);
                        return View("ConsulterReglement", RVM);
                    }

                    return RedirectToAction("CONSULTERLISTEREGLEMENTS");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult ENREGISTRERSORTIECAISSE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_SORTIE_CAISSE"))
                {
                    
                    return View("FormulaireSortieCaisse");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }

        [HttpPost]
        public ActionResult ENREGISTRERSORTIECAISSE(String Caisse)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_SORTIE_CAISSE"))
                {
                    // *******************************
                    //     Code
                    // *******************************

                    return View("KKKKKKKK");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERSORTIESCAISSE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_SORTIES_CAISSE"))
                {
                    // *******************************
                    //     Code
                    // *******************************

                    return View("KKKKKKKK");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult CONSULTEROPERATIONSCAISSE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_OPERATIONS_CAISSE"))
                {
                    List<CAISSEMOUVEMENT> tempListeCaisseMvt = dal.ObtenirTousLesCaisseMouvements().OrderByDescending(f => f.DateCreation).ToList();
                    
                    return View("ConsulterHistoriqueOperationsCaisse", tempListeCaisseMvt);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult HISTORIQUEOUVERTUREFERMETURECAISSES()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "HISTORIQUE_OUVERTURE_FERMETURE_CAISSES"))
                {
                    // *******************************
                    //     Code
                    // *******************************

                    return View("KKKKKKKK");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult GENERERFACTURECONSULTATION(String id)
        {

            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "GENERER_FACTURE_CONSULTATION"))
                {
                    if (ModelState.IsValid)
                    {
                        FACTURE facture = new FACTURE();

                        facture.Dossier = dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(id));
                        facture.Utilisateur = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);


                        facture.FactureID = dal.EnregistrerFacture(facture);


                        if (!String.IsNullOrEmpty(facture.FactureID))
                        {
                            FACTURE fact = dal.ObtenirFactureParId(facture.FactureID);
                            PRODUIT prod = dal.ObtenirProduitParId("R15H0520O0701190455P669                     ");

                            if(fact != null && prod != null)
                            {
                                FACTUREDETAILS factureDetails = new FACTUREDETAILS();
                                factureDetails.Facture = fact;
                                factureDetails.Produit = prod;
                                factureDetails.Quantite = 1;
                                factureDetails.PrixUnitaire = prod.PrixVente;
                                dal.EnregistrerFactureDetail(factureDetails);

                                return RedirectToAction("CONSULTERLISTEFACTURES");
                            }
                            else
                            {
                                return View("FormulaireAjoutFacture");
                            }
                        }
                        else
                        {
                            return View("FormulaireAjoutFacture");
                        }

                    }
                    else
                    {
                        return View("FormulaireAjoutFacture");
                    }
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult RECHERCHERDOSSIER()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_DOSSIER"))
                {
                    return View("FormulaireRechercheDossier", null);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpPost]
        public ActionResult RECHERCHERDOSSIER(String code, String nom, int sexe)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_DOSSIER"))
                {
                    List<SearchDossier> resultatRecherche = new List<SearchDossier>();
                    List<DOSSIER> tempListedossier;

                    if (!String.IsNullOrEmpty(code))
                    {

                        code = dal.NettoyerChaine(code);

                        tempListedossier = dal.ObtenirListeDossierParCode(code);
                        foreach (var d in tempListedossier)
                        {
                            if (d != null)
                            {
                                if (sexe != -1)
                                {
                                    if (d.Patient.Sexe == sexe)
                                        resultatRecherche.Add(dal.ConvertirDossierSearchDossier(d));
                                }
                                else resultatRecherche.Add(dal.ConvertirDossierSearchDossier(d));
                            }

                        }

                    }
                    if (!String.IsNullOrEmpty(nom))
                    {
                        String[] nomDecouper = nom.Split(' ');
                        List<PERSONNE> tempListe = new List<PERSONNE>();
                        for (int i = 0; i < nomDecouper.Length; i++)
                        {
                            tempListe.AddRange(dal.RechercherCorrespondancesNomPersonne(nomDecouper[i]));
                        }
                        List<DOSSIER> tempListDossier = new List<DOSSIER>();
                        foreach (var p in tempListe)
                            tempListDossier.Add(dal.RecupererDossierPersonne(p));

                        foreach (var d in tempListDossier)
                        {
                            if (d != null)
                            {
                                if (sexe != -1)
                                {
                                    if (d.Patient.Sexe == sexe)
                                        if (!d.Archived)
                                            resultatRecherche.Add(dal.ConvertirDossierSearchDossier(d));

                                }
                                else
                                {
                                    if (!d.Archived)
                                        resultatRecherche.Add(dal.ConvertirDossierSearchDossier(d));
                                }
                            }

                        }
                    }
                    return PartialView("PartialViewSearchDossierFacture", resultatRecherche.Distinct().OrderBy(r => r.Nom));

                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }

            }


        }



    }

}


