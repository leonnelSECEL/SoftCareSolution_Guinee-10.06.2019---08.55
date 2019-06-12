using SoftCare.Models;
using SoftCare.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace SoftCare.Controllers
{
    //[Authorize]
    public class CompteUtilisateurController : Controller
    {
        //
        // GET: /CompteUtilisateur/

        public ActionResult SeConnecter(UtilisateurVM userinfo, string ReturnUrl)
        {
            if (ModelState.IsValid)
            {
                using (IDAL dal = new Dal())
                {
                    UTILISATEUR user = dal.ObtenirUtilisateurAvecIdentifiants(userinfo.Login, userinfo.Password); // crypte login et mdp
                    if (user != null && user.Actif == true)
                    {
                        FormsAuthentication.SetAuthCookie(user.UtilisateurID, false);
                        if (!String.IsNullOrEmpty(ReturnUrl) && Url.IsLocalUrl(ReturnUrl))
                            return Redirect(ReturnUrl);
                        return Redirect("/");

                    }

                    ViewBag.ReturnUrl = ReturnUrl;
                    ViewBag.ErrorMessage = "Les informations de connexion spécifiées ne correspondent pas aux données présentes dans nos fichiers.";
                    return View("Login", userinfo);

                }
            }
            else
            {

                if (HttpContext.User.Identity.IsAuthenticated)
                {
                    return RedirectToAction("SeDeconnecter");
                }
                else
                {
                    UtilisateurVM user = new UtilisateurVM();
                    ViewBag.ReturnUrl = ReturnUrl;
                    return View("Login", user);
                }

            }



        }

        public ActionResult SeDeconnecter()
        {
            FormsAuthentication.SignOut();
            ViewBag.ErrorMessage = "Vous êtes à présent déconnecté. Veuillez spécifier vos accès pour accéder à Medical Softcare.";
            return RedirectToAction("SeConnecter");
        }

        [HttpGet]
        [Authorize]
        public ActionResult CREERUTILISATEUR()
        {
            ViewBag.IdUtilisateur = HttpContext.User.Identity.Name;
            ViewBag.Create = false;
            ViewBag.IdUtilisateur = 0;

            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CREER_UTILISATEUR"))
                {
                    List<ROLE> listeRole = dal.ObtenirTousLesRoles();
                    List<RoleVM> listeR = new List<RoleVM>();
                    if (listeRole != null)
                    {
                        foreach (var r in listeRole)
                            listeR.Add(dal.ConvertirRoleRoleVM(r));
                    }
                    ViewBag.ListeRole = listeR;
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

            return View("FormulaireCreationUtilisateur");
        }

        [HttpPost]
        [Authorize]
        public ActionResult CREERUTILISATEUR(UtilisateurVM3 User)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CREER_UTILISATEUR"))
                {

                    if (ModelState.IsValid)
                    {

                        if (dal.ObtenirUtilisateurAvecIdentifiants(User.InfosConnexion.Login, User.InfosConnexion.Password) == null)
                        {
                            PERSONNE personne = new PERSONNE
                            {
                                Email = User.InfosPersonne.Email,
                                Nom = User.InfosPersonne.Nom,
                                Prenom = User.InfosPersonne.Prenom,
                                TelephonePrincipal = User.InfosPersonne.TelephonePrincipal
                            };

                            personne.PersonneID = dal.EnregistrerPersonne(personne);

                            UTILISATEUR newUser = new UTILISATEUR
                            {
                                Actif = true,
                                Login = User.InfosConnexion.Login,
                                Password = User.InfosConnexion.Password,
                                Personne = dal.ObtenirPersonneParId(personne.PersonneID),
                                Role = dal.ObtenirRoleParId(User.Role.RoleID)
                            };

                            ViewBag.Create = true;
                            ViewBag.IdUtilisateur = dal.EnregistrerUtilisateur(newUser);
                            return RedirectToAction("CONSULTERLISTEUTILISATEUR");

                        }
                        else
                        {
                            ViewBag.ErrorMessage = "Modifiez vos paramètres de connexion choisies et réessayez à nouveau SVP.";
                            List<ROLE> listeRole = dal.ObtenirTousLesRoles();
                            List<RoleVM> listeR = new List<RoleVM>();
                            if (listeRole != null)
                            {
                                foreach (var r in listeRole)
                                    listeR.Add(dal.ConvertirRoleRoleVM(r));
                            }
                            ViewBag.ListeRole = listeR;
                            return View("FormulaireCreationUtilisateur", User);

                        }
                    }

                    else
                    {
                        List<ROLE> listeRole = dal.ObtenirTousLesRoles();
                        List<RoleVM> listeR = new List<RoleVM>();
                        if (listeRole != null)
                        {
                            foreach (var r in listeRole)
                                listeR.Add(dal.ConvertirRoleRoleVM(r));
                        }
                        ViewBag.ListeRole = listeR;
                        return View("FormulaireCreationUtilisateur", User);
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
        [Authorize]
        public ActionResult CONSULTERLISTEUTILISATEUR()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_UTILISATEUR"))
                {
                    List<UtilisateurVM4> listeUtilisateur = new List<UtilisateurVM4>();

                    List<UTILISATEUR> listeUser = null;
                    listeUser = dal.ObtenirTousLesUtilisateurs(-1, null);
                    if (listeUser != null)
                    {
                        foreach (var u in listeUser)
                            listeUtilisateur.Add(dal.ConvertirUtilisateurUtilisateurVM4(u));
                    }
                    List<ROLE> listeRole = dal.ObtenirTousLesRoles();
                    List<RoleVM> listeR = new List<RoleVM>();
                    if (listeRole != null)
                    {
                        foreach (var r in listeRole)
                            listeR.Add(dal.ConvertirRoleRoleVM(r));
                    }
                    ViewBag.ListeRole = listeR;

                    return View("ConsulterListeUtilisateurs", listeUtilisateur);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpPost]
        [Authorize]
        public ActionResult CONSULTERLISTEUTILISATEUR(int etatCompte, String role)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_UTILISATEUR"))
                {
                    List<UtilisateurVM4> listeUtilisateur = new List<UtilisateurVM4>();

                    List<ROLE> listeRole = dal.ObtenirTousLesRoles();
                    List<RoleVM> listeR = new List<RoleVM>();
                    if (listeRole != null)
                    {
                        foreach (var r in listeRole)
                            listeR.Add(dal.ConvertirRoleRoleVM(r));
                    }

                    ViewBag.ListeRole = listeR;


                    List<UTILISATEUR> listeUser = null;
                    listeUser = dal.ObtenirTousLesUtilisateurs(etatCompte, role);

                    if (listeUser != null)
                    {
                        foreach (var u in listeUser)
                            listeUtilisateur.Add(dal.ConvertirUtilisateurUtilisateurVM4(u));
                    }


                    return PartialView("PartialViewListeUtilisateur", listeUtilisateur);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        [Authorize]
        public ActionResult PROFIL()
        {

            using (IDAL dal = new Dal())
            {
                UTILISATEUR ProfilUser = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);

                if (ProfilUser != null)
                {
                    ViewBag.NomUtilisateur = CRYPTAGE.StringHelpers.Decrypt(ProfilUser.Personne.Prenom);
                    //Affichage de la vue conséquente
                    UtilisateurVM3 uvm3 = new UtilisateurVM3();
                    uvm3 = dal.ConvertirUtilisateurUtilisateurVM3(ProfilUser);

                    return View("ConsulterProfilUtilisateur", uvm3);

                }

                return View("Error");
            }

        }

        [HttpPost]
        [Authorize]
        public ActionResult PROFIL(UtilisateurVM3 UserAccount)
        {
            using (IDAL dal = new Dal())
            {
                UTILISATEUR UserCurrent = dal.ObtenirUtilisateurParId(HttpContext.User.Identity.Name);
                if (UserCurrent != null && UserCurrent.UtilisateurID == UserAccount.Id)
                {
                    PERSONNE personne = new PERSONNE
                    {
                        PersonneID = UserAccount.InfosPersonne.Id,
                        Email = UserAccount.InfosPersonne.Email,
                        Nom = UserAccount.InfosPersonne.Nom,
                        Prenom = UserAccount.InfosPersonne.Prenom,
                        TelephonePrincipal = UserAccount.InfosPersonne.TelephonePrincipal,
                        TelephoneSecondaire = UserAccount.InfosPersonne.TelephoneSecondaire,
                        Adresse = UserAccount.InfosPersonne.Adresse,
                        Sexe = UserAccount.InfosPersonne.Sexe
                    };

                    personne.PersonneID = dal.EnregistrerPersonne(personne);

                    UTILISATEUR user = new UTILISATEUR();
                    user.UtilisateurID = UserAccount.Id;
                    user.Actif = UserCurrent.Actif;
                    user.Fonction = UserAccount.InfosConnexion.Fonction;
                    user.Login = UserAccount.InfosConnexion.Login;
                    if (!String.IsNullOrEmpty(UserAccount.InfosConnexion.Password) || !String.IsNullOrWhiteSpace(UserAccount.InfosConnexion.Password)) user.Password = UserAccount.InfosConnexion.Password;
                    user.Personne = dal.ObtenirPersonneParId(personne.PersonneID);
                    user.Role = dal.ObtenirRoleParId(UserAccount.Role.RoleID);

                    dal.EnregistrerUtilisateur(user);

                    return RedirectToAction("PROFIL");
                }

                ViewBag.NomUtilisateur = UserAccount.InfosPersonne.Prenom;
                return View("Error");
            }
        }

        [HttpPost]
        [Authorize]
        public ActionResult DESACTIVERUTILISATEUR(String[] IdsCompteADesactiver)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "DESACTIVER_UTILISATEUR"))
                {
                    foreach (var u in IdsCompteADesactiver)
                    {
                        if (!String.IsNullOrWhiteSpace(u) && !String.IsNullOrEmpty(u))
                            dal.DesactiverUtilisateur(dal.ObtenirUtilisateurParId(u));
                    }

                    return RedirectToAction("CONSULTERLISTEUTILISATEUR");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        [Authorize]
        public ActionResult MANAGEACCOUNT(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "GERER_COMPTE_UTILISATEUR"))
                {
                    UTILISATEUR user = dal.ObtenirUtilisateurParId(CRYPTAGE.StringHelpers.Encrypt(id));
                    if (user != null)
                    {
                        ViewBag.NomUtilisateur = CRYPTAGE.StringHelpers.Decrypt(user.Personne.Prenom);
                        List<ROLE> listeRole = dal.ObtenirTousLesRoles();
                        List<RoleVM> listeR = new List<RoleVM>();
                        if (listeRole != null)
                        {
                            foreach (var r in listeRole)
                                listeR.Add(dal.ConvertirRoleRoleVM(r));
                        }

                        ViewBag.ListeRole = listeR;
                        UtilisateurVM5 uvm5 = new UtilisateurVM5();
                        uvm5 = dal.ConvertirUtilisateurUtilisateurVM5(user);

                        return View("FormulaireGestionCompte", uvm5);

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
        [Authorize]
        public ActionResult MANAGEACCOUNT(UtilisateurVM5 user)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "GERER_COMPTE_UTILISATEUR"))
                {
                    UTILISATEUR u = dal.ObtenirUtilisateurParId(CRYPTAGE.StringHelpers.Encrypt(user.Id));
                    if (u != null)
                    {
                        if (!String.IsNullOrEmpty(user.Password) && !String.IsNullOrWhiteSpace(user.Password)) u.Password = user.Password;
                        if (!String.IsNullOrEmpty(user.Login) && !String.IsNullOrWhiteSpace(user.Login)) u.Login = user.Login;
                        u.Role = dal.ObtenirRoleParId(user.RoleID);
                        u.Actif = user.Actif;
                        if (u.Role != null && !u.Role.IsDeleted)
                            dal.EnregistrerUtilisateur(u);
                    }

                    return RedirectToAction("CONSULTERLISTEUTILISATEUR");

                }
                else
                {
                    ViewBag.NomUtilisateur = user.NomUtilisateur;
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }

            }

        }

        [HttpGet]
        [Authorize]
        public ActionResult MANAGERLISTEROLE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CONSULTER_LISTE_ROLE"))
                {

                    List<ROLE> listeR = dal.ObtenirTousLesRoles();
                    List<RoleVM2> listeRVM2 = new List<RoleVM2>();
                    if (listeR != null)
                    {
                        foreach (var r in listeR)
                        {
                            listeRVM2.Add(dal.ConvertirRoleRoleVM2(r, false));
                        }
                    }

                    ViewBag.ListeRole = listeR;
                    return View("ConsulterListeRoles", listeRVM2);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        [Authorize]
        public ActionResult MANAGERROLE(String id)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "GERER_ROLE"))
                {
                    RoleVM2 rvm2 = dal.ConvertirRoleRoleVM2(dal.ObtenirRoleParId(CRYPTAGE.StringHelpers.Encrypt(id)), true);
                    List<PRIVILEGE> listeP = dal.ObtenirTousLesPrivileges();
                    if (listeP != null)
                        foreach (var p in listeP)
                        {
                            p.Peut = CRYPTAGE.StringHelpers.Decrypt(p.Peut);
                            p.Libelle = CRYPTAGE.StringHelpers.Decrypt(p.Libelle);
                        }
                    ViewBag.ListePrivilege = listeP;
                    if (rvm2 != null)
                        return View("FormulaireGestionRole", rvm2);
                    else
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
        [Authorize]
        public ActionResult MANAGERROLE(RoleVM2 role)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "GERER_ROLE"))
                {

                    if (ModelState.IsValid)
                    {

                        ROLE r1 = dal.ObtenirRoleParId(role.RoleID);
                        if (r1.Intitule != CRYPTAGE.StringHelpers.Encrypt(role.Intitule) || r1.IsDeleted != !role.Actif)
                        {
                            ROLE r = new ROLE
                            {
                                IsDeleted = !role.Actif,
                                Intitule = role.Intitule,
                                RoleID = role.RoleID,
                            };

                            dal.ModifierRole(r);
                            if (!role.Actif)
                            {
                                List<UTILISATEUR> listUtilisateurs = dal.ObtenirTousLesUtilisateurs(1, role.RoleID);
                                if (listUtilisateurs != null && listUtilisateurs.Count > 0)
                                {
                                    foreach (var u in listUtilisateurs)
                                    {
                                        dal.DesactiverUtilisateur(u);
                                    }
                                }
                            }
                        }

                        List<PRIVILEGE> listeAncienPrivilege = dal.ObtenirListePrivilegesParListeAcces(dal.ObtenirTousLesAccesParRole(dal.ObtenirRoleParId(role.RoleID)));

                        if (role.TableauPrivilegeId != null)
                        {
                            role.ListePrivileges = new List<PRIVILEGE>();
                        }
                        foreach (var p in role.TableauPrivilegeId)
                            if (p != 0) role.ListePrivileges.Add(dal.ObtenirPrivilegeParId(p));


                        List<PRIVILEGE> listePrivilegeAretirer = dal.OperandeListePrivilege(listeAncienPrivilege, role.ListePrivileges);
                        if (listePrivilegeAretirer != null)
                            foreach (var p in listePrivilegeAretirer)
                                dal.RetirerAcces(dal.ObtenirAccesParRoleIdParPrivilegeId(role.RoleID, p.PrivilegeID));

                        List<PRIVILEGE> listePrivilegeAAjouter = dal.OperandeListePrivilege(role.ListePrivileges, listeAncienPrivilege);
                        if (listePrivilegeAAjouter != null)
                            foreach (var p in listePrivilegeAAjouter)
                                dal.CreerAcces(role.RoleID, p.PrivilegeID);

                        return RedirectToAction("MANAGERLISTEROLE");
                    }

                    return View(role);
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }
        }

        [HttpGet]
        [Authorize]
        public ActionResult AJOUTERROLE()
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CREER_ROLE"))
                {
                    List<PRIVILEGE> listeP = dal.ObtenirTousLesPrivileges();
                    if (listeP != null)
                        foreach (var p in listeP)
                        {
                            p.Peut = CRYPTAGE.StringHelpers.Decrypt(p.Peut);
                            p.Libelle = CRYPTAGE.StringHelpers.Decrypt(p.Libelle);
                        }
                    ViewBag.ListePrivilege = listeP;
                    return View("FormulaireCreationRole");
                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }

        [HttpPost]
        [Authorize]
        public ActionResult AJOUTERROLE(RoleVM3 role)
        {
            using (IDAL dal = new Dal())
            {
                if (dal.VerifierAccesParUtilisateurIdParPrivilegePeut(HttpContext.User.Identity.Name, "CREER_ROLE"))
                {
                    if (ModelState.IsValid)
                    {
                        if (!dal.ExisteRole(role.Intitule))
                        {
                            role.RoleID = dal.CreerRole(new ROLE
                            {
                                Intitule = role.Intitule
                            });


                            if (role.TableauPrivilegeId != null)
                            {
                                foreach (var p in role.TableauPrivilegeId)
                                    if (p != 0)
                                        dal.CreerAcces(role.RoleID, p);
                            }
                        }

                        return RedirectToAction("MANAGERLISTEROLE");

                    }

                    else
                        return View("FormulaireCreationRole", role);

                }
                else
                {
                    ViewBag.ErrorMessage = dal.getErrorMessageFailedAuthorization();
                    return View("Error");
                }
            }

        }



        [HttpGet]
        [Authorize]
        public ActionResult AJOUTERPRIVILEGE(int Id)
        {
            PRIVILEGE privilege = new PRIVILEGE();
            if (Id != 0)
            {
                using (IDAL dal = new Dal())
                {
                    privilege = dal.ObtenirPrivilegeParId(Id);

                    privilege.Controller = CRYPTAGE.StringHelpers.Decrypt(privilege.Controller);
                    privilege.ActionName = CRYPTAGE.StringHelpers.Decrypt(privilege.ActionName);
                    privilege.Peut = CRYPTAGE.StringHelpers.Decrypt(privilege.Peut);
                    privilege.Libelle = CRYPTAGE.StringHelpers.Decrypt(privilege.Libelle);
                }
            }
            return View("FormulaireCreationPrivilege", privilege);
        }

        [HttpPost]
        [Authorize]
        public ActionResult AJOUTERPRIVILEGE(PRIVILEGE Privilege)
        {
            using (IDAL dal = new Dal())
            {
                if (Privilege != null)
                {
                    List<PRIVILEGE> ListePrivilegesExistants = dal.ObtenirTousLesPrivileges(); 
                    
                    foreach(var p in ListePrivilegesExistants)
                    {
                        if(
                            CRYPTAGE.StringHelpers.Decrypt(p.Controller) == Privilege.Controller &&
                            CRYPTAGE.StringHelpers.Decrypt(p.ActionName)  == Privilege.ActionName &&
                            CRYPTAGE.StringHelpers.Decrypt(p.Peut) == Privilege.Peut
                          )
                        {
                            ViewBag.PrivilegeExiste = "Ce Privilège Existe déjà dans le Système.";
                            return View("FormulaireCreationPrivilege", Privilege); 
                        }
                    }

                    int isSaved = dal.EnregistrerPrivilege(Privilege);

                    if (isSaved > 0)
                    {
                        return RedirectToAction("LISTEPRIVILEGES");
                    }
                    else
                    {
                        return RedirectToAction("AJOUTERPRIVILEGE");
                    }
                }
                else
                {
                    return RedirectToAction("AJOUTERPRIVILEGE");
                }

            }

        }


        [HttpGet]
        [Authorize]
        public ActionResult LISTEPRIVILEGES()
        {
            using (IDAL dal = new Dal())
            {
                List<PRIVILEGE> listePrivileges = dal.ObtenirTousLesPrivileges();
                List<PRIVILEGE> TempListePrivilege = new List<PRIVILEGE>();
                PRIVILEGE tempPrivilege;

                foreach (var p in listePrivileges)
                {
                    tempPrivilege = new PRIVILEGE();
                    tempPrivilege.PrivilegeID = p.PrivilegeID;
                    tempPrivilege.ActionName = CRYPTAGE.StringHelpers.Decrypt(p.ActionName);
                    tempPrivilege.Controller = CRYPTAGE.StringHelpers.Decrypt(p.Controller);
                    tempPrivilege.Peut = CRYPTAGE.StringHelpers.Decrypt(p.Peut);
                    tempPrivilege.Libelle = CRYPTAGE.StringHelpers.Decrypt(p.Libelle);
                    tempPrivilege.DateCreation = p.DateCreation;

                    TempListePrivilege.Add(tempPrivilege);
                }
                return View("ConsulterListePrivileges", TempListePrivilege.OrderBy(t => t.Controller).ThenBy(t => t.ActionName));

            }
        }
    }
}
