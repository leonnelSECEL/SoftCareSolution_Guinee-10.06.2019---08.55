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
    public class ReglagesController : Controller
    {
        //
        // GET: /Reglages/

        public ActionResult CONSULTERLISTEGROUPEMALADIE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_GROUPEMALADIE"))
                {
                    List<GROUPEMALADIE> tempListeMaladie = dal.ObtenirTousLesGroupesMaladies();
                    List<GroupeMaladieVM> tempListeMaladieVM = new List<GroupeMaladieVM>();
                    if (tempListeMaladie != null)
                        foreach (var gm in tempListeMaladie)
                            tempListeMaladieVM.Add(dal.ConvertirGroupeMaladieGroupeMaladieVM(gm));

                    return View("ConsulterListeGroupeMaladies",tempListeMaladieVM);
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();

                return View("Error");

            }
        }

        [HttpGet]
        public ActionResult SUPPRIMERGROUPEMALADIE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "SUPPRIMER_GROUPEMALADIE"))
                {
                    GROUPEMALADIE gm = dal.ObtenirGroupeMaladieParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (gm != null)
                    {
                        gm.IsDeleted = true;
                        gm.DateSuppression = DateTime.Now;
                        List<MALADIE> lm = dal.ObtenirToutesLesMaladiesDunGroupe(gm.GroupeMaladieID);
                        if (lm != null && lm.Count > 0)
                            foreach (var m in lm)
                            {
                                m.IsDeleted = true;
                                m.DateSuppression = DateTime.Now;
                                dal.ModifierMaladie(m);
                            }
                        dal.ModifierGroupeMaladie(gm);
                        return RedirectToAction("CONSULTERLISTEGROUPEMALADIE");
                    }

                    return View("Error");
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    
                return View("Error");

            }

        }

        [HttpGet]
        public ActionResult EDITERGROUPEMALADIE(String GroupeMaladieID)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "MODIFIER_INFOS_GROUPEMALADIE"))
                {

                    if (!String.IsNullOrEmpty(GroupeMaladieID) && !String.IsNullOrWhiteSpace(GroupeMaladieID))
                    {
                        GROUPEMALADIE gm = dal.ObtenirGroupeMaladieParId(CRYPTAGE.StringHelpers.Encrypt(GroupeMaladieID));
                        return View("FormulaireEditerGroupeMaladies",gm);
                    }
                    return View("Error");
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    
                return View("Error");
            }

        }

        [HttpPost]
        public ActionResult EDITERGROUPEMALADIE(GROUPEMALADIE groupemaladie)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "MODIFIER_INFOS_GROUPEMALADIE"))
                {
                    if (ModelState.IsValid && !String.IsNullOrEmpty(groupemaladie.GroupeMaladieID) && !String.IsNullOrWhiteSpace(groupemaladie.GroupeMaladieID) && !String.IsNullOrWhiteSpace(groupemaladie.IntituleGroupe) && !String.IsNullOrEmpty(groupemaladie.IntituleGroupe))
                    {
                        groupemaladie.GroupeMaladieID = CRYPTAGE.StringHelpers.Encrypt(groupemaladie.GroupeMaladieID);
                        groupemaladie.IntituleGroupe = CRYPTAGE.StringHelpers.Encrypt(groupemaladie.IntituleGroupe);
                        dal.ModifierGroupeMaladie(groupemaladie);
                    }
                    return RedirectToAction("CONSULTERLISTEGROUPEMALADIE");
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    
                return View("Error");
            }

        }

        [HttpGet]
        public ActionResult EDITERMALADIE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "MODIFIER_INFOS_MALADIE"))
                {
                    if (!String.IsNullOrEmpty(id) && !String.IsNullOrWhiteSpace(id))
                    {
                        MALADIE m = dal.ObtenirMaladieParId(CRYPTAGE.StringHelpers.Encrypt(id));
                        return View("FormulaireEditerMaladie",m);

                    }
                    return View("Error");
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    
                return View("Error");
            }

        }

        [HttpPost]
        public ActionResult EDITERMALADIE(MALADIE maladie)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "MODIFIER_INFOS_MALADIE"))
                {
                    if (ModelState.IsValid && !String.IsNullOrEmpty(maladie.MaladieID) && !String.IsNullOrWhiteSpace(maladie.MaladieID) && !String.IsNullOrWhiteSpace(maladie.Intitule) && !String.IsNullOrEmpty(maladie.Intitule))
                    {
                        maladie.MaladieID = CRYPTAGE.StringHelpers.Encrypt(maladie.MaladieID);
                        maladie.Intitule = CRYPTAGE.StringHelpers.Encrypt(maladie.Intitule);
                        dal.ModifierMaladie(maladie);
                        return RedirectToAction("CONSULTERLISTEGROUPEMALADIE");
                    }
                    return View("Error");
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    
                return View("Error");
            }

        }

        [HttpGet]
        public ActionResult SUPPRIMERMALADIE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "SUPPRIMER_MALADIE"))
                {
                    MALADIE m = dal.ObtenirMaladieParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (m != null)
                    {
                        m.IsDeleted = true;
                        dal.ModifierMaladie(m);
                    }

                    return RedirectToAction("CONSULTERLISTEGROUPEMALADIE");
                }

                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();

                return View("Error");
            }

        }

        [HttpGet]
        public ActionResult AJOUTERGROUPEMALADIE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_NOUVEAU_GROUPEMALADIE"))
                {
                    GROUPEMALADIE gm = new GROUPEMALADIE();
                    return View(gm);
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    
                return View("Error");
            }

        }

        [HttpPost]
        public ActionResult AJOUTERGROUPEMALADIE(String NomGroupe)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "AJOUTER_NOUVEAU_GROUPEMALADIE"))
                {
                    if (!dal.ExisteGroupeMaladieParNom(NomGroupe))
                    {
                        GROUPEMALADIE gm = new GROUPEMALADIE
                        {
                            IntituleGroupe = NomGroupe
                        };
                        dal.CreerGroupeMaladie(gm);
                        return RedirectToAction("CONSULTERLISTEGROUPEMALADIE");
                    }
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    
                return View("Error");
            }

        }
        
        [HttpGet]
        public ActionResult ENREGISTRERMALADIE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_NOUVELLE_MALADIE"))
                {
                    GROUPEMALADIE gm = dal.ObtenirGroupeMaladieParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (gm != null)
                    {
                        MaladieVM2 mvm2 = new MaladieVM2();
                        mvm2.GroupeMaladieID = gm.GroupeMaladieID;
                        return View(mvm2);
                    }
                    return View("Error");
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    
                return View("Error");
            }

        }
        
        [HttpPost]
        public ActionResult ENREGISTRERMALADIE(MaladieVM2 maladie)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "ENREGISTRER_NOUVELLE_MALADIE"))
                {
                    if (ModelState.IsValid && dal.ObtenirGroupeMaladieParId(CRYPTAGE.StringHelpers.Encrypt(maladie.GroupeMaladieID)) != null)
                    {
                        MALADIE m = new MALADIE
                        {
                            Intitule = maladie.NomMaladie,
                            TypeMaladie = dal.ObtenirGroupeMaladieParId(CRYPTAGE.StringHelpers.Encrypt(maladie.GroupeMaladieID)),
                        };
                        dal.CreerMaladie(m);
                        return RedirectToAction("CONSULTERLISTEGROUPEMALADIE");
                    }
                    else
                    {
                        return View(maladie);
                    }
                }
                ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    
                return View("Error");
            }

        }

    }
}
