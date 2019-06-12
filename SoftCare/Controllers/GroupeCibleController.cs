using SoftCare.Models;
using SoftCare.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SoftCare.Controllers
{
    [Authorize]
    public class GroupeCibleController : Controller
    {
        /*
         * 23 Jan 2018 - @Hn
         * 
         */

        //
        // GET: /GroupeCible/
        [HttpGet]
        public ActionResult CREERNOUVEAUGROUPE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CREER_GROUPECIBLE"))
                {
                    GroupeCibleVM gcvm = new GroupeCibleVM();
                    List<TYPEGROUPE> tempLG = dal.ObtenirTousLesTypesDeGC();
                    foreach (var tg in tempLG)
                    {
                        if (tg != null) tg.Objet = CRYPTAGE.StringHelpers.Decrypt(tg.Objet);
                    }
                    ViewBag.ListeDesTypesDeGC = tempLG;
                    List<UtilisateurVM2> listeUvm2 = new List<UtilisateurVM2>();
                    List<UTILISATEUR> listeUser = dal.ObtenirTousLesUtilisateurs();
                    if (listeUser != null)
                    {
                        foreach (var u in listeUser)
                        {
                            if (u != null)
                                listeUvm2.Add(dal.ConvertirUtilisateurUtilisateurVM2(u));
                        }
                    }
                    ViewBag.ListeDesAdministrateurs = listeUvm2;
                    return View("FormulaireCreationGroupeCible", gcvm);
                }

                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        /*
         * 24 Jan 2018 - @Hn
         * 
         */
        [HttpPost]
        public ActionResult CREERNOUVEAUGROUPE(GroupeCibleVM gcvm)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CREER_GROUPECIBLE"))
                {
                    if (ModelState.IsValid)
                    {

                        GROUPECIBLE gc = new GROUPECIBLE();
                        gc.Createur = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);

                        if (gc.Createur != null)
                        {
                            gc.Administrateur = dal.ObtenirUtilisateurParId(gcvm.Administrateur);
                            gc.Type = dal.ObtenirTypeGroupeParId(gcvm.Type);
                            gc.Intitule = gcvm.Intitule;
                            gc.Objet = gcvm.Objet;
                            gc.DateCreationGroupe = DateTime.Now;
                            gc.DateClotureGroupe = gcvm.DateClotureGroupe;
                            gc.DateArchivageGroupe = gcvm.DateClotureGroupe;
                            gc.Archived = false;
                            gc.Closed = false;

                            if (gc.Type != null && gc.Administrateur != null) gc.GroupeCibleID = dal.EnregistrerGroupeCible(gc);

                            return RedirectToAction("CONSULTERINFOSGROUPECIBLE", new { id = CRYPTAGE.StringHelpers.Decrypt(gc.GroupeCibleID) });

                        }

                        return RedirectToAction("SeConnecter", "CompteUtilisateur");

                    }

                    else
                    {
                        ViewBag.ListeDesTypesDeGC = dal.ObtenirTousLesTypesDeGC();
                        ViewBag.ListeDesUtilisateurs = dal.ObtenirTousLesUtilisateurs();
                        return View("FormulaireCreationGroupeCible", gcvm);

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
        public ActionResult CONSULTERINFOSGROUPECIBLE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_INFOS_GROUPECIBLE"))
                {
                    GROUPECIBLE groupeCible = dal.ObtenirGroupeCibleParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (groupeCible != null)
                    {
                        GroupeCibleVM2 groupeCibleVM2 = new GroupeCibleVM2();
                        groupeCibleVM2 = dal.ConvertirGroupeCibleGroupeCibleVM2(groupeCible);

                        UTILISATEUR user = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);

                        if (user != null)
                        {

                            ViewBag.AffichePlus = false;
                            if (user == groupeCible.Administrateur) //Ou Rôle administrateur
                            {
                                ViewBag.AffichePlus = true;
                                List<UtilisateurVM2> listeUvm2 = new List<UtilisateurVM2>();
                                List<UTILISATEUR> listeUser = dal.ObtenirTousLesUtilisateurs();
                                if (listeUser != null)
                                {
                                    foreach (var u in listeUser)
                                    {
                                        if (u != null)
                                            listeUvm2.Add(dal.ConvertirUtilisateurUtilisateurVM2(u));
                                    }
                                }
                                ViewBag.ListeDesAdministrateurs = listeUvm2;
                                List<TYPEGROUPE> tempLG = dal.ObtenirTousLesTypesDeGC();
                                foreach (var tg in tempLG)
                                {
                                    if (tg != null) tg.Objet = CRYPTAGE.StringHelpers.Decrypt(tg.Objet);
                                }
                                ViewBag.ListeDesTypesDeGC = tempLG;
                            }
                            List<LIAISONDOSSIERGROUPECIBLE> tempL = dal.ObtenirToutesLesLiaisonsDunGroupeParId(CRYPTAGE.StringHelpers.Encrypt(id), 1);
                            if (tempL != null)
                            {
                                groupeCibleVM2.Membres = new List<MembreGroupeCible>();
                                List<GROSSESSE> tempG = new List<GROSSESSE>();
                                foreach (var l in tempL)
                                {
                                    if (l != null)
                                    {
                                        tempG.AddRange(dal.ObtenirInfosGrossesseParLiaison(l.LiaisonDossierGroupeCibleID));
                                    }
                                }

                                foreach (var g in tempG)
                                {
                                    groupeCibleVM2.Membres.Add(dal.ConvertirGrossesseMembreGroupeCible(g));
                                }

                            }
                        }

                        return View("ConsulterInfoGroupeCible", groupeCibleVM2);
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
        public ActionResult CONSULTERINFOSGROUPECIBLE(GroupeCibleVM2 gcvm2)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_INFOS_GROUPECIBLE"))
                {
                    //if (ModelState.IsValid)
                    //{
                        UTILISATEUR currentUser = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);
                        if (currentUser.UtilisateurID == gcvm2.Admin.Id) //ou est un administrateur
                        {
                            GROUPECIBLE tempG = new GROUPECIBLE();
                            tempG.GroupeCibleID = gcvm2.Id;
                            tempG.Intitule = gcvm2.Intitule;
                            tempG.Objet = gcvm2.Objet;
                            tempG.DateClotureGroupe = gcvm2.DateClotureGroupe;
                            tempG.Administrateur = dal.ObtenirUtilisateurParId(gcvm2.Administrateur);
                            tempG.Type = dal.ObtenirTypeGroupeParId(gcvm2.type);
                            if (tempG.Administrateur != null && tempG.Type != null)
                                dal.ModifierGroupeCible(tempG);
                        }
                    //}
                    
                    return RedirectToAction("CONSULTERINFOSGROUPECIBLE", new { id = gcvm2.Id });

                }

                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

            
        }

        [HttpGet]
        public ActionResult AJOUTERMEMBRE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_MEMBRE_GROUPECIBLE"))
                {
                    if (!String.IsNullOrEmpty(id))
                    {

                        GROUPECIBLE groupe = dal.ObtenirGroupeCibleParId(CRYPTAGE.StringHelpers.Encrypt(id));
                        if (groupe != null)
                        {
                            //Verifions que l'user connecté est l'admin du groupe
                            if (dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name).UtilisateurID == groupe.Administrateur.UtilisateurID)
                            // Int32.Parse(HttpContext.User.Identity.Name)
                            {
                                //if (CRYPTAGE.StringHelpers.Decrypt(groupe.Type.Objet) == "Femmes Enceintes") //Charger les dossiers de femme
                                //{
                                    ViewBag.IdGroupe = groupe.GroupeCibleID;
                                    ViewBag.CodeGroupe = CRYPTAGE.StringHelpers.Decrypt(groupe.Code);
                                    List<SearchDossier> listDossier = dal.ObtenirListeDesPersonnesAdmissiblesAuGroupeFemmeEnceinte(groupe);
                                    //Dans cette vue faudra initialiser un objet "Container" de type AddMembreGroup. En effet, c'est cet ob-
                                    //jet qui sélectionne l'id du groupe et le tableau d'Ids de membres à ajouter
                                    return View("FormulaireAjoutMembreGroupeCible", listDossier);
                                //}
                            }
                            else
                            {
                                ViewBag.ErrorMessage = "Vous n'etes pas l'administrateur de ce Groupe. Donc vous ne pouvez pas y ajouter des Membres. ";
                                return View("Error");
                            }

                        }

                        ViewBag.ErrorMessage = "Choissez un Programme."; 
                        return View("Error");
                    }

                    else
                    {
                        return RedirectToAction("CONSULTERLISTEGROUPECIBLE");
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
        public ActionResult AJOUTERMEMBRE(AddMembreGroup Container)
        {
            if (ModelState.IsValid)
            {
                using (IDAL dal = new Dal())
                {
                    if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_MEMBRE_GROUPECIBLE"))
                    {
                        List<DOSSIER> listeDossier = new List<DOSSIER>();
                        GROUPECIBLE groupe = dal.ObtenirGroupeCibleParId(Container.IdGroupe);
                        if (groupe != null)
                        {
                            LIAISONDOSSIERGROUPECIBLE ldgc = new LIAISONDOSSIERGROUPECIBLE();
                            if (Container.IdsMembresAAjouter != null)
                                foreach (var m in Container.IdsMembresAAjouter)
                                {
                                    if (!String.IsNullOrEmpty(m))
                                    {
                                        DOSSIER d = dal.ObtenirDossierParId(m);
                                        if (d != null)
                                        {
                                            if (!dal.VerifierPresenceActiveDossierGroupe(d, groupe))
                                            {
                                                ldgc.Dossier = d;
                                                ldgc.GC = groupe;
                                                ldgc.DateIntegration = DateTime.Now;
                                                ldgc.Actif = true;
                                                dal.EnregistrerLiaisonDossierGroupeCible(ldgc);
                                            }
                                        }
                                    }
                                }

                            return RedirectToAction("CONSULTERINFOSGROUPECIBLE", new { id = CRYPTAGE.StringHelpers.Decrypt(groupe.GroupeCibleID) });
                        }

                    }

                    else
                    {
                        ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                        return View("Error");
                    }
                }

            }

            return View("Error");
        }

        [HttpGet]
        public ActionResult CONSULTERLISTEGROUPECIBLE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_GROUPECIBLE"))
                {
                    List<GroupeCibleVM3> liste = null;
                    int IsArchived = 0; // Programmes Non archivés
                    List<GROUPECIBLE> listeGC = dal.ObtenirTousLesGroupesCibles(IsArchived);
                    if (listeGC != null)
                    {
                        liste = new List<GroupeCibleVM3>();
                        foreach (var g in listeGC)
                        {
                            if (g != null)
                            {
                                liste.Add(dal.ConvertirGroupeCibleGroupeCibleVM3(g));
                            }
                        }
                    }

                    return View("ConsulterListeGroupeCible", liste);

                }

                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        /*
         * 25 Jan 2018 - @Hn
         * 
         */
        [HttpGet]
        public ActionResult CONFIGURERVISITEPRENATALE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONFIGURER_VISITE_PRENATALE"))
                {
                    ViewBag.AfficheBouton = false;
                    GROSSESSE grossesse = dal.ObtenirGrossesseParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (grossesse != null)
                    {
                        if (grossesse.Resultat == 0)
                        {
                            ViewBag.AfficheBouton = true;

                        }

                        ViewBag.NomPatient = CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Patient.Prenom);
                        ViewBag.GrossesseId = grossesse.GrossesseID;
                        ViewBag.Etatgrossesse = dal.GetEtatGrossesse(grossesse);
                        ViewBag.ListeSpecialiste = new SelectList(dal.ObtenirTousLesSpecialistes(), "Id", "NomSpecialiste");

                        List<SampleVisitePrenatale> listeSampleVisitePrenatale = null;
                        List<VISITEPRENATALE> listeVisitePrenatale = dal.ObtenirToutesLesVisitesPrenatalesGrossesse(grossesse);
                        if (listeVisitePrenatale != null)
                        {
                            listeSampleVisitePrenatale = new List<SampleVisitePrenatale>();
                            foreach (var v in listeVisitePrenatale)
                            {
                                if (v != null)
                                    listeSampleVisitePrenatale.Add(dal.ConvertirVisitePrenataleSampleVisitePrenatale(v));
                            }
                            listeSampleVisitePrenatale.OrderBy(v => v.Date);
                        }

                        return View("ConsulterVisitesPrenatales", listeSampleVisitePrenatale);

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
        public ActionResult CONFIGURERVISITEPRENATALE(AddVisit newVisit)
        {
            using (IDAL dal = new Dal())
                {
                    if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONFIGURER_VISITE_PRENATALE"))
                    {
                        if (ModelState.IsValid)
                        {

                            GROSSESSE tempG = dal.ObtenirGrossesseParId(newVisit.GrossesseID);
                            if (tempG != null)
                            {
                                VISITEPRENATALE tempV = new VISITEPRENATALE();
                                tempV.Grossesse = tempG;
                                tempV.Observation = "";
                                tempV.Rdv = new RENDEZVOUS();
                                tempV.Rdv.Horaire = newVisit.DateVisite;
                                tempV.Rdv.Actif = true;
                                tempV.Rdv.Commentaire = "Visite prénatale";
                                tempV.Rdv.Emetteur = dal.ObtenirUtilisateurParId(newVisit.SpecialisteID);
                                tempV.Rdv.Manque = false;
                                tempV.Rdv.Recepteur = tempG.Maternite.Dossier;
                                tempV.Rdv.Recu = false;

                                tempV.Rdv.RendezVousID = dal.EnregistrerRendezVous(tempV.Rdv);

                                tempV.Rdv = dal.ObtenirRendezVousParId(tempV.Rdv.RendezVousID);

                                tempV.VisitePrenataleID = dal.EnregistrerVisitePrenatale(tempV);

                                return RedirectToAction("CONFIGURERVISITEPRENATALE", new { id = CRYPTAGE.StringHelpers.Decrypt(tempV.VisitePrenataleID) });
                            }
                        }

                    }

                    else
                    {
                        ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                        return View("Error");
                    }
            }

            return View("Error");

        }


        /*
       * 29 Jan 2018 - @Hn
       * 
       */
        [HttpGet]
        public ActionResult CONSULTERGROSSESSE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_GROSSESSE"))
                {
                    GROSSESSE grossesse = dal.ObtenirGrossesseParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (grossesse != null)
                    {
                        if (grossesse.Resultat == 0)
                        {
                            ViewBag.Choix = true;
                            //Affichage vue enregistrement résultat grossesse
                            // 0 (par défaut) : grossesse en cours
                            // 1 : Grossesse à terme | Accouchement par césarienne
                            // 2 : Grossesse à terme | Accouchement normal
                            //-1 : Grossesse à terme | Enfant(s) décédé(s) à la naissance
                            //-2 : Fausse couche
                            //-3 : Grossesse à terme | Décès de la mère
                            //-4 : Grossesse à terme | Décès de la mère et de(s) l'enfant(s)

                            ViewBag.GrossesseID = grossesse.GrossesseID;
                            ViewBag.NomPatient = CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Patient.Prenom);
                            ViewBag.CodeDossier = CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Code);
                            ViewBag.UtilisateurID = HttpContext.User.Identity.Name;
                            ViewBag.ListeSpecialiste = dal.ObtenirTousLesSpecialistes();
                            return View("ConsulterSuiviGrossesse");


                        }
                        else
                        {
                            ViewBag.Choix = false;
                            ViewBag.GrossesseID = grossesse.GrossesseID;
                            ViewBag.NomPatient = CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Patient.Prenom);
                            ViewBag.CodeDossier = CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Code);
                            ViewBag.CodeGroupe = CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.GC.Code);
                            ViewBag.Specialiste = CRYPTAGE.StringHelpers.Decrypt(grossesse.MedecinTraitant.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(grossesse.MedecinTraitant.Personne.Prenom);
                            ViewBag.ResultatGrossesse = dal.GetEtatGrossesse(grossesse);
                            ViewBag.DateResultat = grossesse.DateResultat;

                            return View("ConsulterSuiviGrossesse");

                        }
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

        [HttpPost]
        public ActionResult CONSULTERGROSSESSE(String idGrossesse, int resultat, String specialisteID)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_GROSSESSE"))
                {
                    GROSSESSE grossesse = dal.ObtenirGrossesseParId(idGrossesse);
                    if (grossesse != null)
                    {
                        if (grossesse.Resultat == 0 && resultat != 0)
                        {
                            grossesse.Resultat = resultat;
                            grossesse.DateResultat = DateTime.Now;
                            grossesse.MedecinTraitant = dal.ObtenirUtilisateurParId(specialisteID);
                            dal.ModifierGrossesse(grossesse);

                        }
                        return RedirectToAction("CONSULTERGROSSESSE", new { id = CRYPTAGE.StringHelpers.Decrypt(grossesse.GrossesseID) });
                    }
                    else return View("Error");

                }

                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        /*
      * 25 Mai 2018 - @Hn
      * 
      */
        [HttpGet]
        public ActionResult AJOUTERGROSSESSE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_NOUVELLE_GROSSESSE"))
                {
                    LIAISONDOSSIERGROUPECIBLE liaisonDossierGC = dal.ObtenirLiaisonDossierGroupeParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (liaisonDossierGC != null)
                    {
                        List<GROSSESSE> grossesses = dal.ObtenirInfosGrossesseParLiaison(CRYPTAGE.StringHelpers.Encrypt(id));
                        if (grossesses != null)
                        {
                            Boolean statut = false;
                            foreach (var g in grossesses)
                            {
                                if (g.Resultat == 0)
                                {
                                    statut = true;
                                    break;
                                }
                            }
                            if (!statut)
                            {
                                return RedirectToAction("CONSULTERGROSSESSE", new { id = CRYPTAGE.StringHelpers.Decrypt(dal.EnregistrerGrossesse(liaisonDossierGC)) });
                            }

                            ViewBag.ErrorMessage = "Le dossier du patient indique une grossesse en cours, vous ne pouvez donc pas ajouter une nouvelle pour le moment.";
                            return View("Error");


                        }
                        else
                        {
                            return RedirectToAction("CONSULTERGROSSESSE", new { id = dal.EnregistrerGrossesse(liaisonDossierGC) });
                        }
                    }
                    else
                    {
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
        public ActionResult RETIRERMEMBREGROUPE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "RETIRER_MEMBRE_GROUPECIBLE"))
                {
                    LIAISONDOSSIERGROUPECIBLE ldgc = dal.ObtenirLiaisonDossierGroupeParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (ldgc != null)
                    {
                        ldgc.Actif = false;
                        ldgc.DateDepart = DateTime.Now;
                        dal.ModifierLiaisonDossierGroupe(ldgc);

                        return RedirectToAction("CONSULTERINFOSGROUPECIBLE", new { id = CRYPTAGE.StringHelpers.Decrypt(ldgc.GC.GroupeCibleID) });
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


    }
}
