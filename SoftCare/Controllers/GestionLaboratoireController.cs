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
    public class GestionLaboratoireController : Controller
    {

        [HttpGet]
        public ActionResult ENREGISTRERTYPEEXAMEN()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_TYPE_EXAMEN"))
                {

                    EXAMENTYPE examenType = new EXAMENTYPE();
                    ViewBag.ListeExamenType = dal.ObtenirTousLesExamenTypes();
                    return View("FormulaireAjoutTypeExamen", examenType);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult ENREGISTRERTYPEEXAMEN(EXAMENTYPE ExamenType)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_TYPE_EXAMEN"))
                {
                    if (ModelState.IsValid)
                    {
                        EXAMENTYPE et = new EXAMENTYPE();

                        et.Libelle = ExamenType.Libelle;
                        et.Prix = ExamenType.Prix;
                        et.Description = ExamenType.Description;

                        dal.EnregistrerExamenType(et);

                        return RedirectToAction("CONULTERLISTETYPEEXAMENS");
                    }
                    return RedirectToAction("ENREGISTRERTYPEEXAMEN");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERLISTETYPEEXAMENS()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_TYPE_EXAMENS"))
                {
                    List<EXAMENTYPE> tempListeExamenType = dal.ObtenirTousLesExamenTypes();

                    return View("ConsulterListeTypeExamens", tempListeExamenType);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult CONSULTERTYPEEXAMEN(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_TYPE_EXAMEN"))
                {

                    EXAMENTYPE typeExamen = dal.ObtenirExamenTypeParId(CRYPTAGE.StringHelpers.Encrypt(Id));

                    return View("ConsulterTypeExamen", typeExamen);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult ENREGISTREREXAMEN(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_EXAMEN"))
                {
                    DIAGNOSTIC Diagnostic = dal.ObtenirDiagnosticParId(CRYPTAGE.StringHelpers.Encrypt(Id));

                    if (Diagnostic != null)
                    {
                        DOSSIER Dossier = dal.ObtenirDossierParId(Diagnostic.Dossier.DossierID);

                        if (Dossier != null)
                        {
                            UTILISATEUR Medecin = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);
                            if (Medecin != null)
                            {
                                ExamenVM EVM = new ExamenVM();
                                EVM.DiagnosticId = Diagnostic.DiagnosticId;
                                EVM.Medecin = CRYPTAGE.StringHelpers.Decrypt(Medecin.Personne.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(Medecin.Personne.Prenom);
                                EVM.Patient = CRYPTAGE.StringHelpers.Decrypt(Dossier.Patient.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(Dossier.Patient.Prenom);
                                EVM.DossierId = Dossier.DossierID;
                                EVM.CodeDossier = CRYPTAGE.StringHelpers.Decrypt(Dossier.Code);
                                EVM.MedecinId = Medecin.UtilisateurID;

                                List<EXAMENMEDICAL> TempListeExamenMedical = dal.ObtenirTousLesExamenMedicaux();
                                List<ExamenMedicalVM> ListeExamenMedicalVM = new List<ExamenMedicalVM>();
                                ExamenMedicalVM examMedicalVM;

                                foreach (var examMedical in TempListeExamenMedical)
                                {
                                    examMedicalVM = new ExamenMedicalVM();
                                    ListeExamenMedicalVM.Add(dal.ConvertirExamenMedicalExamenMedicalVM(examMedical));
                                }

                                EVM.Examens = ListeExamenMedicalVM;

                                ViewBag.ListeExamenType = dal.ObtenirTousLesExamenTypes();
                                ViewBag.ListeService = dal.ObtenirTousLesServices();

                                return View("FormulaireAjoutExamen", EVM);
                            }
                            else
                            {
                                ViewBag.ErrorMessage = "Veuillez séléctionner un Médecin svp.";
                                return View("Error");
                            }
                        }
                        else
                        {
                            ViewBag.ErrorMessage = "Veuillez séléctionner un Dossier Patient svp.";
                            return View("Error");
                        }
                    }
                    else
                    {
                        ViewBag.ErrorMessage = "Veuillez séléctionner un Diagnostic ayant declenché cet examen médical svp.";
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
        public ActionResult ENREGISTREREXAMEN(ExamenVM EVM, String[] IdsExamenAPrescrire)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_EXAMEN"))
                {

                    if (ModelState.IsValid)
                    {
                        List<String> ListeIdsExamenAPrescrire = new List<string>();


                        if (IdsExamenAPrescrire != null)
                        {
                            foreach (var ExamId in IdsExamenAPrescrire)
                            {
                                if (ExamId != "false")
                                {
                                    ListeIdsExamenAPrescrire.Add(ExamId);
                                }
                            }
                        }

                        EXAMEN exam = new EXAMEN();

                        exam.Dossier = dal.ObtenirDossierParId(EVM.DossierId);
                        exam.Utilisateur = dal.ObtenirUtilisateurParId(EVM.MedecinId);
                        exam.Service = dal.ObtenirServiceParId(EVM.ServiceId);
                        exam.ExamenType = dal.ObtenirExamenTypeParId(EVM.ExamenTypeId);
                        exam.DateExamen = EVM.DateExamen;
                        exam.Description = EVM.Description;

                        if (ListeIdsExamenAPrescrire != null)
                        {
                            exam.ExamenID = dal.EnregistrerExamen(exam);

                            if (exam.ExamenID != null)
                            {
                                foreach (var ExamId in ListeIdsExamenAPrescrire)
                                {
                                    EXAMENMEDICAL examMedical = dal.ObtenirExamenMedicalParId(ExamId);
                                    if (examMedical != null)
                                    {
                                        EXAMENDETAILS ExamDetails = new EXAMENDETAILS();
                                        ExamDetails.Examen = dal.ObtenirExamenParId(exam.ExamenID);
                                        ExamDetails.ExamenMedical = examMedical;

                                        dal.EnregistrerExamenDetails(ExamDetails);
                                    }
                                }


                            }
                        }

                        return RedirectToAction("CONSULTERLISTEEXAMENS");
                    }
                    return RedirectToAction("ENREGISTREREXAMEN");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERLISTEEXAMENS()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_EXAMENS"))
                {
                    List<ExamenVM2> tempListeExamenVM = new List<ExamenVM2>();
                    List<EXAMEN> tempListeExamens = dal.ObtenirTousLesExamens();
                    ExamenVM2 examVM;

                    foreach (var exam in tempListeExamens)
                    {
                        examVM = new ExamenVM2();
                        examVM = dal.ConvertirExamenExamenVM2(exam);
                        tempListeExamenVM.Add(examVM);
                    }

                    return View("ConsulterListeExamens", tempListeExamenVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult CONSULTEREXAMEN(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_EXAMEN"))
                {
                    ExamenVM2 tempExamenVM = new ExamenVM2();
                    EXAMEN Examen = dal.ObtenirExamenParId(CRYPTAGE.StringHelpers.Encrypt(Id));
                    tempExamenVM = dal.ConvertirExamenExamenVM2(Examen);

                    return View("ConsulterExamen", tempExamenVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult ENREGISTRERRESULTAT(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_RESULTAT"))
                {
                    EXAMEN Examen = dal.ObtenirExamenParId(CRYPTAGE.StringHelpers.Encrypt(Id));
                    if (Examen != null)
                    {
                        ResultatVM RVM = new ResultatVM();

                        RVM.ExamenId = Examen.ExamenID;
                        RVM.ExamenType = Examen.ExamenType.Libelle;
                        RVM.ReferenceExam = CRYPTAGE.StringHelpers.Decrypt(Examen.Reference);
                        //RVM.Description = CRYPTAGE.StringHelpers.Decrypt(Examen.Description);
                        RVM.Patient = CRYPTAGE.StringHelpers.Decrypt(Examen.Dossier.Patient.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(Examen.Dossier.Patient.Nom);
                        RVM.Medecin = CRYPTAGE.StringHelpers.Decrypt(Examen.Utilisateur.Personne.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(Examen.Utilisateur.Personne.Prenom);


                        List<EXAMENDETAILS> examDetails = dal.ObtenirExamenDetailsParExamenId(Examen.ExamenID);
                        List<ExamenDetailsVM> examDetailsVM = new List<ExamenDetailsVM>();

                        ExamenDetailsVM examMVM;

                        foreach (var examDetail in examDetails)
                        {
                            examMVM = new ExamenDetailsVM();
                            examDetailsVM.Add(dal.ConvertirExamenDetailsExamenDetailsVM(examDetail));
                        }

                        RVM.Examens = examDetailsVM;

                        return View("FormulaireAjoutResultat", RVM);

                    }
                    else
                    {
                        ViewBag.ErrorMessage = "Veuillez séléctionner un Examen svp.";
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
        public ActionResult ENREGISTRERRESULTAT(ResultatVM RVM, String[] IdsExamenPrescris, String[] Resultats, String[] Commentaires)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_RESULTAT"))
                {

                    if (ModelState.IsValid)
                    {
                        List<ResultatVM2> ListeIdsExamenPrescris = new List<ResultatVM2>();
                        ResultatVM2 ExamenPrescris;


                        if (IdsExamenPrescris != null)
                        {
                            int i = 0;
                            foreach (var ExamId in IdsExamenPrescris)
                            {
                                if (ExamId != "false")
                                {
                                    ExamenPrescris = new ResultatVM2();

                                    ExamenPrescris.ExamenId = ExamId;

                                    if (Resultats[i] == "on")
                                    {
                                        ExamenPrescris.EstNegatif = false;
                                    }
                                    else
                                    {
                                        ExamenPrescris.EstNegatif = true;
                                    }

                                    ExamenPrescris.Description = Commentaires[i];

                                    ListeIdsExamenPrescris.Add(ExamenPrescris);
                                }
                                i += 1;
                            }
                        }

                        RESULTAT result = new RESULTAT();

                        result.Examen = dal.ObtenirExamenParId(RVM.ExamenId);
                        result.Description = RVM.Description;

                        if (ListeIdsExamenPrescris != null)
                        {
                            result.ResultatID = dal.EnregistrerResultat(result);

                            if (result.ResultatID != null)
                            {
                                foreach (var Exam in ListeIdsExamenPrescris)
                                {
                                    EXAMENDETAILS ExamDetails = dal.ObtenirExamenDetailsParId(Exam.Id);
                                    if (ExamDetails != null)
                                    {
                                        ExamDetails.Description = Exam.Description;
                                        ExamDetails.EstNegatif = Exam.EstNegatif;

                                        dal.EnregistrerExamenDetails(ExamDetails);
                                    }
                                }
                            }
                        }

                        return RedirectToAction("CONSULTERLISTERESULTATS");
                    }
                    return RedirectToAction("ENREGISTRERRESULTAT");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERLISTERESULTATS()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_RESULTATS"))
                {

                    List<ResultatVM3> tempListeResultatVM = new List<ResultatVM3>();

                    List<RESULTAT> tempListeResultats = dal.ObtenirTousLesResultats();

                    ResultatVM3 resultVM;
                    foreach (var result in tempListeResultats)
                    {
                        resultVM = new ResultatVM3();
                        resultVM = dal.ConvertirResultatResultatVM(result);
                        tempListeResultatVM.Add(resultVM);
                    }

                    return View("ConsulterListeResultats", tempListeResultatVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult CONSULTERRESULTAT(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_RESULTAT"))
                {

                    ResultatVM3 tempResultatVM = new ResultatVM3();
                    RESULTAT Resultat = dal.ObtenirResultatParId(CRYPTAGE.StringHelpers.Encrypt(Id));
                    tempResultatVM = dal.ConvertirResultatResultatVM(Resultat);

                    return View("ConsulterResultat", tempResultatVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult ENREGISTREREXAMENMEDICAL()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_EXAMEN_MEDICAL"))
                {
                    ExamenMedicalVM EMVM = new ExamenMedicalVM();
                    ViewBag.ListeExamenType = dal.ObtenirTousLesExamenTypes();
                    return View("FormulaireAjoutExamenMedical", EMVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult ENREGISTREREXAMENMEDICAL(ExamenMedicalVM EMVM)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_EXAMEN_MEDICAL"))
                {
                    if (ModelState.IsValid)
                    {
                        EXAMENMEDICAL examenMedical = new EXAMENMEDICAL();

                        examenMedical.Code = EMVM.Code;
                        examenMedical.Description = EMVM.Description;
                        examenMedical.Libelle = EMVM.Libele;
                        examenMedical.ExamenType = dal.ObtenirExamenTypeParId(EMVM.ExamenTypeId);

                        dal.EnregistrerExamenMedical(examenMedical);

                        return RedirectToAction("CONULTERLISTEEXAMENMEDICAUX");
                    }
                    return RedirectToAction("ENREGISTREREXAMENMEDICAL");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTERLISTEEXAMENMEDICAUX()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_EXAMEN_MEDICAUX"))
                {
                    List<ExamenMedicalVM> tempListeExamenMedicalVM = new List<ExamenMedicalVM>();
                    List<EXAMENMEDICAL> tempListeStock = dal.ObtenirTousLesExamenMedicaux();

                    return View("ConsulterListeExamensMedicaux", tempListeStock);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult CONSULTEREXAMENMEDICAL(String Id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_EXAMEN_MEDICAL"))
                {
                    ExamenMedicalVM EMVM = new ExamenMedicalVM();
                    EXAMENMEDICAL examenMedical = dal.ObtenirExamenMedicalParId(CRYPTAGE.StringHelpers.Encrypt(Id));
                    EMVM = dal.ConvertirExamenMedicalExamenMedicalVM(examenMedical);

                    return View("ConsulterExamenMedical", EMVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult RECHERCHEREXAMEN()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_EXAMEN"))
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

                    return View("FormulaireRechercheExamen");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult RECHERCHEREXAMEN(String Reference, String FabricantId, String StockId)
        {

            using (IDAL dal = new Dal())
            {
                List<ProduitVM2> resultatRecherche = new List<ProduitVM2>();

                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_EXAMEN"))
                {
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

                    return PartialView("PartialViewSearchExamen", resultatRecherche.Distinct().OrderBy(r => r.ReferenceProduit));
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult ENREGISTRERMATERIEL()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_MATERIEL"))
                {

                    return View("FormulaireAjoutMateriel");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult ENREGISTRERMATERIEL(LABORATOIREOUTILS laboOutils) 
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_MATERIEL"))
                {
                    if (ModelState.IsValid)
                    {

                        LABORATOIREOUTILS materiel = new LABORATOIREOUTILS();

                        dal.EnregistrerLaboratoireOutil(laboOutils);
                    }

                        return View("ConsulterListeMateriels");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult RECHERCHERMATERIEL()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_MATERIEL"))
                {
                    return View("FormulaireRechercheMateriel");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        public ActionResult RECHERCHERMATERIEL(String Exam)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_MATERIEL"))
                {
                    // *******************************
                    //     Code
                    // *******************************

                    return View("FormulaireRechercheMateriel");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult CONSULTERLISTEMATERIEL()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_MATERIEL"))
                {
                  
                    return View("ConsulterListeMateriels");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        public ActionResult DASHBOARDLABORATOIRE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "DASHBOARD_LABORATOIRE"))
                {
                    // *******************************
                    //     Code
                    // *******************************

                    return View("");
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


