using Newtonsoft.Json;
using SoftCare.Models;
using SoftCare.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SoftCare.Controllers
{
    public class StatistiquesController : Controller
    {
        //
        // GET: /Statistiques/
        [HttpGet]
        public ActionResult PATHOLOGIES()
        {
            using (IDAL dal = new Dal())
            {
                List<MALADIE> listeDeMaladies = dal.ObtenirToutesLesMaladies();
                if (listeDeMaladies != null) 
                foreach (var m in listeDeMaladies)
                {
                    m.Intitule = CRYPTAGE.StringHelpers.Decrypt(m.Intitule);
                }
                ViewBag.ListeMaladies = listeDeMaladies;

                return View("ConsulterPathologies");
            }
        }

        [HttpPost]
        public ActionResult PATHOLOGIES(PathologieVM pathologie)
        {
            if (ModelState.IsValid)
            {
                using (IDAL dal = new Dal())
                {
                    //Recuperer tous les dossiers basés sur le sexe
                    //Filtrer avec la tranche d'age
                    //ObtenirTousLesDiagnostic de chacun de ses dossiers par maladie
                    List<DOSSIER> listeDossiers = null;
                    
                    if (pathologie.Genre == 0 || pathologie.Genre == 1)
                    {
                        listeDossiers = dal.ObtenirTousLesDossiers(false).Where(d => d.Patient.Sexe == pathologie.Genre).ToList();
                    }
                    else
                    {
                        listeDossiers = dal.ObtenirTousLesDossiers(false);
                    }

                    if (listeDossiers != null)
                    {
                        List<DOSSIER> EchantillonDossier = new List<DOSSIER>();
                        foreach (var d in listeDossiers)
                        {
                            if ((dal.CalculAge(d.Patient.DateNaissance) <= pathologie.Tranche.sup) && (dal.CalculAge(d.Patient.DateNaissance) >= pathologie.Tranche.inf))
                                EchantillonDossier.Add(d);
                        }
                        if (EchantillonDossier.Count > 0)
                        {
                            List<StatistiquesVM> Resultat = new List<StatistiquesVM>();
                            StatistiquesVM stat = new StatistiquesVM();
                            foreach (var p in pathologie.MaladiesId)
                            {
                                if (!p.Equals(String.Empty))
                                {

                                    stat.Label = CRYPTAGE.StringHelpers.Decrypt(dal.ObtenirMaladieParId(p).Intitule);
                                    stat.Taille = 0;
                                    List<DIAGNOSTIC> tempListe = null, tempListeM = new List<DIAGNOSTIC>();
                                    foreach (var e in EchantillonDossier)
                                    {
                                        tempListe = dal.RecupererTousLesDiagnosticDossier(e);
                                        if(tempListe != null)
                                            tempListe = tempListe.Where(d => d.Maladie != null && d.DateDiagnostic >= pathologie.Periode.inf && d.DateDiagnostic <= pathologie.Periode.sup).ToList();

                                        if (tempListe != null)
                                        {
                                            tempListeM = tempListe
                                                .Where(m => (m.Maladie.MaladieID == p))
                                                .ToList();
                                            
                                            stat.Taille += tempListeM.Count();
                                        }
                                        
                                    }

                                    Resultat.Add(stat);
                                    stat = new StatistiquesVM();
                                }

                            }
                            List<DataPoint> dataPoints = new List<DataPoint>();
                            foreach (var r in Resultat)
                            {
                                dataPoints.Add(new DataPoint(r.Label, r.Taille));
                            }

                            ViewBag.DataPoints = JsonConvert.SerializeObject(dataPoints);
                            return View("StatsPathologies");
                        }

                    }
                    return View("Error");
                }

            }
            else
                return RedirectToAction("PATHOLOGIES");
        }

        [HttpGet]
        public ActionResult MATERNITE()
        {
            using (IDAL dal = new Dal())
            {
                List<GROUPECIBLE> listeGC = dal.ObtenirTousLesGroupesCibles(0);
                if (listeGC != null)
                {
                    foreach (var gc in listeGC)
                    {
                        gc.Code = CRYPTAGE.StringHelpers.Decrypt(gc.Code);
                    }
                }
                ViewBag.ListeGroupeCible = listeGC;

                return View("ConsulterMaternite", new MaterniteVM());
            }
        }

        [HttpPost]
        public ActionResult MATERNITE(MaterniteVM preferences)
        {
            using (IDAL dal = new Dal())
            {
                if (ModelState.IsValid)
                {
                    List<LIAISONDOSSIERGROUPECIBLE> MembresGC = new List<LIAISONDOSSIERGROUPECIBLE>();
                    List<StatistiquesVM> StatistiquesVM = new List<StatistiquesVM>();
                    StatistiquesVM stat = new StatistiquesVM();

                    foreach (var g in preferences.GroupeId)
                    {
                        MembresGC.AddRange(dal.ObtenirToutesLesLiaisonsDunGroupeParId(g, 1));
                    }
                    if (MembresGC.Count > 0)
                    {
                        List<GROSSESSE> grossesse = new List<GROSSESSE>();
                       
                        foreach (var m in MembresGC)
                        {
                            grossesse.AddRange(dal.ObtenirInfosGrossesseParLiaison(m.LiaisonDossierGroupeCibleID));
                        }
                        if (grossesse.Count > 0)
                        {               

                            foreach (var t in preferences.ResultatId)
                            {
                                if (t != -77)
                                {
                                    stat.Taille = 0;
                                    foreach (var gr in grossesse)
                                    {
                                        if (gr.Resultat == t) stat.Taille += 1;
                                    }
                                    for (int j = 0; j < preferences.cle.Length; j++)
                                    {
                                        if (preferences.cle[j] == t) stat.Label = preferences.Intitule[j];
                                    }

                                    StatistiquesVM.Add(stat);
                                }
                                stat = new StatistiquesVM();
                            }

                            
                        }
                    }
                    List<DataPoint> dataPoints = new List<DataPoint>();
                    foreach (var r in StatistiquesVM)
                    {
                        dataPoints.Add(new DataPoint(r.Label, r.Taille));
                    }

                    ViewBag.DataPoints = JsonConvert.SerializeObject(dataPoints);
                    return View("StatsMaternite");
                }

                return View("ConsulterMaternite", preferences);
            }
        }


    }
}
