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
     *  TOUJOURS VERIFIER L'EXISTENCE DE L'OBJET A CONSULTER AU PREALABLE :
     *  
     *          - TRAITEMENT
     *          - DIAGNOSTIC
     *          - PARAMETRE
     *          - DOSSIER etc.
     * 
     ------------------------------------------------------------------------------------
     */


    //Cette marque rassure que seul un utilisateur authentifié puisse avoir accès à ce controlleur et donc ses actions)
    [Authorize]
    public class GestionPatientController : Controller
    {
        //
        // GET: /GestionPatient/

        public ActionResult Accueil()
        {
            return View();
        }

        //Cette action se charge des opérations de recherche afin de trouver un ou plusieurs dossiers de patients
        //Elle est liée à la vue "RecherchePatient" pour le résultat en lui envoyant un objet type List<SearchDossier>


        [HttpPost]
        public ActionResult RECHERCHERDOSSIER(String code, String nom, int sexe)
        {
            /* Code v1 - 31 Décembre 2017 - @Hn*/
            /* Code v2 - 02 Février 2018 - @Hn*/

            List<SearchDossier> resultatRecherche = new List<SearchDossier>();

            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_DOSSIER"))
                {

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
                    return PartialView("PartialViewSearchDossier", resultatRecherche.Distinct().OrderBy(r => r.Nom));
                    
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }

            }
            
            
        }


        //Cette action est celle qui est appellée en vue d'initialiaser la recherche. Se charge donc juste d'afficher le formulaire de recherche
        //en initialisant ce qui a lieu d'être

        [HttpGet]
        public ActionResult RECHERCHERDOSSIER()
        {
            /* Code v1 - 31 Décembre 2017 - @Hn*/
            using (IDAL dal = new Dal())
            if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RECHERCHER_DOSSIER"))
            {

                return View("FormulaireRecherchePatient", null);
            }
            else
            {
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                return View("Error");
            }
        }




        //Cette vue se charge toutes les opérations d'affichage d'une fiche patient (id == DossierID)
        //Elle est liée à la vue "FichePatient" pour le résultat en lui envoyant un objet type DossierVM

        [HttpGet]
        public ActionResult CONSULTERDOSSIER(String id)
        {
            /* Code v1 - 31 Décembre 2017 - @Hn*/

            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_DOSSIER"))
                {
                    DossierVM dossierPatient = dal.ConvertirDossierDossierVM(dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(id)), true);
                    if (dossierPatient != null)
                    {
                        if (!dossierPatient.Dossier.Archived)
                        {
                            ViewBag.NombreProgrammeIntegre = dal.ObtenirLesGroupesCiblesDunPatient(dossierPatient.Dossier.DossierID).Count();
                            ViewBag.DateNaissance = dal.FormateAge(dossierPatient.Dossier.Patient.DateNaissance);

                            UTILISATEUR user = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);
                            String roleName = CRYPTAGE.StringHelpers.Decrypt(user.Role.Intitule);
                            ViewBag.hasRole = (roleName == "MEDECIN") ? true : false;                             

                            //return View("ConsulterDossierPatient", dossierPatient);
                            return View("ConsulterDossierPatient", dossierPatient);
                        }
                        else
                            return View("ConsulterDossierPatientArchived", dossierPatient);
                    }
                    return View("Error");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }





        //Cette action se charge toutes les opérations de création d'un nouveau dossier patient. En mode HTTPGET,
        //elle se charge juste de présenter la vue typée PersonneVM (formulaire) servant à saisir les infos nécessaires à la création d'un sossier

        [HttpGet]
        public ActionResult CREERDOSSIER()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CREER_DOSSIER_PATIENT"))
                {
                    /* Code v1 - 31 Décembre 2017 - @Hn*/

                    GroupeCibleVM gcvm = new GroupeCibleVM();
                    //List<TYPEGROUPE> tempLG = dal.ObtenirTousLesTypesDeGC();
                    List<GROUPECIBLE> tempListeProgrammes = dal.ObtenirTousLesGroupeCibles();
                    foreach (var programme in tempListeProgrammes)
                    {
                        if (programme != null)
                        {
                            String  TypeGroupe = CRYPTAGE.StringHelpers.Decrypt(dal.ObtenirTypeGroupeParId(programme.Type.TypeGroupeID).Objet);
                            programme.Intitule = TypeGroupe + " - " + programme.Intitule;
                        }
                    }
                    ViewBag.ListeDesProgrammesSOS = tempListeProgrammes;

                    PersonneVM personnePatient = new PersonneVM();

                    return View("FormulaireAjoutDossier", personnePatient);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");

                }
            }
        }



        //Cette action se charge toutes les opérations de création d'un nouveau dossier patient. En mode HTTPPOST,
        //elle se charge de réellement créer le dossier avec l'objet type PersonneVM passé en paramètre ensuite de 
        //rediriger vers ConsulterDossier

        [HttpPost]
        public ActionResult CREERDOSSIER(PersonneVM personnePatient)
        {
            /* Code v1 - 31 Décembre 2017 - @Hn*/

            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CREER_DOSSIER_PATIENT"))
                {

                    if (ModelState.IsValid)
                    {
                        
                            PERSONNE personne = new PERSONNE();
                            DOSSIER dossier = new DOSSIER();
                            LIAISONDOSSIERGROUPECIBLE liaisonDossierGroupeC = new LIAISONDOSSIERGROUPECIBLE();
                            //CreerNouveauDossier
                            if (String.IsNullOrEmpty(personnePatient.Id) || String.IsNullOrWhiteSpace(personnePatient.Id))
                            {
                                personne.Nom = personnePatient.Nom;
                                personne.Prenom = personnePatient.Prenom;
                                personne.TelephonePrincipal = personnePatient.TelephonePrincipal;
                                personne.TelephoneSecondaire = personnePatient.TelephoneSecondaire;
                                personne.Adresse = personnePatient.Adresse;
                                personne.Email = personnePatient.Email;
                                personne.Sexe = personnePatient.Sexe;
                                personne.DateNaissance = personnePatient.DateNaissance;
                                personne.LieuNaissance = personnePatient.LieuNaissance;

                                personne.PersonneID = dal.EnregistrerPersonne(personne);


                                dossier.PenseBete = personnePatient.PenseBete;
                                dossier.Locked = false;
                                dossier.Archived = false;
                                dossier.DateArchivage = new DateTime();
                                dossier.Patient = personne;
                                dossier.Createur = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);

                                if (dossier.Patient != null && dossier.Createur != null)
                                {
                                    dossier.DossierID = dal.EnregistrerDossier(dossier);

                                    liaisonDossierGroupeC.Dossier = dossier;
                                    liaisonDossierGroupeC.GC = dal.ObtenirGroupeCibleParId(personnePatient.ProgrammeSOS); 

                                    dal.EnregistrerLiaisonDossierGroupeCible(liaisonDossierGroupeC);

                                    return RedirectToAction("CONSULTERDOSSIER", new { id = CRYPTAGE.StringHelpers.Decrypt(dossier.DossierID) });
                                }
                        }
                            else
                            {

                                DOSSIER tempdossier = dal.ObtenirDossierParId(personnePatient.Id);
                                if (tempdossier != null)
                                {
                                    personne.PersonneID = tempdossier.Patient.PersonneID;
                                    personne.Nom = personnePatient.Nom;
                                    personne.Prenom = personnePatient.Prenom;
                                    personne.TelephonePrincipal = personnePatient.TelephonePrincipal;
                                    personne.TelephoneSecondaire = personnePatient.TelephoneSecondaire;
                                    personne.Adresse = personnePatient.Adresse;
                                    personne.Email = personnePatient.Email;
                                    personne.Sexe = personnePatient.Sexe;
                                    personne.DateNaissance = tempdossier.Patient.DateNaissance;

                                    dal.EnregistrerPersonne(personne);
                                    tempdossier.PenseBete = personnePatient.PenseBete;
                                    dal.ModifierDossier(tempdossier, HttpContext.User.Identity.Name);

                                    return RedirectToAction("CONSULTERDOSSIER", new { id = CRYPTAGE.StringHelpers.Decrypt(tempdossier.DossierID) });
                                }
                            }
                        

                    }

                    return View("FormulaireAjoutDossier", personnePatient);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }


        }




        //Cette action se charge des opérations de recherche et d'affichage d'un traitement spécifique (id==TraitementID).
        //En cas d'informations disponibles, elle présente la vue typée TraitementVM2 servant à afficher
        // les résultats de la recherche nécessaires

        [HttpGet]
        public ActionResult CONSULTERTRAITEMENT(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_TRAITEMENT"))
                {
                    /* Code v1 - 31 Décembre 2017 - @Hn*/

                    TraitementVM3 infosTraitement = new TraitementVM3();
                    infosTraitement = dal.ConvertirTraitementTraitementVM3(dal.ObtenirTraitementParId(CRYPTAGE.StringHelpers.Encrypt(id)));
                    
                    return View("ConsulterTraitement", infosTraitement);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }




        //Cette action se charge des opérations de prise de paramètre d'un patient (id == DossierID). En mode HTTPGET,
        //elle se charge juste de présenter la vue typée ParametreVM (formulaire) servant à saisir les infos 

        [HttpGet]
        public ActionResult AJOUTPARAMETRE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_PARAMETRE"))
                {
                    /* Code v1 - 31 Décembre 2017 - @Hn*/
                    /* Ajout de ViewBag.DossierId - @Hn */

                    ParametreVM parametrePatient = new ParametreVM();
                    
                        DOSSIER tempDossier = dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(id));
                        if (tempDossier != null && !tempDossier.Archived)
                        {
                            parametrePatient.DossierID = tempDossier.DossierID;
                            ViewBag.DossierId = tempDossier.DossierID;
                            ViewBag.ListeSpecialiste = new SelectList(dal.ObtenirTousLesSpecialistes(), "Id", "NomSpecialiste");

                            return View("FormulairePriseParametre", parametrePatient);
                        }
                        else
                        {
                            ViewBag.ErrorMessage = dal.getErrorMessageArchivedFolder();
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



        //Cette action se charge des opérations de prise de paramètre d'un patient (id == DossierID). En mode HTTPPOST,
        //elle se charge d'enregistrer les paramètres et l'attente et ensuite rediriger vers ConsulterDossier

        [HttpPost]
        public ActionResult AJOUTPARAMETRE(ParametreVM parametrePatient)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_PARAMETRE"))
                {
                    /* Code v1 - 31 Décembre 2017 - @Hn*/
                    if (ModelState.IsValid)
                    {
                        PARAMETRE tempParametre = new PARAMETRE();
                        tempParametre.Dossier = dal.ObtenirDossierParId(parametrePatient.DossierID);
                        if (tempParametre.Dossier != null && !tempParametre.Dossier.Archived)
                        {

                            tempParametre.Avis = parametrePatient.Avis;
                            tempParametre.Poids = parametrePatient.Poids;
                            tempParametre.Pouls = parametrePatient.Pouls;
                            tempParametre.Temperature = parametrePatient.Temperature;
                            tempParametre.Tension = parametrePatient.Tension;
                            tempParametre.DatePrise = DateTime.Now;


                            dal.EnregistrerParametre(tempParametre);

                            ATTENTE tempAttente = new ATTENTE();
                            tempAttente.Patient = dal.ObtenirDossierParId(parametrePatient.DossierID);
                            tempAttente.Specialiste = dal.ObtenirUtilisateurParId(parametrePatient.SpecialisteID);
                            tempAttente.Etat = true;
                            tempAttente.Statut = true;
                            tempParametre.DatePrise = DateTime.Now;
                            tempAttente.DateAttente = tempParametre.DatePrise;


                            if (tempAttente.Patient != null && tempAttente.Specialiste != null) dal.EnregistrerAttente(tempAttente);

                            return RedirectToAction("CONSULTERDOSSIER", new { id = CRYPTAGE.StringHelpers.Decrypt(parametrePatient.DossierID) });
                        }
                        else
                        {
                            ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                            return View("Error");
                        }
                        
                    }

                    return View("FormulairePriseParametre", parametrePatient);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
            
        }


        //Cette action se charge des opérations de consultation d'un diagnostic d'un patient (id == DiagnosticID).
        //Ici elle est liée à la vue typée DiagnosticVM2


        public ActionResult CONSULTERDIAGNOSTIC(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_DIAGNOSTIC"))
                {
                    DiagnosticVM2 diagnosticPatient = new DiagnosticVM2();
                    
                        diagnosticPatient = dal.ConvertirDiagnosticDiagnosticVM2(dal.ObtenirDiagnosticParId(CRYPTAGE.StringHelpers.Encrypt(id)));
                    
                    return View("ConsulterDiagnostic", diagnosticPatient);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }



        //Cette action se charge des opérations d'ajout de diagnostic d'un patient. En mode HTTPPOST,
        //elle se charge d'enregistrer le diagnostic et ensuite rediriger vers ConsulterDiagnostic


        [HttpPost]
        public ActionResult AJOUTDIAGNOSTIC(DiagnosticVM diagnosticPatient)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUT_DIAGNOSTIC"))
                {
                    if (ModelState.IsValid)
                    {
                        DIAGNOSTIC tempDiagnostic = new DIAGNOSTIC();
                        tempDiagnostic.Auteur = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);
                        tempDiagnostic.Dossier = dal.ObtenirDossierParId(diagnosticPatient.DossierId);

                        if (tempDiagnostic.Dossier != null && tempDiagnostic.Auteur != null && !tempDiagnostic.Dossier.Archived)
                        {
                            tempDiagnostic.Avis = diagnosticPatient.Avis;
                            tempDiagnostic.DateDiagnostic = DateTime.Now;
                            tempDiagnostic.Maladie = dal.ObtenirMaladieParId(diagnosticPatient.MaladieId);
                            tempDiagnostic.DiagnosticId = dal.EnregistrerDiagnostic(tempDiagnostic);

                            return RedirectToAction("CONSULTERDIAGNOSTIC", new { id = CRYPTAGE.StringHelpers.Decrypt(tempDiagnostic.DiagnosticId) });
                        }
                        else
                        {
                            ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                            return View("Error");
                        }
                    }

                    return View("FormulaireAjoutDiagnostic", diagnosticPatient);

                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }


        //Cette action se charge des opérations d'ajout de diagnostic d'un patient (id == DossierId). En mode HTTPGet,
        //elle se charge d'afficher la vue d'enregistrement de nouveau diagnostic; vue typée DiagnosticVM

        /* Ajout de ViewBag.DossierId - @Hn */


        [HttpGet]
        public ActionResult AJOUTDIAGNOSTIC(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUT_DIAGNOSTIC"))
                {
                    DiagnosticVM diagnosticPatient = new DiagnosticVM();
                    diagnosticPatient.DossierId = id;
                    DOSSIER tempD = dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (tempD != null && !tempD.Archived)
                    {
                        ViewBag.NomPatient = CRYPTAGE.StringHelpers.Decrypt(tempD.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(tempD.Patient.Prenom);

                        List<MALADIE> listeMaladie = dal.ObtenirToutesLesMaladies();
                        if (listeMaladie != null)
                            foreach (var m in listeMaladie)
                            {
                                m.Intitule = CRYPTAGE.StringHelpers.Decrypt(m.Intitule);
                            }
                        ViewBag.ListeMaladie = listeMaladie;
                        ViewBag.DossierId = CRYPTAGE.StringHelpers.Encrypt(id);
                        return View("FormulaireAjoutDiagnostic", diagnosticPatient);
                    }
                    else
                    {
                        ViewBag.ErrorMessage = dal.getErrorMessageArchivedFolder();
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



        //Cette action se charge des opérations d'ajout de traitement à un diagnostic d'un patient (id == DiagnosticId).
        //En mode HTTPGet, elle se charge d'afficher la vue (formulaire) d'enregistrement de nouveau traitement.
        // Vue fortement typée TraitementVM2


        [HttpGet]
        public ActionResult AJOUTTRAITEMENT(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_TRAITEMENT"))
                {
                    TraitementVM2 traitementDiagnostic = new TraitementVM2();
                    traitementDiagnostic.DiagnosticId = id;

                    DIAGNOSTIC diagnostic = dal.ObtenirDiagnosticParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    UTILISATEUR user = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);
                    if (diagnostic != null && user != null && !diagnostic.Dossier.Archived)
                    {
                        traitementDiagnostic.DossierID = diagnostic.Dossier.DossierID;
                        traitementDiagnostic.DiagnosticId = diagnostic.DiagnosticId;
                        traitementDiagnostic.Diagnostic = CRYPTAGE.StringHelpers.Decrypt(diagnostic.Avis);
                        traitementDiagnostic.SpecialisteDiagnostic = CRYPTAGE.StringHelpers.Decrypt(diagnostic.Auteur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(diagnostic.Auteur.Personne.Prenom);
                        traitementDiagnostic.SpecialisteTraitement = CRYPTAGE.StringHelpers.Decrypt(user.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(user.Personne.Prenom);
                        ViewBag.DiagnosticId = id;

                        return View("FormulaireAjoutTraitement", traitementDiagnostic);
                    }
                    else
                    {
                        ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
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


        //Cette action se charge des opérations d'ajout de traitement à un diagnostic d'un patient.
        //Elle est appellée à la suite de la soumission du formulaire.
        //En mode HTTPPost, elle se charge d'enregistrer le nouveau traitement et de rediriger vers ConsulterTraitement,
        //en forunissant l'ID du nouveau traitement en paramètre.
        //


        [HttpPost]
        public ActionResult AJOUTTRAITEMENT(TraitementVM2 traitementDiagnostic)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_TRAITEMENT"))
                {
                    //TRAITEMENT nouveauTraitement = new TRAITEMENT();

                    if (ModelState.IsValid)
                    {
                        
                            TRAITEMENT tempTraitement = new TRAITEMENT();                        
                            tempTraitement.Diagnostic = dal.ObtenirDiagnosticParId(traitementDiagnostic.DiagnosticId);                           
                            tempTraitement.Specialiste = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);

                            if (tempTraitement.Diagnostic != null && tempTraitement.Specialiste != null && tempTraitement.Diagnostic.Dossier != null && !tempTraitement.Diagnostic.Dossier.Archived)
                            {
                                tempTraitement.DateTraitement = DateTime.Now;
                                tempTraitement.Recommandation = traitementDiagnostic.Traitement;
                                tempTraitement.TraitementID = dal.EnregistrerTraitement(tempTraitement);
                                return RedirectToAction("CONSULTERTRAITEMENT", new { id = CRYPTAGE.StringHelpers.Decrypt(tempTraitement.TraitementID) });
                            }
                            else
                            {
                                ViewBag.ErrorMessage = dal.getErrorMessageArchivedFolder();
                                return View("Error");
                            }
                                                    
                    }
                    ViewBag.DiagnosticId = traitementDiagnostic.DiagnosticId;
                    return View("FormulaireAjoutTraitement", traitementDiagnostic);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }



        //Cette action se charge de sélectionner le diagnostic auquel attribuer un nouveau traitement 
        //(id == DossierId).
        //En mode HTTPGet, elle se charge d'afficher la vue qui liste tous les diagnostics d'un dossier patient.
        // Vue fortement typée List<DiagnosticVM> avec bouton radio


        [HttpGet]
        public ActionResult NOUVEAUTRAITEMENT(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_TRAITEMENT"))
                {
                    List<DiagnosticVM> listeDiagnostic = new List<DiagnosticVM>();
                    DOSSIER dossier = dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (dossier != null && !dossier.Archived)
                    {
                        List<DIAGNOSTIC> tempListeDiagnostic = dal.RecupererTousLesDiagnosticDossier(dossier);

                        if (tempListeDiagnostic != null)
                            foreach (var d in tempListeDiagnostic)
                            {
                                listeDiagnostic.Add(dal.ConvertirDiagnosticDiagnosticVM(d));
                            }


                        return View("ConsulterListeDiagnostic", listeDiagnostic);
                    }
                    else
                    {
                        ViewBag.ErrorMessage = dal.getErrorMessageArchivedFolder();
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
        public ActionResult NOUVELEXAMEN(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_TRAITEMENT"))
                {
                    List<DiagnosticVM> listeDiagnostic = new List<DiagnosticVM>();
                    DOSSIER dossier = dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (dossier != null && !dossier.Archived)
                    {
                        List<DIAGNOSTIC> tempListeDiagnostic = dal.RecupererTousLesDiagnosticDossier(dossier);

                        if (tempListeDiagnostic != null)
                            foreach (var d in tempListeDiagnostic)
                            {
                                listeDiagnostic.Add(dal.ConvertirDiagnosticDiagnosticVM(d));
                            }


                        return View("ConsulterListeExamen", listeDiagnostic);
                    }
                    else
                    {
                        ViewBag.ErrorMessage = dal.getErrorMessageArchivedFolder();
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




        //Cette action se charge des opérations d'ajout de traitement à un diagnostic d'un patient.
        //Elle est appellée à la suite de la soumission du formulaire.
        //En mode HTTPPost, elle se charge d'enregistrer le nouveau traitement et de rediriger vers ConsulterTraitement,
        //en forunissant l'ID du nouveau traitement en paramètre.
        //



        [HttpGet]
        public ActionResult TRANSFERERATTENTE(String id)
        {

            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "TRANSFERER_ATTENTE"))
                {
                    ATTENTE temp_attente = dal.ObtenirAttenteParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (temp_attente != null && temp_attente.Etat == true)
                    {
                        AttenteVM3 temp_attenteVM3 = dal.ConvertirAttenteAttenteVM3(temp_attente);
                        ViewBag.ListeSpecialiste = new SelectList(dal.ObtenirTousLesSpecialistes(), "Id", "NomSpecialiste");

                        return View("FormulaireTransfertAttente", temp_attenteVM3);

                    }

                    return View("Error");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

            

        }


        [HttpPost]
        public ActionResult TRANSFERERATTENTE(AttenteVM3 attenteVM3)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "TRANSFERER_ATTENTE"))
                {

                    if (ModelState.IsValid)
                    {


                        dal.ModifierAttente(attenteVM3.AttenteId, attenteVM3.NouveauSpecialisteID);
                        MODIFICATIONATTENTE modifattente = new MODIFICATIONATTENTE();
                        modifattente.Attente = dal.ObtenirAttenteParId(attenteVM3.AttenteId);
                        modifattente.AncienSpecialiste = dal.ObtenirUtilisateurParId(attenteVM3.AncienSpecialisteID);
                        modifattente.NouveauSpecialiste = dal.ObtenirUtilisateurParId(attenteVM3.NouveauSpecialisteID);
                        modifattente.Motif = attenteVM3.Motif;
                        modifattente.DateModification = DateTime.Now;
                        dal.EnregistrerModificationAttente(modifattente);

                        return RedirectToAction("CONSULTERSALLEATTENTE");

                    }
                    return View("FormulaireTransfertAttente", attenteVM3);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpGet]
        public ActionResult CONSULTERSALLEATTENTE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_SALLEATTENTE"))
                {

                    List<ATTENTE> tempListeAttente = dal.ObtenirListeAttente(DateTime.Now);
                    List<AttenteVM2> tempListeAttenteVM2 = null;
                    if (tempListeAttente != null)
                    {
                        tempListeAttenteVM2 = new List<AttenteVM2>();
                        foreach (var a in tempListeAttente)
                        {
                            tempListeAttenteVM2.Add(dal.ConvertirAttenteAttenteVM2(a));
                        }
                    }
                    //ViewBag.ListeSpecialiste = new SelectList(dal.ObtenirTousLesSpecialistes(), "Id", "NomSpecialiste");
                    ViewBag.ListeSpecialiste = dal.ObtenirTousLesSpecialistes();
                    ViewBag.CurrentUser = HttpContext.User.Identity.Name;
                    return View("ConsulterSalleAttente", tempListeAttenteVM2);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }


        [HttpPost]
        public ActionResult CONSULTERSALLEATTENTE(DateTime? date, String specialiste, int etat)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_SALLEATTENTE"))
                {
                    List<ATTENTE> tempListeAttente = null;
                    if (date.HasValue)
                        tempListeAttente = dal.ObtenirListeAttente((DateTime)date, specialiste, etat);
                    else tempListeAttente = dal.ObtenirListeAttente(DateTime.Now, specialiste, etat);
                    List<AttenteVM2> tempListeAttenteVM2 = null;
                    if (tempListeAttente != null)
                    {
                        tempListeAttenteVM2 = new List<AttenteVM2>();
                        foreach (var a in tempListeAttente)
                        {
                            tempListeAttenteVM2.Add(dal.ConvertirAttenteAttenteVM2(a));
                        }
                    }
                    ViewBag.ListeSpecialiste = dal.ObtenirTousLesSpecialistes();
                    ViewBag.CurrentUser = HttpContext.User.Identity.Name;

                    return View("PartialViewSalleAttente", tempListeAttenteVM2);

                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }


        [HttpGet]
        public ActionResult DESACTIVERATTENTE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "DESACTIVER_ATTENTE"))
                {
                    ATTENTE attente = dal.ObtenirAttenteParId(id);

                    if (attente != null)
                    {
                        dal.DesactiverAttente(attente.AttenteID);
                    }
                    return RedirectToAction("CONSULTERSALLEATTENTE");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
            
        }


        [HttpGet]
        public ActionResult PRENDREENCHARGE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "PRENDRE_EN_CHARGE"))
                {
                    ATTENTE attente = dal.ObtenirAttenteParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    UTILISATEUR utilisateur = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name); //Int32.Parse((HttpContext.User.Identity.Name))
                    if (attente.Specialiste == utilisateur)
                    {
                        dal.PrendreEnCharge(attente.AttenteID);
                        return RedirectToAction("CONSULTERDOSSIER", new { id = CRYPTAGE.StringHelpers.Decrypt(attente.Patient.DossierID) });
                    }

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
        public ActionResult CONSULTERLISTERDV(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_RDV"))
                {
                    List<RENDEZVOUS> tempListeRdv = dal.ObtenirTousLesRdvDossier(CRYPTAGE.StringHelpers.Encrypt(id));
                    List<RendezVousVM> tempListeRdvVM = null;

                    if (tempListeRdv != null)
                    {
                        tempListeRdvVM = new List<RendezVousVM>();
                        foreach (var r in tempListeRdv)
                        {
                            tempListeRdvVM.Add(dal.ConvertirRendezVousRendezVousVM(r));
                        }
                    }

                    ViewBag.DossierId = id;
                    return View("ConsulterListeRdvPatient", tempListeRdvVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }


        [HttpGet]
        public ActionResult AJOUTERRDV(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_RENDEZVOUS"))
                {
                    DOSSIER tempdossier = dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(id));

                    if (tempdossier != null)
                    {
                        RendezVousVM2 tempRDVVM = new RendezVousVM2();
                        tempRDVVM.DossierId = tempdossier.DossierID;
                        tempRDVVM.nomPatient = CRYPTAGE.StringHelpers.Decrypt(tempdossier.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(tempdossier.Patient.Prenom);
                        tempRDVVM.verified = false;
                        ViewBag.ListeSpecialiste = new SelectList(dal.ObtenirTousLesSpecialistes(), "Id", "NomSpecialiste");
                        return View("FormulaireAjoutRdv", tempRDVVM);
                    }

                    return View("Error");

                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }


        [HttpPost]
        public ActionResult AJOUTERRDV(RendezVousVM2 rendezvousVM2)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_RENDEZVOUS"))
                {
                    if (ModelState.IsValid)
                    {
                        
                            rendezvousVM2.Horaire = dal.ConstruireDate(rendezvousVM2.dateRDV, rendezvousVM2.heureRDV, rendezvousVM2.minuteRDV);

                            if (dal.VerifierDisponibilite(rendezvousVM2.SpecialisteID, rendezvousVM2.DossierId, rendezvousVM2.Horaire))
                            {
                                dal.EnregistrerRendezVous(dal.ConvertirRendezVousVM2RendezVous(rendezvousVM2));
                                return RedirectToAction("CONSULTERLISTERDV", new { id = CRYPTAGE.StringHelpers.Decrypt(rendezvousVM2.DossierId) });
                            }
                            else
                            {
                                RendezVousVM4 temprdvVM4 = new RendezVousVM4();
                                temprdvVM4 = dal.ConvertirRendezVousVM2RendezVousVM4(rendezvousVM2);
                                ViewBag.ListeSpecialiste = new SelectList(dal.ObtenirTousLesSpecialistes(), "Id", "NomSpecialiste");

                                return View("FormulaireAjoutRdv", temprdvVM4);

                            }
                                                    
                    }

                    return View("FormulaireAjoutRdv", rendezvousVM2);

                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }


        [HttpPost]
        public ActionResult CONFIRMERAJOUTRDV(RendezVousVM4 rendezvousVM4)
        {
            if (ModelState.IsValid)
            {
                using (IDAL dal = new Dal())
                {
                    DOSSIER tempdossier = dal.ObtenirDossierParId(rendezvousVM4.DossierId);
                    UTILISATEUR tempUser = dal.ObtenirUtilisateurParId(rendezvousVM4.SpecialisteID);

                    if (tempdossier != null && tempUser != null)
                    {
                        RENDEZVOUS temprdv = new RENDEZVOUS();
                        temprdv.Actif = true;
                        temprdv.Horaire = rendezvousVM4.Horaire;
                        temprdv.Commentaire = rendezvousVM4.ObjetRDV;
                        temprdv.Emetteur = tempUser;
                        temprdv.Recepteur = tempdossier;
                        temprdv.Recu = false;

                        dal.EnregistrerRendezVous(temprdv);
                        return RedirectToAction("CONSULTERLISTERDV", new { id = CRYPTAGE.StringHelpers.Decrypt(tempdossier.DossierID) });
                    }

                    return View("Error");

                }
            }

            return View("AjouterRdv2", rendezvousVM4);

        }


        [HttpGet]
        public ActionResult ENVOYERENSALLEATTENTE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENVOYER_EN_SALLE_ATTENTE"))
                {
                    RENDEZVOUS temprdv = dal.ObtenirRendezVousParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (temprdv != null && temprdv.Recu == false && temprdv.Actif == true && temprdv.Recepteur != null && temprdv.Emetteur != null)
                    {
                        ATTENTE tempattente = new ATTENTE();
                        tempattente.DateAttente = DateTime.Now;
                        tempattente.Etat = true;
                        tempattente.Patient = temprdv.Recepteur;
                        tempattente.Specialiste = temprdv.Emetteur;
                        tempattente.Statut = true;

                        dal.EnregistrerAttente(tempattente);

                        temprdv.Recu = true;
                        dal.ModifierRendezVous(temprdv);

                        return RedirectToAction("CONSULTERSALLEATTENTE");
                    }

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
        public ActionResult ANNULERRDV(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ANNULER_RENDEZVOUS"))
                {
                    RENDEZVOUS temprdv = dal.ObtenirRendezVousParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (temprdv != null && temprdv.Recu == false && temprdv.Actif == true && temprdv.Recepteur != null && temprdv.Emetteur != null)
                    {

                        temprdv.Actif = false;
                        temprdv.Recu = false;
                        temprdv.Manque = false;
                        dal.ModifierRendezVous(temprdv);

                        return RedirectToAction("CONSULTERLISTERDV", new { id = CRYPTAGE.StringHelpers.Decrypt(temprdv.Recepteur.DossierID) });
                    }
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
        public ActionResult REPROGRAMMERRDV(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "REPROGRAMMER_RENDEZVOUS"))
                {
                    RENDEZVOUS temprdv = dal.ObtenirRendezVousParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (temprdv != null && temprdv.Recu == false && temprdv.Recepteur != null && temprdv.Emetteur != null)
                    {
                        RendezVousVM3 temp_rdvVM3 = dal.ConvertirRendezVousRendezVousVM3(temprdv);
                        return View("FormulaireReprogrammerRdv", temp_rdvVM3);
                    }
                    return View("Error");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

            

        }


        [HttpPost]
        public ActionResult REPROGRAMMERRDV(RendezVousVM3 temp_rdvVM3)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "REPROGRAMMER_RENDEZVOUS"))
                {
                    if (ModelState.IsValid)
                    {

                        RENDEZVOUS temprdv = dal.ObtenirRendezVousParId(temp_rdvVM3.rdvId);
                        if (temprdv != null && temprdv.Recu == false && temprdv.Recepteur != null && temprdv.Emetteur != null)
                        {
                            temprdv.Horaire = dal.ConstruireDate(temp_rdvVM3.NouvelleHoraire, temp_rdvVM3.NouvelleHeure, temp_rdvVM3.NouvelleMinute);
                            dal.ModifierRendezVous(temprdv);
                            return RedirectToAction("CONSULTERLISTERDV", new { id = CRYPTAGE.StringHelpers.Decrypt(temprdv.Recepteur.DossierID) });
                        }
                    }

                    return View("Error");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }
        /*
         * 10 Jan 2018 - @Hn
         * 
         */


        public ActionResult CONSULTERREGISTREMEDICAL(String id, int? position, Boolean? sens)
        {
            //id pour l'id du dernier élement recupéré (id already crypted)
            //position pour connaitre la page à laquelle on se trouve (page 1, 2, ...)
            //sens pour connaitre le sens de l'affichage avant | arrière

            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_REGISTRE_MEDICAL"))
                {
                    List<DOSSIER> tempListeDossier = null;
                    List<SearchDossier> tempListeSearchDossier = null;
                    int taille = dal.getLongeur();
                    String DernierIdDB = dal.ObtenirIdDernierDossier();
                    String PremierIdDB = dal.ObtenirIdPremierDossier();
                    Boolean verifierPresenceLastElement = false;
                    Boolean verifierPresenceFirstElement = false;


                    //Permet d'avoir le nombre de dossiers en BD
                    ViewBag.NombreDossierDB = dal.ObtenirNombreDossier();

                    if (!String.IsNullOrEmpty(id))
                    {
                        if (position.HasValue)
                        {
                            ViewBag.Position = (int)position + 1;

                            if (sens.HasValue)
                            {
                                if ((Boolean)sens) ViewBag.Position = (int)position + 1; else ViewBag.Position = (int)position - 1;
                                tempListeDossier = dal.ObtenirLeRegistreMedical(id, (Boolean)sens, false);
                            }
                            else

                                tempListeDossier = dal.ObtenirLeRegistreMedical(id, true, false);
                        }
                        else
                        {
                            ViewBag.Position = 1;

                            if (sens.HasValue)
                                tempListeDossier = dal.ObtenirLeRegistreMedical(id, (Boolean)sens, false);
                            else
                                tempListeDossier = dal.ObtenirLeRegistreMedical(id, true, false);

                        }

                        //Ici on a la liste
                        if (tempListeDossier != null && tempListeDossier.Count != 0)
                        {
                            tempListeSearchDossier = new List<SearchDossier>();

                            foreach (var d in tempListeDossier)
                            {
                                if (d != null)
                                {
                                    tempListeSearchDossier.Add(dal.ConvertirDossierSearchDossier(d));
                                    ViewBag.LastId = d.DossierID;
                                    if (verifierPresenceLastElement == false)
                                        if (DernierIdDB == d.DossierID) verifierPresenceLastElement = true;
                                    if (verifierPresenceFirstElement == false)
                                        if (PremierIdDB == d.DossierID) verifierPresenceFirstElement = true;
                                }
                            }

                        }

                        //Au cas où rien à afficher
                        if (tempListeSearchDossier == null || tempListeSearchDossier.Count == 0)
                        {
                            ViewBag.PlageAffichee = "0-0";
                            verifierPresenceFirstElement = true;
                            verifierPresenceLastElement = true;
                        }
                        else
                        {
                            tempListeSearchDossier = tempListeSearchDossier.OrderByDescending(d => d.LastDateVisit).ToList();
                            if (sens == true)
                            {

                                ViewBag.PlageAffichee = (taille * (position) + 1) + "-" + ((taille * (position)) + tempListeSearchDossier.Count);
                                ViewBag.DernierIdDB = DernierIdDB;
                                ViewBag.PremierIdDB = PremierIdDB;
                            }
                            else
                            {
                                ViewBag.PlageAffichee = ((taille * (position - 1)) - (tempListeSearchDossier.Count - 1)) + "-" + ((taille * (position)) - tempListeSearchDossier.Count);
                                ViewBag.DernierIdDB = DernierIdDB;
                                ViewBag.PremierIdDB = PremierIdDB;
                            }
                        }
                    }
                    else
                    {

                        tempListeDossier = dal.ObtenirLeRegistreMedical(null, true, false);
                        //Ici on a la liste
                        if (tempListeDossier != null && tempListeDossier.Count != 0)
                        {

                            tempListeSearchDossier = new List<SearchDossier>();

                            foreach (var d in tempListeDossier)
                            {
                                if (d != null)
                                {
                                    tempListeSearchDossier.Add(dal.ConvertirDossierSearchDossier(d));
                                    ViewBag.LastId = d.DossierID;
                                    if (verifierPresenceLastElement == false)
                                        if (DernierIdDB == d.DossierID) verifierPresenceLastElement = true;
                                    if (verifierPresenceFirstElement == false)
                                        if (PremierIdDB == d.DossierID) verifierPresenceFirstElement = true;
                                }
                            }

                        }

                        ViewBag.Position = 1;
                        if (tempListeSearchDossier == null || tempListeSearchDossier.Count == 0)
                        {
                            ViewBag.PlageAffichee = "0-0";
                            verifierPresenceFirstElement = true;
                            verifierPresenceLastElement = true;


                        }
                        else
                        {

                            ViewBag.PlageAffichee = "1-" + tempListeSearchDossier.Count;
                            ViewBag.DernierIdDB = DernierIdDB;
                            ViewBag.PremierIdDB = PremierIdDB;
                            tempListeSearchDossier = tempListeSearchDossier.OrderByDescending(d => d.LastDateVisit).ToList();



                        }
                    }
                    if (verifierPresenceFirstElement) ViewBag.AfficheFin = false; else ViewBag.AfficheFin = true;
                    if (verifierPresenceLastElement) ViewBag.AfficheDebut = false; else ViewBag.AfficheDebut = true;
                    return View("ConsulterRegistreMedical", tempListeSearchDossier);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }



        }


        /*
         * 12 Jan 2018 - @Hn
         * 
         */

        //Doit prendre en compte l'utilisateur courant

        [HttpPost]
        public ActionResult ARCHIVERDOSSIER(String[] IdsDossiersAArchiver)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ARCHIVER_DOSSIER"))
                {
                    if (IdsDossiersAArchiver != null)
                    {
                        foreach (var idDossier in IdsDossiersAArchiver)
                        {
                            if (!String.IsNullOrEmpty(idDossier))
                                dal.ArchiverDossierParId(idDossier, HttpContext.User.Identity.Name);
                        }
                    }
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

            return RedirectToAction("ConsulterListeProduits");
        }


        /*
         * 18 Jan 2018 - @Hn
         * 
         */

        public ActionResult CONSULTERRENDEZVOUS(String idUtilisateur, DateTime? dateRdv, int? type)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_RENDEZVOUS"))
                {
                    List<RENDEZVOUS> tempListeRdv = null;
                    List<RendezVousVM> tempListeRdvVM = null;

                    tempListeRdv = dal.ObtenirTousLesRdv(idUtilisateur, type, dateRdv);


                    if (tempListeRdv != null)
                    {
                        tempListeRdvVM = new List<RendezVousVM>();
                        foreach (var r in tempListeRdv)
                        {
                            tempListeRdvVM.Add(dal.ConvertirRendezVousRendezVousVM(r));
                            tempListeRdvVM.OrderBy(tr => tr.Horaire);
                        }

                    }

                    //Permet d'avoir l'utilisateur courant connecté
                    ViewBag.IdUser = HttpContext.User.Identity.Name;
                    return View("ConsulterListeRdv", tempListeRdvVM);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        /*
         * 19 Jan 2018 - @Hn
         * 
         */

        [HttpGet]
        public ActionResult CONSULTERPARAMETRE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_RENDEZVOUS"))
                {
                    PARAMETRE temP = dal.ObtenirParametreParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (temP != null)
                    {
                        ParametreVM2 PVM = dal.ConvertirParametreParametreVM2(temP);
                        
                        return View("ConsulterParametre", PVM);

                    }
                        return View("Error");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

            
        }


        /*
        * 23 Avril 2018 - @Hn
        * 
        */

        public ActionResult ImprimerCarnetMedical(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "IMPRIMER_DOSSIER_PATIENT"))
                {
                    DossierVM dossierPatient = dal.ConvertirDossierDossierVM(dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(id)), false);
                    if (dossierPatient != null)
                    {
                        ViewBag.DateNaissance = dal.FormateAge(dossierPatient.Dossier.Patient.DateNaissance);
                        return View("ImpressionDossierPatient", dossierPatient);
                    }
                    return View("Error");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        public ActionResult IMPRIMERDOSSIERMEDICAL(String id)
        {
            string footer = "--footer-left \"Impulsado por SECEL para CENTRO DE SALUD SOS\" " + "--footer-right \"Date: [date] [time]\" " + "--footer-center \"Page: [page] of [toPage]\" --footer-line --footer-font-size \"9\" --footer-spacing 5 --footer-font-name \"calibri light\"";
            return new ActionAsPdf("ImprimerCarnetMedical", new { id = id })
            {
                MinimumFontSize = 12,
                PageOrientation = Rotativa.Options.Orientation.Landscape,
                CustomSwitches = footer
            };
        }

        public ActionResult ImprimerFicheDiagnostic(String id)
        {
            DiagnosticVM2 diagnosticPatient = new DiagnosticVM2();
            using (IDAL dal = new Dal())
            {
                diagnosticPatient = dal.ConvertirDiagnosticDiagnosticVM2(dal.ObtenirDiagnosticParId(CRYPTAGE.StringHelpers.Encrypt(id)));
            }

            return View("ImpressionDiagnostic", diagnosticPatient);
        }

        public ActionResult IMPRIMERDIAGNOSTIC(String id)
        {
            string footer = "--footer-left \"Impulsado por SECEL para CENTRO DE SALUD SOS\" " + "--footer-right \"Date: [date] [time]\" " + "--footer-center \"Page: [page] of [toPage]\" --footer-line --footer-font-size \"9\" --footer-spacing 5 --footer-font-name \"calibri light\"";
            return new ActionAsPdf("ImprimerFicheDiagnostic", new { id = id })
            {
                MinimumFontSize = 12,
                PageOrientation = Rotativa.Options.Orientation.Portrait,
                CustomSwitches = footer
            };
        }

        public ActionResult ImprimerFicheSoin(String id)
        {
            TraitementVM3 infosTraitement = new TraitementVM3();
            using (IDAL dal = new Dal())
            {
                infosTraitement = dal.ConvertirTraitementTraitementVM3(dal.ObtenirTraitementParId(CRYPTAGE.StringHelpers.Encrypt(id)));
            }

            return View("ImpressionTraitement", infosTraitement);
        }

        public ActionResult IMPRIMERTRAITEMENT(String id)
        {
            string footer = "--footer-left \"Impulsado por SECEL para CENTRO DE SALUD SOS\" " + "--footer-right \"Date: [date] [time]\" " + "--footer-center \"Page: [page] of [toPage]\" --footer-line --footer-font-size \"9\" --footer-spacing 5 --footer-font-name \"calibri light\"";
            return new ActionAsPdf("ImprimerFicheSoin", new { id = id })
            {
                MinimumFontSize = 12,
                PageOrientation = Rotativa.Options.Orientation.Portrait,
                CustomSwitches = footer
            };
        }



        /*
        * 14 Aout 2018 - @Hn
        * 
        */

        public ActionResult VISUALISERPARAMETRE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_GRAPHIQUE_PARAMETRE"))
                {
                    List<PARAMETRE> listeParam = dal.RecupererTousLesParametresDossier(dal.ObtenirDossierParId(CRYPTAGE.StringHelpers.Encrypt(id)));
                    if (listeParam != null && listeParam.Count() > 0)
                    {
                        List<DataPoint> dataPoints1 = new List<DataPoint>();
                        List<DataPoint> dataPoints2 = new List<DataPoint>();
                        List<DataPoint> dataPoints3 = new List<DataPoint>();
                        
                        int i = 1;
                        foreach (var p in listeParam)
                        {
                            
                            dataPoints1.Add(new DataPoint("n°" + i, p.Poids));
                            dataPoints2.Add(new DataPoint("n°" + i, p.Temperature));
                            dataPoints3.Add(new DataPoint("n°" + i, p.Pouls));

                            i += 1;
                        }

                        ViewBag.DataPoints1 = JsonConvert.SerializeObject(dataPoints1);
                        ViewBag.DataPoints2 = JsonConvert.SerializeObject(dataPoints2);
                        ViewBag.DataPoints3 = JsonConvert.SerializeObject(dataPoints3);

                        ViewBag.DossierID = id;

                        return View("StatsParametres");
                    }
                    
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                return View("Error");
            }
        }

        /*
        * 29 Aout 2018 - @Hn
        * 
        */
        [HttpGet]
        public ActionResult CONSULTERARCHIVES(String id, int? position, Boolean? sens)
        {
            
            using (IDAL dal = new Dal())
               
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_ARCHIVES"))
                {
                    List<DOSSIER> tempListeDossier = null;
                    List<SearchDossier> tempListeSearchDossier = null;
                    int taille = dal.getLongeur();
                    String DernierIdDB = dal.ObtenirIdDernierDossierArchived();
                    String PremierIdDB = dal.ObtenirIdPremierDossierArchived();
                    Boolean verifierPresenceLastElement = false;
                    Boolean verifierPresenceFirstElement = false;

                    //Permet d'avoir le nombre de dossiers archivés en BD
                    ViewBag.NombreDossierDB = dal.ObtenirNombreDossierArchived();

                    if (!String.IsNullOrEmpty(id))
                    {
                        if (position.HasValue)
                        {
                            ViewBag.Position = (int)position + 1;

                            if (sens.HasValue)
                            {
                                if ((Boolean)sens) ViewBag.Position = (int)position + 1; else ViewBag.Position = (int)position - 1;
                                tempListeDossier = dal.ObtenirLeRegistreMedical(id, (Boolean)sens, true);
                            }
                            else

                                tempListeDossier = dal.ObtenirLeRegistreMedical(id, true, true);
                        }
                        else
                        {
                            ViewBag.Position = 1;

                            if (sens.HasValue)
                                tempListeDossier = dal.ObtenirLeRegistreMedical(id, (Boolean)sens, true);
                            else
                                tempListeDossier = dal.ObtenirLeRegistreMedical(id, true, true);

                        }

                        //Ici on a la liste
                        if (tempListeDossier != null && tempListeDossier.Count != 0)
                        {
                            tempListeSearchDossier = new List<SearchDossier>();

                            foreach (var d in tempListeDossier)
                            {
                                if (d != null)
                                {
                                    tempListeSearchDossier.Add(dal.ConvertirDossierSearchDossier(d));
                                    ViewBag.LastId = d.DossierID;
                                    if (verifierPresenceLastElement == false)
                                        if (DernierIdDB == d.DossierID) verifierPresenceLastElement = true;
                                    if (verifierPresenceFirstElement == false)
                                        if (PremierIdDB == d.DossierID) verifierPresenceFirstElement = true;
                                }
                            }

                        }

                        //Au cas où rien à afficher
                        if (tempListeSearchDossier == null || tempListeSearchDossier.Count == 0)
                        {
                            ViewBag.PlageAffichee = "0-0";
                            verifierPresenceFirstElement = true;
                            verifierPresenceLastElement = true;
                        }
                        else
                        {
                            tempListeSearchDossier = tempListeSearchDossier.OrderByDescending(d => d.LastDateVisit).ToList();
                            if (sens == true)
                            {

                                ViewBag.PlageAffichee = (taille * (position) + 1) + "-" + ((taille * (position)) + tempListeSearchDossier.Count);
                                ViewBag.DernierIdDB = DernierIdDB;
                                ViewBag.PremierIdDB = PremierIdDB;
                            }
                            else
                            {
                                ViewBag.PlageAffichee = ((taille * (position - 1)) - (tempListeSearchDossier.Count - 1)) + "-" + ((taille * (position)) - tempListeSearchDossier.Count);
                                ViewBag.DernierIdDB = DernierIdDB;
                                ViewBag.PremierIdDB = PremierIdDB;
                            }
                        }
                    }
                    else
                    {

                        tempListeDossier = dal.ObtenirLeRegistreMedical(null, true, true);
                        //Ici on a la liste
                        if (tempListeDossier != null && tempListeDossier.Count != 0)
                        {

                            tempListeSearchDossier = new List<SearchDossier>();

                            foreach (var d in tempListeDossier)
                            {
                                if (d != null)
                                {
                                    tempListeSearchDossier.Add(dal.ConvertirDossierSearchDossier(d));
                                    ViewBag.LastId = d.DossierID;
                                    if (verifierPresenceLastElement == false)
                                        if (DernierIdDB == d.DossierID) verifierPresenceLastElement = true;
                                    if (verifierPresenceFirstElement == false)
                                        if (PremierIdDB == d.DossierID) verifierPresenceFirstElement = true;
                                }
                            }

                        }

                        ViewBag.Position = 1;
                        if (tempListeSearchDossier == null || tempListeSearchDossier.Count == 0)
                        {
                            ViewBag.PlageAffichee = "0-0";
                            verifierPresenceFirstElement = true;
                            verifierPresenceLastElement = true;


                        }
                        else
                        {

                            ViewBag.PlageAffichee = "1-" + tempListeSearchDossier.Count;
                            ViewBag.DernierIdDB = DernierIdDB;
                            ViewBag.PremierIdDB = PremierIdDB;
                            tempListeSearchDossier = tempListeSearchDossier.OrderByDescending(d => d.LastDateVisit).ToList();



                        }
                    }
                    if (verifierPresenceFirstElement) ViewBag.AfficheFin = false; else ViewBag.AfficheFin = true;
                    if (verifierPresenceLastElement) ViewBag.AfficheDebut = false; else ViewBag.AfficheDebut = true;
                    return View("ConsulterArchiveMedical", tempListeSearchDossier);


                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
        }


    }

}


