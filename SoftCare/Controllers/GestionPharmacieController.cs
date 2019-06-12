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
    public class GestionPharmacieController : Controller
    {
        [HttpGet]
        public ActionResult ENREGISTRERLIVRAISONPRODUIT(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_LIVRAISON_PRODUIT"))
                {
                    return View("FormulaireAjoutLivraison");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult ENREGISTRERLIVRAISONPRODUIT(LIVRAISON Livraison)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_LIVRAISON_PRODUIT"))
                {
                    return View("ConsultationListeLivraisons");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERINFOSLIVRAISON(String Caisse)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_INFOS_LIVRAISON"))
                {
                    return View("ConsulterDetailsLivraison");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult RECHERCHERPRODUIT()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_PRODUIT"))
                {
                    TransfertStockVM TransfertStock = new TransfertStockVM();
                    List<FABRICANT> ListeFabricant = dal.ObtenirTousLesFabricants();
                    ViewBag.ListeFabricant = ListeFabricant;
                    return View("FormulaireRechercheProduit");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult RECHERCHERPRODUIT(String Reference, String FabricantId, String StockTypeId)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_PRODUIT"))
                {
                    List<ProduitVM2> resultatRecherche = new List<ProduitVM2>();
                    List<PRODUIT> tempListeProduit;

                    if (!String.IsNullOrEmpty(Reference))
                    {
                        Reference = dal.NettoyerChaine(Reference);

                        tempListeProduit = dal.ObtenirProduitParReferenceEtStocktType(Reference, StockTypeId);

                        foreach (var p in tempListeProduit)
                        {
                            if (p != null)
                            {
                                if (!String.IsNullOrEmpty(FabricantId) && FabricantId != "0")
                                {
                                    if (p.Fabricant.FabricantID == FabricantId)
                                    {
                                        resultatRecherche.Add(dal.ConvertirProduitProduitVM2(p));
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        if (!String.IsNullOrEmpty(FabricantId) && FabricantId != "0")
                        {
                            tempListeProduit = dal.ObtenirProduitParFabricantEtStocktType(FabricantId, StockTypeId);

                            foreach (var p in tempListeProduit)
                            {
                                if (p != null)
                                {
                                    resultatRecherche.Add(dal.ConvertirProduitProduitVM2(p));
                                }
                            }
                        }
                    }
                    return PartialView("PartialViewSearchProduit", resultatRecherche.Distinct().OrderBy(r => r.ReferenceProduit));
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERPRODUIT(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_PRODUIT"))
                {

                    ProduitVM2 tempProduitVM = new ProduitVM2();

                    PRODUIT Produit = dal.ObtenirProduitParId(Id);

                    tempProduitVM = dal.ConvertirProduitProduitVM20(Produit);


                    return View("ConsulterProduit", tempProduitVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERLISTEPRODUITS()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_PRODUITS"))
                {

                    List<ProduitVM2> tempListeProduitVM = new List<ProduitVM2>();

                    STOCK StockPharmacie = dal.ObtenirStockPharmacie();

                    if (StockPharmacie != null)
                    {
                        List<PRODUIT> tempListeProduit = dal.ObtenirProduitParStockId(StockPharmacie.StockID);

                        ProduitVM2 prodVM;
                        foreach (var p in tempListeProduit)
                        {
                            prodVM = new ProduitVM2();
                            prodVM = dal.ConvertirProduitProduitVM2(p);
                            tempListeProduitVM.Add(prodVM);
                        }
                        return View("ConsulterListeProduits", tempListeProduitVM);
                    }
                    else
                    {
                        ViewBag.ErrorMessage = "Verifiez si vous avez bien definit un stock de la Pharmacie.";
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
        public ActionResult HISTORIQUELIVRAISONS()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "HISTORIQUE_LIVRAISONS"))
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

        [HttpPost]
        public ActionResult HISTORIQUELIVRAISONS(String Produit)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "HISTORIQUE_LIVRAISONS"))
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
        public ActionResult RECHERCHERPAIEMENT()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_PAIEMENT"))
                {

                    return View("FormulaireRecherchePaiement", null);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }

        [HttpPost]
        public ActionResult RECHERCHERPAIEMENT(SearchReglementVM SearchRVM)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_PAIEMENT"))
                {
                    List<ReglementVM4> resultatRecherche = new List<ReglementVM4>();
                    List<DOSSIER> tempListeDossiers = new List<DOSSIER>();
                    List<FACTURE> tempListeFactures = new List<FACTURE>();
                    List<REGLEMENT> tempListeReglements = new List<REGLEMENT>();

                    if (!String.IsNullOrEmpty(SearchRVM.CodeDossierPatient))
                    {
                        tempListeDossiers = dal.ObtenirListeDossierParCode(dal.NettoyerChaine(SearchRVM.CodeDossierPatient));

                        foreach (var dossier in tempListeDossiers)
                        {
                            if (dossier != null)
                            {
                                tempListeFactures = dal.ObtenirFactureParDossierId(dossier.DossierID);

                                foreach (var facture in tempListeFactures)
                                {
                                    if (facture != null)
                                    {
                                        FACTURE f = dal.ObtenirFactureParId(facture.FactureID);

                                        if (f != null)
                                        {
                                            if (!String.IsNullOrEmpty(SearchRVM.ReferenceFacture))
                                            {
                                                if (f.Reference == SearchRVM.ReferenceFacture)
                                                {
                                                    tempListeReglements = dal.ObtenirTousLesReglementsParFactureId(f.FactureID);
                                                    break;
                                                }
                                            }
                                            else
                                            {
                                                tempListeReglements = dal.ObtenirTousLesReglementsParFactureId(f.FactureID);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else if (!String.IsNullOrEmpty(SearchRVM.ReferenceFacture))
                    {
                        FACTURE f = dal.ObtenirFactureParReference(CRYPTAGE.StringHelpers.Encrypt(dal.NettoyerChaine(SearchRVM.ReferenceFacture)));

                        if (f != null)
                        {
                            if (!String.IsNullOrEmpty(SearchRVM.ReferencePaiement))
                            {
                                List<REGLEMENT> ListeReglements = dal.ObtenirReglementParFactureId(f.FactureID);

                                foreach(var reg in ListeReglements)
                                {
                                    if (reg != null)
                                    {
                                        tempListeReglements.Add(reg);
                                    }
                                }                                
                            }
                            else
                            {
                                tempListeReglements = dal.ObtenirTousLesReglementsParFactureId(f.FactureID);
                            }
                        }
                    }
                    else if (!String.IsNullOrEmpty(SearchRVM.ReferencePaiement))
                    {
                        REGLEMENT reg = dal.ObtenirReglementParReference(CRYPTAGE.StringHelpers.Encrypt(dal.NettoyerChaine(SearchRVM.ReferencePaiement)));

                        if (reg != null)
                        {
                            tempListeReglements.Add(reg);
                        }
                    }

                    if (tempListeReglements.Count > 0)
                    {
                        foreach (var reg in tempListeReglements)
                        {
                            if (reg != null)
                            {
                                resultatRecherche.Add(dal.ConvertirReglementReglementVM4(reg));
                            }

                        }
                    }

                    return PartialView("PartialViewSearchPaiementProduit", resultatRecherche.Distinct().OrderBy(r => r.DateCreation));
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


