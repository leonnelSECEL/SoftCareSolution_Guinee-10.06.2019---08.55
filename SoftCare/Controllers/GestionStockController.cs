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
    public class GestionStockController : Controller
    {
        [HttpGet]
        public ActionResult ENREGISTRERPRODUIT()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_PRODUIT"))
                {
                    List<STOCK> ListeStock = dal.ObtenirTousLesStocks();
                    List<StockVM> ListeStockVM = new List<StockVM>();
                    if (ListeStock != null)
                    {
                        foreach (var stock in ListeStock)
                        {
                            ListeStockVM.Add(dal.ConvertirStockStockVM(stock));
                        }
                    }

                    ViewBag.ListeStock = ListeStockVM;

                    List<RAYON> ListeRayon = dal.ObtenirTousLesRayons();
                    List<RayonVM> ListeRayonVM = new List<RayonVM>();
                    if (ListeRayon != null)
                    {
                        foreach (var rayon in ListeRayon)
                        {
                            ListeRayonVM.Add(dal.ConvertirRayonRayonVM(rayon));
                        }
                    }

                    ViewBag.ListeRayon = ListeRayonVM;

                    List<FABRICANT> ListeFabricant = dal.ObtenirTousLesFabricants();
                    List<FabricantVM> ListeFabricantVM = new List<FabricantVM>();
                    if (ListeFabricant != null)
                    {
                        foreach (var fabricant in ListeFabricant)
                        {
                            ListeFabricantVM.Add(dal.ConvertirFabricantFabricantVM(fabricant));
                        }
                    }

                    ViewBag.ListeFabricant = ListeFabricantVM;

                    return View("FormulaireAjoutProduit");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }

        [HttpPost]
        public ActionResult ENREGISTRERPRODUIT(ProduitVM ProduitVM)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_PRODUIT"))
                {

                    if (ModelState.IsValid)
                    {
                        PRODUIT produit = new PRODUIT();

                        produit.ProduitID = ProduitVM.ProduitID;
                        produit.Stock = dal.ObtenirStockParId(ProduitVM.StockID);
                        produit.Rayon = dal.ObtenirRayonParId(ProduitVM.RayonID);
                        produit.Fabricant = dal.ObtenirFabricantParId(ProduitVM.FabricantID);
                        produit.Nom = ProduitVM.Nom;
                        produit.PrixVente = ProduitVM.PrixVente;
                        produit.PrixAchat = ProduitVM.PrixAchat;
                        produit.ReferenceExterne = ProduitVM.ReferenceExterne;
                        produit.Description = ProduitVM.Description;

                        produit.ProduitID = dal.EnregistrerProduit(produit);


                        STOCKDETAILS stockDetails = new STOCKDETAILS()
                        {
                            Produit = dal.ObtenirProduitParId(produit.ProduitID),
                            Stock = dal.ObtenirStockParId(ProduitVM.StockID),
                            StockAlert = ProduitVM.SeuilAlert
                        };

                        stockDetails.StockDetailsID = dal.EnregistrerProduitEnStock(stockDetails);

                        return RedirectToAction("CONSULTERLISTEPRODUITS");
                    }
                    else
                    {
                        ViewBag.ErrorMessage = "Veuillez remplir correctement le formulaire et reessayez svp.";
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
        public ActionResult CONSULTERLISTEPRODUITS()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_PRODUITS"))
                {

                    List<ProduitVM2> tempListeProduitVM = new List<ProduitVM2>();

                    STOCK StockPrincipal = dal.ObtenirStockPrincipal();

                    if (StockPrincipal != null)
                    {
                        List<PRODUIT> tempListeProduit = dal.ObtenirProduitParStockId(StockPrincipal.StockID);

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
                        ViewBag.ErrorMessage = "Verifiez si vous avez bien definit un stock en Stock Principal.";
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
        public ActionResult RECHERCHERPRODUIT()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_PRODUIT"))
                {
                    TransfertStockVM TransfertStock = new TransfertStockVM();
                    List<STOCK> ListeStock = dal.ObtenirTousLesStocks();
                    List<StockVM> ListeStockVM = new List<StockVM>();
                    if (ListeStock != null)
                    {
                        foreach (var stock in ListeStock)
                        {
                            ListeStockVM.Add(dal.ConvertirStockStockVM(stock));
                        }
                    }
                    ViewBag.ListeStock = ListeStockVM;

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
        public ActionResult RECHERCHERPRODUIT(String Reference, String FabricantId, String StockId)
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

                        tempListeProduit = dal.ObtenirProduitParReference(Reference);

                        foreach (var p in tempListeProduit)
                        {
                            if (p != null)
                            {
                                if (!String.IsNullOrEmpty(FabricantId) && FabricantId != "0")
                                {
                                    if (p.Fabricant.FabricantID == FabricantId)
                                    {
                                        if (!String.IsNullOrEmpty(StockId) && StockId != "0")
                                        {
                                            if (p.Stock.StockID == StockId)
                                            {
                                                resultatRecherche.Add(dal.ConvertirProduitProduitVM2(p));
                                            }
                                        }
                                        else
                                        {
                                            resultatRecherche.Add(dal.ConvertirProduitProduitVM2(p));
                                        }
                                    }

                                }
                                else
                                {
                                    if (!String.IsNullOrEmpty(StockId) && StockId != "0")
                                    {
                                        if (p.Stock.StockID == StockId)
                                        {
                                            resultatRecherche.Add(dal.ConvertirProduitProduitVM2(p));
                                        }
                                    }
                                    else
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
                            tempListeProduit = dal.ObtenirProduitParFabricantId(FabricantId);

                            foreach (var p in tempListeProduit)
                            {
                                if (p != null)
                                {
                                    if (!String.IsNullOrEmpty(StockId) && StockId != "0")
                                    {
                                        if (p.Stock.StockID == StockId)
                                        {
                                            resultatRecherche.Add(dal.ConvertirProduitProduitVM2(p));
                                        }
                                    }
                                    else
                                    {
                                        resultatRecherche.Add(dal.ConvertirProduitProduitVM2(p));
                                    }
                                }
                            }
                        }
                        else
                        {
                            tempListeProduit = dal.ObtenirProduitParStockId(StockId);

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
        public ActionResult APPROVISIONNERPRODUITS()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "APPROVISIONNER_PRODUITS"))
                {
                    ApprovisionnementStockVM ApprovisionnementVM = new ApprovisionnementStockVM();
                    STOCK StockPrincipal = dal.ObtenirStockPrincipal();

                    if (StockPrincipal != null)
                    {
                        ApprovisionnementVM.NomStock = CRYPTAGE.StringHelpers.Decrypt(StockPrincipal.Nom);
                        ApprovisionnementVM.StockId = StockPrincipal.StockID;

                        List<PRODUIT> ListeProduit = dal.ObtenirProduitParStockId(StockPrincipal.StockID);

                        List<ProduitVM> ListeProduitVM = new List<ProduitVM>();
                        if (ListeProduit != null)
                        {
                            foreach (var produit in ListeProduit)
                            {
                                ListeProduitVM.Add(dal.ConvertirProduitProduitVM(produit));
                            }
                        }
                        ApprovisionnementVM.Produits = ListeProduitVM;


                        return View("FormulaireApprovisionnementStock", ApprovisionnementVM);
                    }
                    else
                    {
                        ViewBag.ErrorMessage = "Verifiez si vous avez defini le Magasin comme stock Principal svp. ";
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
        public ActionResult APPROVISIONNERPRODUITS(ApprovisionnementStockVM ASVM, String[] IdsProduitAApprovionner, String[] QuantiteApprovisionner, String[] DateExpiration)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "APPROVISIONNER_PRODUITS"))
                {
                    List<ApprovisionnementStockVM2> ListeAppro = new List<ApprovisionnementStockVM2>();

                    if (IdsProduitAApprovionner != null)
                    {

                        ApprovisionnementStockVM2 Appro;
                        int i = 0;

                        foreach (var ProduitId in IdsProduitAApprovionner)
                        {
                            Appro = new ApprovisionnementStockVM2();

                            if (ProduitId != "false")
                            {
                                Appro.ProduitId = ProduitId;

                                int Qte;
                                if (Int32.TryParse(QuantiteApprovisionner[i], out Qte))
                                {
                                    Appro.Quantite = Qte;
                                }

                                DateTime DateExp;
                                if (DateTime.TryParse(DateExpiration[i], out DateExp))
                                {
                                    Appro.DateExpiration = DateExp;
                                }

                                ListeAppro.Add(Appro);

                            }
                            i++;
                        }
                    }

                    if (ListeAppro != null)
                    {
                        int i = 0;
                        foreach (var Appro in ListeAppro)
                        {
                            if (Appro != null)
                            {
                                PRODUIT Prod = dal.ObtenirProduitParId(Appro.ProduitId);

                                if (Prod != null)
                                {
                                    STOCKDETAILS StockDetail = new STOCKDETAILS();
                                    StockDetail.Produit = Prod;

                                    STOCK stock = dal.ObtenirStockParId(ASVM.StockId);
                                    if (stock != null)
                                    {
                                        StockDetail.Stock = stock;
                                        StockDetail.DateExpiration = Appro.DateExpiration;
                                        StockDetail.StockQuantity = Appro.Quantite;

                                        List<STOCKDETAILS> StockDetailExistant = dal.ObtenirStockDetailsParProduitParStockParDateExpiration(Prod.ProduitID, stock.StockID, StockDetail.DateExpiration);
                                        Boolean EstUneMAJ = false;

                                        foreach (var stkd in StockDetailExistant)
                                        {
                                            if (stkd != null && stkd.DateExpiration == StockDetail.DateExpiration)
                                            {
                                                stkd.StockQuantity += StockDetail.StockQuantity;
                                                dal.EnregistrerProduitEnStock(stkd);
                                                EstUneMAJ = true;
                                                break;
                                            }
                                        }

                                        if (!EstUneMAJ)
                                        {
                                            dal.EnregistrerProduitEnStock(StockDetail);
                                        }
                                    }
                                }
                            }

                            i++;
                        }

                    }

                    return RedirectToAction("APPROVISIONNERPRODUITS");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }

            }

        }

        [HttpGet]
        public ActionResult TRANSFERERSTOCK()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "TRANSFERER_STOCK"))
                {
                    TransfertStockVM TSVM = new TransfertStockVM();
                    List<PRODUIT> ListeProduit = dal.ObtenirTousLesProduits();
                    List<ProduitVM> ListeProduitVM = new List<ProduitVM>();
                    if (ListeProduit != null)
                    {
                        foreach (var produit in ListeProduit)
                        {
                            ListeProduitVM.Add(dal.ConvertirProduitProduitVM(produit));
                        }
                    }
                    TSVM.Produits = ListeProduitVM;

                    ViewBag.ListeStock = dal.ObtenirTousLesStocks();

                    return View("FormulaireTransfertStock", TSVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }

        [HttpPost]
        public ActionResult TRANSFERERSTOCK(TransfertStockVM TSVM, String[] IdsProduitATransferer, String[] QuantiteATransferer)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "TRANSFERER_STOCK"))
                {
                    List<TransfertStockVM2> ListeProduitsTransfert = new List<TransfertStockVM2>();

                    if (IdsProduitATransferer != null)
                    {
                        TransfertStockVM2 ProduitTransfert;
                        int i = 0;

                        foreach (var ProduitId in IdsProduitATransferer)
                        {
                            ProduitTransfert = new TransfertStockVM2();

                            if (ProduitId != "false")
                            {
                                ProduitTransfert.ProduitId = ProduitId;

                                int Qte;
                                if (Int32.TryParse(QuantiteATransferer[i], out Qte))
                                {
                                    ProduitTransfert.Quantite = Qte;
                                }
                                ListeProduitsTransfert.Add(ProduitTransfert);

                            }
                            i++;
                        }
                    }

                    if (ListeProduitsTransfert != null)
                    {
                        int i = 0;
                        foreach (var ProduitTransfert in ListeProduitsTransfert)
                        {
                            if (ProduitTransfert != null)
                            {
                                PRODUIT Prod = dal.ObtenirProduitParId(ProduitTransfert.ProduitId);

                                if (Prod != null)
                                {
                                    STOCK stock = dal.ObtenirStockParId(CRYPTAGE.StringHelpers.Encrypt(TSVM.StockFromId));
                                    if (stock != null)
                                    {
                                        List<STOCKDETAILS> StockDetailExistant = dal.ObtenirStockDetailsParProduitEtParStock(Prod.ProduitID, stock.StockID).OrderBy(stkd => stkd.DateExpiration).ToList();


                                        int QuantiteAInserer = ProduitTransfert.Quantite;
                                        int ResteAInserer = QuantiteAInserer;
                                        int QuantiteInseree = 0;

                                        foreach (var stkd in StockDetailExistant)
                                        {
                                            if (QuantiteAInserer >= QuantiteInseree)
                                            {
                                                if (stkd != null && stkd.StockQuantity > 0)
                                                {
                                                    STOCKDETAILS NewStkD = new STOCKDETAILS();
                                                    NewStkD.Produit = stkd.Produit;
                                                    NewStkD.DateExpiration = stkd.DateExpiration;
                                                    NewStkD.Stock = dal.ObtenirStockParId(CRYPTAGE.StringHelpers.Encrypt(TSVM.StockToId));

                                                    if (stkd.StockQuantity >= ResteAInserer)
                                                    {
                                                        NewStkD.StockQuantity = ResteAInserer;
                                                        QuantiteInseree += ResteAInserer;

                                                        stkd.StockQuantity = stkd.StockQuantity - ResteAInserer;

                                                        dal.EnregistrerProduitEnStock(NewStkD);

                                                        dal.EnregistrerProduitEnStock(stkd);

                                                        ResteAInserer = 0;
                                                    }
                                                    else
                                                    {
                                                        NewStkD.StockQuantity = stkd.StockQuantity;
                                                        QuantiteInseree += stkd.StockQuantity;

                                                        dal.EnregistrerProduitEnStock(NewStkD);

                                                        ResteAInserer = QuantiteAInserer - QuantiteInseree;
                                                        stkd.StockQuantity = 0;

                                                        dal.EnregistrerProduitEnStock(stkd);
                                                    }
                                                }
                                            }
                                            else
                                            {
                                                break;
                                            }
                                        }
                                    }
                                }
                            }

                            i++;
                        }
                        return RedirectToAction("TRANSFERERSTOCK");
                    }
                    else
                    {
                        ViewBag.ErrorMessage = "Veuillez selectionner les produits à transferer.";
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
        public ActionResult HISTORIQUEMOUVEMENTSTOCK()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "HISTORIQUE_MOUVEMENT_STOCK"))
                {
                    // *******************************
                    //     Code
                    // *******************************

                    return View("ConsultationHistoriqueMvtStock");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult ENREGISTRERSTOCK()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_STOCK"))
                {
                    StockVM2 StockVM = new StockVM2();
                    ViewBag.ListeSpecialiste = new SelectList(dal.ObtenirTousLesSpecialistes(), "Id", "NomSpecialiste");
                    ViewBag.ListeStockType = dal.ObtenirTousLesStockTypes();
                    return View("FormulaireAjoutStock", StockVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult ENREGISTRERSTOCK(StockVM2 SVM)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_STOCK"))
                {

                    if (ModelState.IsValid)
                    {
                        STOCK stock = new STOCK();

                        stock.Nom = SVM.Nom;
                        stock.Utilisateur = dal.ObtenirUtilisateurParId(SVM.ResponsableStock);
                        stock.IsStocktCentral = SVM.IsStocktCentral;
                        stock.StockType = dal.ObtenirStockTypeParId(SVM.TypeStockId);

                        stock.StockID = dal.EnregistrerStock(stock);

                        if (stock.IsStocktCentral)
                        {
                            dal.MettreStockStockPrincipal(stock);
                        }

                        return RedirectToAction("CONSULTERLISTESTOCKS");
                    }
                    return RedirectToAction("ENREGISTRERSTOCK");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERLISTESTOCKS()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTERLISTE_STOCKS"))
                {
                    List<StockVM2> tempListeStockVM = new List<StockVM2>();

                    List<STOCK> tempListeStock = dal.ObtenirTousLesStocks();

                    StockVM2 prodVM;
                    foreach (var p in tempListeStock)
                    {
                        prodVM = new StockVM2();
                        prodVM = dal.ConvertirStockStockVM2(p);
                        tempListeStockVM.Add(prodVM);
                    }

                    return View("ConsulterListeStocks", tempListeStockVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult CONSULTERSTOCK(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_STOCK"))
                {

                    StockVM2 tempStockVM = new StockVM2();
                    STOCK Stock = dal.ObtenirStockParId(CRYPTAGE.StringHelpers.Encrypt(Id));
                    tempStockVM = dal.ConvertirStockStockVM2(Stock);

                    return View("ConsulterStock", tempStockVM);
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


