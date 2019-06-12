using SoftCare.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SoftCare.Models
{
    //Cette classe est l'implémentation concrète de l'interface bibliothèque
    //En liant les méthodes et les données en DB


    public class Dal : IDAL
    {
        //Nombre MAX de dossiers à afficher par page
        int LONGUEUR = 15;
        string ERROR_MSG_FAILED_AUTHORIZATION = "Désolé, vous n'êtes pas autorisé à effectuer l'action demandée. Veuillez contacter l'administrateur du service pour plus d'informations.";
        string ERROR_MSG_FAILED_ARCHIVE_FOLDER = "Désolé, vous ne pouvez procéder à l'action demandée. Le dossier de ce patient a été archivé. Veuillez contacter l'administrateur du service pour plus d'informations.";
        /*
 
         * Date du 31 Décembre 2017 - @Hn
 
         */
        private BddContext bdd;

        //Constructeur
        public Dal()
        {
            bdd = new BddContext();
        }


        public void Dispose()
        {
            bdd.Dispose();
        }


        #region OC : Implémentation des méthodes 

        public DOSSIER RecupererDossierPersonne(PERSONNE personne)
        {
            if (personne != null) return bdd.Dossiers.FirstOrDefault(d => d.Patient.PersonneID == personne.PersonneID);
            return null;
        }

        public SearchDossier ConvertirDossierSearchDossier(DOSSIER dossier)
        {
            if (dossier != null)
            {
                SearchDossier tempSearchDossier = new SearchDossier();

                tempSearchDossier.DossierId = dossier.DossierID;
                if (dossier.Patient != null)
                {
                    tempSearchDossier.Adresse = ReduireTaille(CRYPTAGE.StringHelpers.Decrypt(dossier.Patient.Adresse), 100);
                    tempSearchDossier.Nom = CRYPTAGE.StringHelpers.Decrypt(dossier.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(dossier.Patient.Prenom);
                    tempSearchDossier.Tel = CRYPTAGE.StringHelpers.Decrypt(dossier.Patient.TelephonePrincipal);
                    tempSearchDossier.Code = CRYPTAGE.StringHelpers.Decrypt(dossier.Code);
                    if (dossier.Code.Length >= 4) tempSearchDossier.Code = getCodeFormat(tempSearchDossier.Code);
                }
                tempSearchDossier.LastDateVisit = TrouverDateDerniereVisitePatient(dossier);
                tempSearchDossier.LastVisit = ConvertirDateChaine(tempSearchDossier.LastDateVisit);
                if (dossier.Archived) tempSearchDossier.DateArchive = ConvertirDateChaine(dossier.DateArchivage);


                return tempSearchDossier;
            }

            return null;
        }


        public DateTime TrouverDateDerniereVisitePatient(DOSSIER dossier)
        {

            DateTime tempDate = new DateTime();
            if (dossier != null)
            {
                tempDate = dossier.DateCreation;
                List<DIAGNOSTIC> tempListeDiagnostic = RecupererTousLesDiagnosticDossier(dossier);
                if (tempListeDiagnostic != null && tempListeDiagnostic.Count > 0)
                {
                    foreach (var tld in tempListeDiagnostic)
                        tempDate = tld.DateDiagnostic;
                }

            }
            return tempDate;

        }


        public List<DIAGNOSTIC> RecupererTousLesDiagnosticDossier(DOSSIER dossier)
        {
            List<DIAGNOSTIC> tempListeDiagnostic = new List<DIAGNOSTIC>();
            if (dossier != null)
            {
                tempListeDiagnostic = bdd.Diagnostics.Where(d => d.Dossier.DossierID == dossier.DossierID).OrderByDescending(d => d.DateDiagnostic).ToList();
            }
            if (tempListeDiagnostic.Count > 0) return tempListeDiagnostic;

            return null;
        }

        public DOSSIER ObtenirDossierParCode(string code)
        {
            return bdd.Dossiers.FirstOrDefault(d => d.Code == code);
        }


        public List<PERSONNE> RechercherCorrespondancesNomPersonne(string nomOUprenom)
        {
            List<PERSONNE> listeP = bdd.Personnes.ToList();
            if (listeP != null)

                return listeP.Where(
                    p => (
                        (CRYPTAGE.StringHelpers.Decrypt(p.Nom).ToUpper().Contains(nomOUprenom.ToUpper()))
                        || (p.Prenom != null ? (CRYPTAGE.StringHelpers.Decrypt(p.Prenom).ToUpper().Contains(nomOUprenom.ToUpper())) : false
                       ))
                   ).ToList();

            return null;
        }


        public DOSSIER ObtenirDossierParId(String id)
        {
            return bdd.Dossiers.FirstOrDefault(d => d.DossierID == id);
        }

        public DossierVM ConvertirDossierDossierVM(DOSSIER dossier, Boolean shrinkText)
        {
            if (dossier != null)
            {
                DossierVM tempDossierVM = new DossierVM();
                List<DiagnosticVM> tempListeDVM = null;
                List<TraitementVM> tempListeTVM = null;


                tempDossierVM.Id = dossier.DossierID;
                tempDossierVM.Dossier = ObtenirDossierParId(dossier.DossierID);
                tempDossierVM.Dossier.Patient.Nom = CRYPTAGE.StringHelpers.Decrypt(tempDossierVM.Dossier.Patient.Nom);
                tempDossierVM.Dossier.Patient.Prenom = CRYPTAGE.StringHelpers.Decrypt(tempDossierVM.Dossier.Patient.Prenom);
                tempDossierVM.Dossier.Patient.Email = CRYPTAGE.StringHelpers.Decrypt(tempDossierVM.Dossier.Patient.Email);
                tempDossierVM.Dossier.Patient.TelephonePrincipal = CRYPTAGE.StringHelpers.Decrypt(tempDossierVM.Dossier.Patient.TelephonePrincipal);
                tempDossierVM.Dossier.Patient.TelephoneSecondaire = CRYPTAGE.StringHelpers.Decrypt(tempDossierVM.Dossier.Patient.TelephoneSecondaire);
                tempDossierVM.Dossier.Patient.Adresse = CRYPTAGE.StringHelpers.Decrypt(tempDossierVM.Dossier.Patient.Adresse);
                tempDossierVM.Dossier.Patient.LieuNaissance = CRYPTAGE.StringHelpers.Decrypt(tempDossierVM.Dossier.Patient.LieuNaissance);
                tempDossierVM.Dossier.Patient.DateNaissance = tempDossierVM.Dossier.Patient.DateNaissance;

                if (CRYPTAGE.StringHelpers.Decrypt(tempDossierVM.Dossier.Code) != null && CRYPTAGE.StringHelpers.Decrypt(tempDossierVM.Dossier.Code).Length >= 4)
                    tempDossierVM.Dossier.Code = getCodeFormat(CRYPTAGE.StringHelpers.Decrypt(tempDossierVM.Dossier.Code));
                tempDossierVM.Dossier.Patient = ObtenirDossierParId(dossier.DossierID).Patient;

                //Code pour la liste de diagnosticVM
                List<DIAGNOSTIC> tempListeD = RecupererTousLesDiagnosticDossier(dossier);
                if (tempListeD != null)
                {
                    tempListeDVM = new List<DiagnosticVM>();
                    foreach (var d in tempListeD)
                        tempListeDVM.Add(ConvertirDiagnosticDiagnosticVM(d));
                }
                tempDossierVM.Diagnostics = tempListeDVM;

                //Code pour la liste de paramètres
                tempDossierVM.Parametres = RecupererTousLesParametresDossier(dossier);
                if (tempDossierVM.Parametres != null)
                {
                    foreach (var p in tempDossierVM.Parametres)
                    {
                        if (p != null)
                            if (shrinkText)
                                p.Avis = ReduireTaille(CRYPTAGE.StringHelpers.Decrypt(p.Avis), 25);
                            else
                                p.Avis = CRYPTAGE.StringHelpers.Decrypt(p.Avis);

                    }
                }

                //Liste des Examens
                List<EXAMEN> tempListeExam = ObtenirExamenParDossier(dossier);
                if (tempListeExam != null)
                {
                    EXAMEN exam = new EXAMEN();
                    List<ExamenDetailsVM> ListeExamDetailsVM = new List<ExamenDetailsVM>();

                    foreach (var e in tempListeExam)
                    {
                        List<EXAMENDETAILS> listeDetails = ObtenirExamenDetailsParExamenId(e.ExamenID);

                        if (listeDetails != null)
                        {
                            ExamenDetailsVM examDetVM;
                            foreach (var examDet in listeDetails)
                            {
                                examDetVM = new ExamenDetailsVM();
                                examDetVM = ConvertirExamenDetailsExamenDetailsVM(examDet);
                                ListeExamDetailsVM.Add(examDetVM);
                            }
                        }                        
                    }
                    tempDossierVM.ExamenDetailsVM = ListeExamDetailsVM;
                }
                







                //Code pour la liste de traitements
                if (tempListeD != null)
                {
                    List<TRAITEMENT> tempListeT = new List<TRAITEMENT>();
                    foreach (var d in tempListeD)
                    {
                        tempListeT.AddRange(RecupererTousLesTraitementsDiagnostic(d));
                    }
                    if (tempListeT != null)
                    {
                        tempListeTVM = new List<TraitementVM>();
                        foreach (var t in tempListeT)
                        {
                            t.Recommandation = ReduireTaille(CRYPTAGE.StringHelpers.Decrypt(t.Recommandation), 100);
                            t.Specialiste.Personne.Nom = CRYPTAGE.StringHelpers.Decrypt(t.Specialiste.Personne.Nom);
                            t.Specialiste.Personne.Prenom = CRYPTAGE.StringHelpers.Decrypt(t.Specialiste.Personne.Prenom);
                            tempListeTVM.Add(ConvertirTraitementTraitementVM(t, false));
                        }
                    }
                }
                tempDossierVM.Traitements = tempListeTVM;

                return tempDossierVM;
            }

            return null;
        }

        public List<PARAMETRE> RecupererTousLesParametresDossier(DOSSIER dossier)
        {
            if (dossier != null)
            {
                return bdd.Parametres.Where(p => p.Dossier.DossierID == dossier.DossierID).OrderByDescending(p => p.DatePrise).ToList();
            }
            return null;
        }

        public DiagnosticVM ConvertirDiagnosticDiagnosticVM(DIAGNOSTIC diagnostic)
        {
            if (diagnostic != null)
            {
                DiagnosticVM tempDVM = new DiagnosticVM();
                tempDVM.Id = diagnostic.DiagnosticId;
                tempDVM.Avis = ReduireTaille(CRYPTAGE.StringHelpers.Decrypt(diagnostic.Avis), 80);
                tempDVM.DateDiagnostic = diagnostic.DateDiagnostic;
                tempDVM.DossierId = diagnostic.Dossier.DossierID;
                tempDVM.Specialiste = CRYPTAGE.StringHelpers.Decrypt(diagnostic.Auteur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(diagnostic.Auteur.Personne.Prenom);

                return tempDVM;
            }

            return null;
        }

        public List<TRAITEMENT> RecupererTousLesTraitementsDiagnostic(DIAGNOSTIC diagnostic)
        {
            if (diagnostic != null)
            {
                return bdd.Traitements.Where(t => t.Diagnostic.DiagnosticId == diagnostic.DiagnosticId).OrderByDescending(t => t.DateTraitement).ToList();
            }

            return null;
        }

        public TraitementVM ConvertirTraitementTraitementVM(TRAITEMENT traitement, Boolean decrypter)
        {
            if (traitement != null)
            {
                TraitementVM tempTVM = new TraitementVM();
                tempTVM.Id = traitement.TraitementID;
                tempTVM.DateTraitement = traitement.DateTraitement;
                if (decrypter)
                {
                    tempTVM.Traitement = CRYPTAGE.StringHelpers.Decrypt(traitement.Recommandation);
                    tempTVM.Specialiste = CRYPTAGE.StringHelpers.Decrypt(traitement.Specialiste.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(traitement.Specialiste.Personne.Prenom);
                }
                else
                {
                    tempTVM.Traitement = traitement.Recommandation;
                    tempTVM.Specialiste = traitement.Specialiste.Personne.Nom.ToUpper() + " " + traitement.Specialiste.Personne.Prenom;

                }
                return tempTVM;
            }

            return null;
        }


        public String EnregistrerPersonne(PERSONNE personne)
        {
            if (String.IsNullOrEmpty(personne.PersonneID) || String.IsNullOrWhiteSpace(personne.PersonneID))
            {
                PERSONNE pers = new PERSONNE
                {
                    Nom = CRYPTAGE.StringHelpers.Encrypt(personne.Nom),
                    Prenom = CRYPTAGE.StringHelpers.Encrypt(personne.Prenom),
                    TelephonePrincipal = CRYPTAGE.StringHelpers.Encrypt(personne.TelephonePrincipal),
                    TelephoneSecondaire = CRYPTAGE.StringHelpers.Encrypt(personne.TelephoneSecondaire),
                    Email = CRYPTAGE.StringHelpers.Encrypt(personne.Email),
                    Adresse = CRYPTAGE.StringHelpers.Encrypt(personne.Adresse),
                    LieuNaissance = CRYPTAGE.StringHelpers.Encrypt(personne.LieuNaissance),
                    DateNaissance = personne.DateNaissance,
                    Sexe = personne.Sexe,
                    IsDeleted = false,
                    IsModified = false,
                    DateSuppression = DateTime.Now,
                    DateModification = DateTime.Now,
                    PersonneID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "PERSONNE", 'T', 1))

                };

                bdd.Personnes.Add(pers);
                bdd.SaveChanges();

                return pers.PersonneID;
            }
            else
            {
                PERSONNE pers = ObtenirPersonneParId(personne.PersonneID);
                if (pers != null)
                {
                    pers.Nom = CRYPTAGE.StringHelpers.Encrypt(personne.Nom);
                    pers.Prenom = CRYPTAGE.StringHelpers.Encrypt(personne.Prenom);
                    pers.Sexe = personne.Sexe;
                    pers.TelephonePrincipal = CRYPTAGE.StringHelpers.Encrypt(personne.TelephonePrincipal);
                    pers.TelephoneSecondaire = CRYPTAGE.StringHelpers.Encrypt(personne.TelephoneSecondaire);
                    pers.Adresse = CRYPTAGE.StringHelpers.Encrypt(personne.Adresse);
                    pers.LieuNaissance = CRYPTAGE.StringHelpers.Encrypt(personne.LieuNaissance);
                    pers.DateNaissance = personne.DateNaissance;
                    pers.Email = CRYPTAGE.StringHelpers.Encrypt(personne.Email);
                    pers.IsDeleted = false;
                    pers.IsModified = true;
                    pers.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return pers.PersonneID;
                }
                return null;
            }

        }

        public String EnregistrerDossier(DOSSIER dossier)
        {
            DateTime tempDate = DateTime.Now;

            DOSSIER dos = new DOSSIER
            {
                Code = CRYPTAGE.StringHelpers.Encrypt(GenerationCodeDossier(tempDate, 'T', 1)),
                Createur = ObtenirUtilisateurParId(dossier.Createur.UtilisateurID),
                Patient = ObtenirPersonneParId(dossier.Patient.PersonneID),
                DateCreation = tempDate,
                DateArchivage = tempDate,
                Locked = dossier.Locked,
                Archived = dossier.Archived,
                PenseBete = dossier.PenseBete,
                IsDeleted = false,
                IsModified = false,
                DateSuppression = DateTime.Now,
                DateModification = DateTime.Now,
                DossierID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(tempDate, "DOSSIER", 'T', 1))
            };
            bdd.Dossiers.Add(dos);
            bdd.SaveChanges();

            return dos.DossierID;

        }


        public TRAITEMENT ObtenirTraitementParId(String id)
        {
            return bdd.Traitements.FirstOrDefault(t => t.TraitementID == id);
        }


        public TraitementVM2 ConvertirTraitementTraitementVM2(TRAITEMENT traitement)
        {
            if (traitement != null)
            {
                TraitementVM2 traitementVM2 = new TraitementVM2();
                traitementVM2.Id = traitement.TraitementID;
                traitementVM2.DossierID = traitement.Diagnostic.Dossier.DossierID;
                traitementVM2.DiagnosticId = traitement.Diagnostic.DiagnosticId;
                traitementVM2.Traitement = CRYPTAGE.StringHelpers.Decrypt(traitement.Recommandation);
                traitementVM2.Diagnostic = CRYPTAGE.StringHelpers.Decrypt(traitement.Diagnostic.Avis);
                traitementVM2.NomPatient = CRYPTAGE.StringHelpers.Decrypt(traitement.Diagnostic.Dossier.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(traitement.Diagnostic.Dossier.Patient.Prenom);
                traitementVM2.SpecialisteTraitement = CRYPTAGE.StringHelpers.Decrypt(traitement.Specialiste.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(traitement.Specialiste.Personne.Prenom);
                traitementVM2.SpecialisteDiagnostic = CRYPTAGE.StringHelpers.Decrypt(traitement.Diagnostic.Auteur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(traitement.Diagnostic.Auteur.Personne.Prenom);

                return traitementVM2;
            }

            return null;
        }


        public List<SpecialisteVM> ObtenirTousLesSpecialistes()
        {
            List<UTILISATEUR> tempListeUsers = bdd.Utilisateurs.ToList();
            if (tempListeUsers != null)
            {
                List<SpecialisteVM> tempListeSpecialiste = new List<SpecialisteVM>();
                SpecialisteVM tempSVM;
                foreach (var u in tempListeUsers)
                {
                    tempSVM = new SpecialisteVM();
                    tempSVM.Id = u.UtilisateurID;
                    tempSVM.NomSpecialiste = CRYPTAGE.StringHelpers.Decrypt(u.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(u.Personne.Prenom);
                    tempListeSpecialiste.Add(tempSVM);
                }

                return tempListeSpecialiste;
            }

            return null;
        }

        public void EnregistrerParametre(PARAMETRE parametre)
        {
            bdd.Parametres.Add(new PARAMETRE
            {
                Avis = CRYPTAGE.StringHelpers.Encrypt(parametre.Avis),
                DatePrise = parametre.DatePrise,
                Dossier = parametre.Dossier,
                Poids = parametre.Poids,
                Pouls = parametre.Pouls,
                Temperature = parametre.Temperature,
                Tension = parametre.Tension,
                IsDeleted = false,
                IsModified = false,
                DateSuppression = DateTime.Now,
                DateModification = DateTime.Now,
                ParametreID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "PARAMETRE", 'T', 1))

            });
            bdd.SaveChanges();
        }


        public void EnregistrerAttente(ATTENTE attente)
        {
            bdd.Attentes.Add(new ATTENTE
            {
                DateAttente = attente.DateAttente,
                Etat = attente.Etat,
                Statut = attente.Statut,
                Patient = attente.Patient,
                Specialiste = attente.Specialiste,
                IsDeleted = false,
                IsModified = false,
                DateSuppression = DateTime.Now,
                DateModification = DateTime.Now,
                AttenteID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "ATTENTE", 'T', 1))

            });
            bdd.SaveChanges();
        }


        public DIAGNOSTIC ObtenirDiagnosticParId(String id)
        {
            return bdd.Diagnostics.FirstOrDefault(d => d.DiagnosticId == id);
        }

        public DiagnosticVM2 ConvertirDiagnosticDiagnosticVM2(DIAGNOSTIC diagnostic)
        {
            if (diagnostic != null)
            {
                DiagnosticVM2 tempDiagnosticVM2 = new DiagnosticVM2();
                List<TRAITEMENT> tempListeTraitements = RecupererTousLesTraitementsDiagnostic(diagnostic);

                tempDiagnosticVM2.Id = diagnostic.DiagnosticId;
                tempDiagnosticVM2.DossierID = diagnostic.Dossier.DossierID;
                tempDiagnosticVM2.isArchived = diagnostic.Dossier.Archived;
                tempDiagnosticVM2.Diagnostic = CRYPTAGE.StringHelpers.Decrypt(diagnostic.Avis);
                tempDiagnosticVM2.DateDiagnostic = diagnostic.DateDiagnostic;
                tempDiagnosticVM2.Specialiste = CRYPTAGE.StringHelpers.Decrypt(diagnostic.Auteur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(diagnostic.Auteur.Personne.Prenom);
                if (tempListeTraitements != null)
                {
                    tempDiagnosticVM2.Traitements = new List<TraitementVM>();
                    foreach (var t in tempListeTraitements)
                        tempDiagnosticVM2.Traitements.Add(ConvertirTraitementTraitementVM(t, true));
                }

                return tempDiagnosticVM2;

            }
            return null;
        }

        public String EnregistrerDiagnostic(DIAGNOSTIC diagnostic)
        {
            if (diagnostic.Maladie != null)
            {
                DIAGNOSTIC dia = new DIAGNOSTIC
                {
                    Auteur = ObtenirUtilisateurParId(diagnostic.Auteur.UtilisateurID),
                    Avis = CRYPTAGE.StringHelpers.Encrypt(diagnostic.Avis),
                    DateDiagnostic = diagnostic.DateDiagnostic,
                    Dossier = ObtenirDossierParId(diagnostic.Dossier.DossierID),
                    Maladie = ObtenirMaladieParId(diagnostic.Maladie.MaladieID),
                    IsDeleted = false,
                    IsModified = false,
                    DateSuppression = DateTime.Now,
                    DateModification = DateTime.Now,
                    DiagnosticId = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "DIAGNOSTIC", 'T', 1))
                };
                bdd.Diagnostics.Add(dia);

                bdd.SaveChanges();

                return dia.DiagnosticId;
            }
            else
            {
                DIAGNOSTIC dia = new DIAGNOSTIC
                {
                    Auteur = ObtenirUtilisateurParId(diagnostic.Auteur.UtilisateurID),
                    Avis = CRYPTAGE.StringHelpers.Encrypt(diagnostic.Avis),
                    DateDiagnostic = diagnostic.DateDiagnostic,
                    Dossier = ObtenirDossierParId(diagnostic.Dossier.DossierID),
                    Maladie = null,
                    IsDeleted = false,
                    IsModified = false,
                    DateSuppression = DateTime.Now,
                    DateModification = DateTime.Now,
                    DiagnosticId = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "DIAGNOSTIC", 'T', 1))
                };
                bdd.Diagnostics.Add(dia);

                bdd.SaveChanges();

                return dia.DiagnosticId;
            }



        }

        public String EnregistrerTraitement(TRAITEMENT traitement)
        {
            TRAITEMENT trai = new TRAITEMENT
            {
                DateTraitement = traitement.DateTraitement,
                Diagnostic = traitement.Diagnostic,
                Recommandation = CRYPTAGE.StringHelpers.Encrypt(traitement.Recommandation),
                Specialiste = traitement.Specialiste,
                IsDeleted = false,
                IsModified = false,
                DateSuppression = DateTime.Now,
                DateModification = DateTime.Now,
                TraitementID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "TRAITEMENT", 'T', 1))

            };

            bdd.Traitements.Add(trai);
            bdd.SaveChanges();

            return trai.TraitementID;

        }

        public UTILISATEUR ObtenirUtilisateurParId(String utilisateurId)
        {
            return bdd.Utilisateurs.FirstOrDefault(u => u.UtilisateurID == utilisateurId);
        }

        /*
 
         * Date du 02 Janvier - @Hn
 
         */
        public ATTENTE ObtenirAttenteParId(string attenteId)
        {
            return bdd.Attentes.FirstOrDefault(a => a.AttenteID == attenteId);
        }

        public AttenteVM3 ConvertirAttenteAttenteVM3(ATTENTE attente)
        {
            AttenteVM3 atvm3 = null;
            if (attente != null)
            {
                atvm3 = new AttenteVM3();
                atvm3.AttenteId = attente.AttenteID;
                atvm3.AncienSpecialisteID = attente.Specialiste.UtilisateurID;
                atvm3.NomAncienSpecialiste = CRYPTAGE.StringHelpers.Decrypt(attente.Specialiste.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(attente.Specialiste.Personne.Prenom);
                atvm3.NomPatient = CRYPTAGE.StringHelpers.Decrypt(attente.Patient.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(attente.Patient.Patient.Prenom);
                atvm3.CodePatient = CRYPTAGE.StringHelpers.Decrypt(attente.Patient.Code);
                atvm3.Horaire = ConvertirDateChaine(attente.DateAttente);
            }

            return atvm3;
        }

        public String ConvertirDateChaine(DateTime date)
        {
            String horaire = "";
            String[] Mois = new String[] { "", "Jan.", "Fev.", "Mars", "Av.", "Mai", "Juin", "Juillet", "Août", "Sept.", "Oct.", "Nov.", "Déc." };

            if (date.Year == DateTime.Now.Year)
            {
                if (date.Month == DateTime.Now.Month)
                {
                    if (date.Day == DateTime.Now.Day)
                    {
                        horaire = horaire + "Aujourd'hui,";
                        horaire = horaire + " à " + date.ToShortTimeString();
                    }
                    else if ((date.Day - DateTime.Now.Day) == 1)
                    {
                        horaire = horaire + "Demain,";
                        horaire = horaire + " à " + date.ToShortTimeString();
                    }
                    else if ((DateTime.Now.Day - date.Day) == 1)
                    {
                        horaire = horaire + "Hier,";
                        horaire = horaire + " à " + date.ToShortTimeString();
                    }
                    else if ((date.Day - DateTime.Now.Day) == 2)
                    {
                        horaire = horaire + "Dans 2 jrs,";
                        horaire = horaire + " à " + date.ToShortTimeString();
                    }
                    else if ((date.Day - DateTime.Now.Day) == -2)
                    {
                        horaire = horaire + "Il y'a 2 jrs,";
                        horaire = horaire + " à " + date.ToShortTimeString();
                    }
                    else
                    {
                        horaire = horaire + date.Day + " " + Mois[date.Month] + " " + date.Year + " à " + date.ToShortTimeString();
                    }
                }
                else
                {
                    horaire = horaire + date.Day + " " + Mois[date.Month] + " " + date.Year + " à " + date.ToShortTimeString();
                }
            }
            else
            {
                horaire = horaire + date.ToShortDateString() + " à " + date.ToShortTimeString();
            }

            return horaire;

        }

        public void ModifierAttente(String attenteID, String specialisteID)
        {
            ATTENTE tempattente = ObtenirAttenteParId(attenteID);
            tempattente.Specialiste = ObtenirUtilisateurParId(specialisteID);
            tempattente.IsModified = true;
            tempattente.DateModification = DateTime.Now;
            if (tempattente != null && tempattente.Specialiste != null)
                bdd.SaveChanges();
        }

        public void EnregistrerModificationAttente(MODIFICATIONATTENTE modificationAttente)
        {
            bdd.ModificationAttentes.Add(new MODIFICATIONATTENTE
            {
                DateModification = modificationAttente.DateModification,
                Motif = CRYPTAGE.StringHelpers.Encrypt(modificationAttente.Motif),
                NouveauSpecialiste = ObtenirUtilisateurParId(modificationAttente.NouveauSpecialiste.UtilisateurID),
                AncienSpecialiste = ObtenirUtilisateurParId(modificationAttente.AncienSpecialiste.UtilisateurID),
                Attente = ObtenirAttenteParId(modificationAttente.Attente.AttenteID),
                ModificationAttenteID = GenererCle(DateTime.Now, "MODIFICATIONATTENTE", 'T', 1)
            });
            if (modificationAttente.Attente != null)
                bdd.SaveChanges();


        }

        public List<ATTENTE> ObtenirListeAttente(DateTime date)
        {
            DateTime tempDate = date.Date.AddDays(1);
            return bdd.Attentes.Where(a => a.DateAttente >= date.Date && a.DateAttente < tempDate).ToList();
        }

        public AttenteVM2 ConvertirAttenteAttenteVM2(ATTENTE attente)
        {
            AttenteVM2 attvm2 = null;
            if (attente != null)
            {
                attvm2 = new AttenteVM2();
                attvm2.AttenteId = attente.AttenteID;
                attvm2.CodePatient = CRYPTAGE.StringHelpers.Decrypt(attente.Patient.Code);
                if (attvm2.CodePatient.Length >= 4) attvm2.CodePatient = getCodeFormat(attvm2.CodePatient);
                attvm2.EtatAttente = attente.Etat;
                attvm2.StatutAttente = attente.Statut;
                attvm2.Horaire = ConvertirDateChaine(attente.DateAttente);
                attvm2.NomPatient = CRYPTAGE.StringHelpers.Decrypt(attente.Patient.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(attente.Patient.Patient.Prenom);
                attvm2.Specialiste = CRYPTAGE.StringHelpers.Decrypt(attente.Specialiste.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(attente.Specialiste.Personne.Prenom);
                attvm2.SpecialisteID = attente.Specialiste.UtilisateurID;
            }
            return attvm2;
        }

        public List<ATTENTE> ObtenirListeAttente(DateTime date, String specialisteID, int etat)
        {
            DateTime tempDate = date.Date.AddDays(1);
            if (specialisteID == "")
            {
                if (etat == 0)
                    return bdd.Attentes.Where(a => a.DateAttente >= date.Date && a.DateAttente < tempDate && a.Etat == false && a.Statut == true).ToList();
                if (etat == 1)
                    return bdd.Attentes.Where(a => a.DateAttente >= date.Date && a.DateAttente < tempDate && a.Etat == true && a.Statut == true).ToList();
                else
                    return bdd.Attentes.Where(a => a.DateAttente >= date.Date && a.DateAttente < tempDate).ToList();
            }
            else
            {
                if (etat == 0)
                    return bdd.Attentes.Where(a => a.DateAttente >= date.Date && a.DateAttente < tempDate && a.Specialiste.UtilisateurID == specialisteID && a.Etat == false && a.Statut == true).ToList();
                if (etat == 1)
                    return bdd.Attentes.Where(a => a.DateAttente >= date.Date && a.DateAttente < tempDate && a.Specialiste.UtilisateurID == specialisteID && a.Etat == true && a.Statut == true).ToList();
                else
                    return bdd.Attentes.Where(a => a.DateAttente >= date.Date && a.DateAttente < tempDate && a.Specialiste.UtilisateurID == specialisteID).ToList();
            }
        }

        public void DesactiverAttente(String attenteID)
        {
            ATTENTE temp_attente = ObtenirAttenteParId(attenteID);
            if (temp_attente != null)
            {
                temp_attente.Statut = false;
                temp_attente.IsModified = true;
                temp_attente.DateModification = DateTime.Now;
                bdd.SaveChanges();
            }
        }

        public void PrendreEnCharge(String attenteID)
        {
            ATTENTE temp_attente = ObtenirAttenteParId(attenteID);
            if (temp_attente != null)
            {
                temp_attente.Etat = false;
                temp_attente.IsModified = true;
                temp_attente.DateModification = DateTime.Now;
                bdd.SaveChanges();
            }
        }


        /*
 
         * Date du 03 Janvier - @Hn
 
         */

        public List<RENDEZVOUS> ObtenirTousLesRdvDossier(String dossierID)
        {
            return bdd.RendezVous.Where(r => r.Recepteur.DossierID == dossierID).ToList();
        }

        public RendezVousVM ConvertirRendezVousRendezVousVM(RENDEZVOUS rendezvous)
        {
            RendezVousVM tempRDVVM = null;
            if (rendezvous != null)
            {
                tempRDVVM = new RendezVousVM();
                tempRDVVM.DossierId = rendezvous.Recepteur.DossierID;
                tempRDVVM.RdvId = rendezvous.RendezVousID;
                tempRDVVM.SpecialisteID = rendezvous.Emetteur.Personne.PersonneID;
                tempRDVVM.Horaire = ConvertirDateChaine(rendezvous.Horaire);
                tempRDVVM.Specialiste = CRYPTAGE.StringHelpers.Decrypt(rendezvous.Emetteur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(rendezvous.Emetteur.Personne.Prenom);
                tempRDVVM.Patient = CRYPTAGE.StringHelpers.Decrypt(rendezvous.Recepteur.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(rendezvous.Recepteur.Patient.Prenom);
                tempRDVVM.Objet = CRYPTAGE.StringHelpers.Decrypt(rendezvous.Commentaire);
                tempRDVVM.Recu = rendezvous.Recu;
                tempRDVVM.Actif = rendezvous.Actif;
                tempRDVVM.Manque = rendezvous.Manque;
            }

            return tempRDVVM;
        }


        public String EnregistrerRendezVous(RENDEZVOUS rendezvous)
        {
            RENDEZVOUS tempR = new RENDEZVOUS
            {
                Actif = rendezvous.Actif,
                Commentaire = CRYPTAGE.StringHelpers.Encrypt(rendezvous.Commentaire),
                Emetteur = ObtenirUtilisateurParId(rendezvous.Emetteur.UtilisateurID),
                Horaire = rendezvous.Horaire,
                Recepteur = ObtenirDossierParId(rendezvous.Recepteur.DossierID),
                Recu = rendezvous.Recu,
                IsDeleted = false,
                IsModified = false,
                DateSuppression = DateTime.Now,
                DateModification = DateTime.Now,
                RendezVousID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "RENDEZVOUS", 'T', 1))
            };
            bdd.RendezVous.Add(tempR);
            bdd.SaveChanges();

            return tempR.RendezVousID;

        }

        public DateTime ConstruireDate(DateTime date, int heure, int minute)
        {
            DateTime temp_date = new DateTime(date.Year, date.Month, date.Day, heure, minute, date.Second);

            return temp_date;

        }

        public Boolean VerifierDisponibilite(String specialisteID, String patientID, DateTime horaire)
        {
            RENDEZVOUS Rdv = null;
            Rdv = bdd.RendezVous.FirstOrDefault(r => r.Emetteur.UtilisateurID == specialisteID && r.Horaire == horaire);
            if (Rdv != null) return false;
            else
                Rdv = bdd.RendezVous.FirstOrDefault(r => r.Recepteur.DossierID == patientID && r.Horaire == horaire);

            if (Rdv != null) return false;
            return true;


        }

        public RENDEZVOUS ConvertirRendezVousVM2RendezVous(RendezVousVM2 rendezvousVM2)
        {
            RENDEZVOUS rendezvous = null;
            if (rendezvousVM2 != null)
            {
                rendezvous = new RENDEZVOUS();
                rendezvous.Recu = false;
                rendezvous.Recepteur = ObtenirDossierParId(rendezvousVM2.DossierId);
                rendezvous.Horaire = ConstruireDate(rendezvousVM2.dateRDV, rendezvousVM2.heureRDV, rendezvousVM2.minuteRDV);
                rendezvous.Emetteur = ObtenirUtilisateurParId(rendezvousVM2.SpecialisteID);
                rendezvous.Commentaire = rendezvousVM2.ObjetRDV;
                rendezvous.Actif = true;

            }

            return rendezvous;
        }

        public RendezVousVM4 ConvertirRendezVousVM2RendezVousVM4(RendezVousVM2 rendezvousVM2)
        {
            RendezVousVM4 rendezvousVM4 = null;
            if (rendezvousVM2 != null)
            {
                UTILISATEUR user = ObtenirUtilisateurParId(rendezvousVM2.SpecialisteID);

                rendezvousVM4 = new RendezVousVM4();
                rendezvousVM4.DossierId = rendezvousVM2.DossierId;
                rendezvousVM4.Horaire = ConstruireDate(rendezvousVM2.dateRDV, rendezvousVM2.heureRDV, rendezvousVM2.minuteRDV);
                rendezvousVM4.nomPatient = rendezvousVM2.nomPatient;
                if (user != null)
                    rendezvousVM4.nomSpecialiste = user.Personne.Nom.ToUpper() + user.Personne.Prenom;
                rendezvousVM4.ObjetRDV = rendezvousVM2.ObjetRDV;
                rendezvousVM4.SpecialisteID = rendezvousVM2.SpecialisteID;

            }

            return rendezvousVM4;
        }

        /*
 
         * Date du 03 Janvier - @Hn
 
         */

        public RENDEZVOUS ObtenirRendezVousParId(String rdvId)
        {
            return bdd.RendezVous.FirstOrDefault(r => r.RendezVousID == rdvId);
        }

        public void ModifierRendezVous(RENDEZVOUS rdv)
        {
            RENDEZVOUS temp_rdv = ObtenirRendezVousParId(rdv.RendezVousID);
            if (temp_rdv != null)
            {
                temp_rdv.Recu = rdv.Recu;
                temp_rdv.Actif = rdv.Actif;
                temp_rdv.Manque = rdv.Manque;
                temp_rdv.Horaire = rdv.Horaire;
                temp_rdv.IsModified = true;
                temp_rdv.DateModification = DateTime.Now;
                bdd.SaveChanges();
            }
        }


        public RendezVousVM3 ConvertirRendezVousRendezVousVM3(RENDEZVOUS rendezvous)
        {
            RendezVousVM3 temp_rdvVM3 = null;

            if (rendezvous != null)
            {
                temp_rdvVM3 = new RendezVousVM3();
                temp_rdvVM3.AncienHoraire = rendezvous.Horaire;
                temp_rdvVM3.nomPatient = CRYPTAGE.StringHelpers.Decrypt(rendezvous.Recepteur.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(rendezvous.Recepteur.Patient.Prenom);
                temp_rdvVM3.nomSpecialiste = CRYPTAGE.StringHelpers.Decrypt(rendezvous.Emetteur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(rendezvous.Emetteur.Personne.Prenom);
                temp_rdvVM3.ObjetRDV = CRYPTAGE.StringHelpers.Decrypt(rendezvous.Commentaire);
                temp_rdvVM3.rdvId = rendezvous.RendezVousID;
            }

            return temp_rdvVM3;
        }

        /*
 
         * Date du 10 Janvier - @Hn
 
         */

        public Double ConvertirChaineDouble(String chaine)
        {
            Double valeur;
            if (Double.TryParse(chaine, out valeur)) return valeur;
            else return Double.NaN;
        }

        public List<DOSSIER> ObtenirLeRegistreMedical(String firstDossierId, Boolean sens, Boolean archived)
        {
            if (!archived)
            {
                if (firstDossierId == ObtenirIdPremierDossier() && sens == false) //code crypté
                {
                    List<DOSSIER> tempLD = null;
                    DOSSIER tempD = ObtenirDossierParId(firstDossierId);
                    int reste = (int)ObtenirNombreDossier() % LONGUEUR;
                    if (reste == 0)
                        tempLD = bdd.Dossiers.Where(d => (!d.Archived && d.DateCreation >= tempD.DateCreation && (d.DossierID != firstDossierId))).OrderBy(d => d.DateCreation).Skip(LONGUEUR - 1).Take(LONGUEUR).ToList();
                    else
                        tempLD = bdd.Dossiers.Where(d => (!d.Archived && d.DateCreation >= tempD.DateCreation && (d.DossierID != firstDossierId))).OrderBy(d => d.DateCreation).Take(LONGUEUR).ToList();

                    if (tempLD != null && tempLD.Count != 0)
                        tempLD = tempLD.OrderByDescending(d => d.DateCreation).ToList();
                    return tempLD;
                }

                if (String.IsNullOrEmpty(firstDossierId) && (sens == true))
                    return bdd.Dossiers.Where(d => (!d.Archived)).OrderByDescending(d => d.DateCreation).Take(LONGUEUR).ToList();
                else
                {
                    DOSSIER tempD;
                    if (!sens)
                    {
                        tempD = ObtenirDossierParId(firstDossierId);
                        List<DOSSIER> tempLD = bdd.Dossiers.Where(d => (!d.Archived && d.DateCreation >= tempD.DateCreation && (d.DossierID != firstDossierId))).OrderBy(d => d.DateCreation).Skip(LONGUEUR - 1).Take(LONGUEUR).ToList();
                        if (tempLD != null && tempLD.Count != 0)
                            tempLD = tempLD.OrderByDescending(d => d.DateCreation).ToList();
                        return tempLD;
                    }
                    else
                    {
                        tempD = ObtenirDossierParId(firstDossierId);
                        return bdd.Dossiers.Where(d => (!d.Archived && d.DateCreation <= tempD.DateCreation && d.DossierID != firstDossierId)).OrderByDescending(d => d.DateCreation).Take(LONGUEUR).ToList();

                    }
                }
            }
            else
            {
                if (firstDossierId == ObtenirIdPremierDossier() && sens == false) //code crypté
                {
                    List<DOSSIER> tempLD = null;
                    DOSSIER tempD = ObtenirDossierParId(firstDossierId);
                    int reste = (int)ObtenirNombreDossier() % LONGUEUR;
                    if (reste == 0)
                        tempLD = bdd.Dossiers.Where(d => (d.Archived && d.DateCreation >= tempD.DateCreation && (d.DossierID != firstDossierId))).OrderBy(d => d.DateCreation).Skip(LONGUEUR - 1).Take(LONGUEUR).ToList();
                    else
                        tempLD = bdd.Dossiers.Where(d => (d.Archived && d.DateCreation >= tempD.DateCreation && (d.DossierID != firstDossierId))).OrderBy(d => d.DateCreation).Take(LONGUEUR).ToList();

                    if (tempLD != null && tempLD.Count != 0)
                        tempLD = tempLD.OrderByDescending(d => d.DateCreation).ToList();
                    return tempLD;
                }

                if (String.IsNullOrEmpty(firstDossierId) && (sens == true))
                    return bdd.Dossiers.Where(d => (d.Archived)).OrderByDescending(d => d.DateCreation).Take(LONGUEUR).ToList();
                else
                {
                    DOSSIER tempD;
                    if (!sens)
                    {
                        tempD = ObtenirDossierParId(firstDossierId);
                        List<DOSSIER> tempLD = bdd.Dossiers.Where(d => (d.Archived && d.DateCreation >= tempD.DateCreation && (d.DossierID != firstDossierId))).OrderBy(d => d.DateCreation).Skip(LONGUEUR - 1).Take(LONGUEUR).ToList();
                        if (tempLD != null && tempLD.Count != 0)
                            tempLD = tempLD.OrderByDescending(d => d.DateCreation).ToList();
                        return tempLD;
                    }
                    else
                    {
                        tempD = ObtenirDossierParId(firstDossierId);
                        return bdd.Dossiers.Where(d => (d.Archived && d.DateCreation <= tempD.DateCreation && d.DossierID != firstDossierId)).OrderByDescending(d => d.DateCreation).Take(LONGUEUR).ToList();

                    }
                }

            }
        }

        public int ObtenirNombreDossier()
        {
            List<DOSSIER> Dossiers = bdd.Dossiers.Where(d => !d.Archived).ToList();
            int nombre = 0;
            if (Dossiers != null)
            {
                nombre = Dossiers.Count();
            }

            return nombre;
        }

        /*
 
        * Date du 11 Janvier - @Hn
 
        */


        public String ReduireTaille(String texte, int taille)
        {
            if (!String.IsNullOrEmpty(texte))
            {
                if (texte.Length > taille - 3)
                    return texte.Substring(0, taille - 3) + "...";
                else return texte;
            }

            return null;
        }

        public String GenerationCodeDossier(DateTime dateCreation, char systeme, int lieu)
        {
            String temp = "";


            if (dateCreation.Hour < 10)
                temp = temp + "0" + dateCreation.Hour;
            else temp = temp + dateCreation.Hour;
            temp = temp + systeme;
            if (dateCreation.Month < 10)
                temp = temp + "0" + dateCreation.Month;
            else temp = temp + dateCreation.Month;
            temp = temp + Convert.ToString(dateCreation.Year).Substring(2, 2);
            temp = temp + dateCreation.Minute;
            temp = temp + lieu;
            if (dateCreation.Day < 10)
                temp = temp + "0" + Convert.ToString(dateCreation.Day);
            else temp = temp + Convert.ToString(dateCreation.Day);
            temp = temp + dateCreation.Second;
            if (dateCreation.Millisecond < 10)
                temp = temp + "00" + Convert.ToString(dateCreation.Millisecond);
            else if (dateCreation.Millisecond < 100)
                temp = temp + "0" + Convert.ToString(dateCreation.Millisecond);
            else temp = temp + Convert.ToString(dateCreation.Millisecond);

            return temp;
        }



        /*
 
         * Date du 12 Janvier - @Hn
 
         */

        public String ObtenirIdDernierDossier()
        {
            if (ObtenirNombreDossier() > 0)
                return bdd.Dossiers.OrderByDescending(d => d.DateCreation).ToList().First().DossierID;
            else return null;
        }

        public String ObtenirIdPremierDossier()
        {
            if (ObtenirNombreDossier() > 0)
                return bdd.Dossiers.OrderBy(d => d.DateCreation).ToList().First().DossierID;
            else return null;
        }

        public void CreerGroupeMaladie(GROUPEMALADIE groupe)
        {
            if (groupe != null)
            {
                groupe.DateCreation = DateTime.Now;
                groupe.IsDeleted = false;
                groupe.IsModified = false;
                groupe.DateSuppression = DateTime.Now;
                groupe.DateModification = DateTime.Now;
                groupe.IntituleGroupe = CRYPTAGE.StringHelpers.Encrypt(groupe.IntituleGroupe);
                groupe.GroupeMaladieID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(groupe.DateCreation, "GROUPEMALADIE", 'T', 1));
                bdd.GroupeMaladies.Add(groupe);
                bdd.SaveChanges();
            }
        }


        public void CreerMaladie(MALADIE maladie)
        {
            if (maladie != null)
            {
                maladie.DateCreation = DateTime.Now;
                maladie.IsDeleted = false;
                maladie.IsModified = false;
                maladie.DateModification = DateTime.Now;
                maladie.DateSuppression = DateTime.Now;
                maladie.Intitule = CRYPTAGE.StringHelpers.Encrypt(maladie.Intitule);
                maladie.TypeMaladie = ObtenirGroupeMaladieParId(maladie.TypeMaladie.GroupeMaladieID);
                maladie.MaladieID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(maladie.DateCreation, "MALADIE", 'T', 1));
                bdd.Maladies.Add(maladie);
                bdd.SaveChanges();
            }
        }

        public List<GROUPEMALADIE> ObtenirTousLesGroupesMaladies()
        {
            return bdd.GroupeMaladies.Where(g => g.IsDeleted == false).ToList();
        }

        public List<MALADIE> ObtenirToutesLesMaladies()
        {
            return bdd.Maladies.Where(m => m.IsDeleted == false).GroupBy(m => m.TypeMaladie).SelectMany(e => e).ToList();
        }

        public List<MALADIE> ObtenirToutesLesMaladiesDunGroupe(String idgroupe)
        {
            return bdd.Maladies.Where(m => m.TypeMaladie.GroupeMaladieID == idgroupe && m.IsDeleted == false).ToList();
        }

        public void ArchiverDossierParId(String idDossier, String idUser)
        {
            DOSSIER tempDossier = ObtenirDossierParId(idDossier);
            DateTime tempDate = DateTime.Now;
            MODIFICATION tempModif = new MODIFICATION();

            tempModif.Auteur = ObtenirUtilisateurParId(idUser);
            tempModif.Dossier = tempDossier;
            if (tempModif.Dossier != null && tempModif.Auteur != null)
            {
                tempModif.DateModification = tempDate;

                if (tempDossier.Archived != true)
                {
                    EnregistrerModification(tempModif);
                    tempDossier.Archived = true;
                    tempDossier.DateArchivage = tempDate;
                    tempDossier.IsModified = true;
                    tempDossier.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                }
            }



        }

        public void EnregistrerModification(MODIFICATION modification)
        {
            modification.ModificationID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "MODIFICATION", 'T', 1));
            bdd.Modifications.Add(modification);
            bdd.SaveChanges();
        }

        /*
 
        * Date du 13 Janvier - @Hn
 
        */
        public List<RENDEZVOUS> ObtenirTousLesRdv(String idspecialiste, int? etatRdv, DateTime? dateRdv)
        {
            if (!String.IsNullOrEmpty(idspecialiste))
            {
                if (etatRdv.HasValue)
                {
                    if ((int)etatRdv == 0)
                    {
                        if (dateRdv.HasValue)
                        {
                            DateTime tempDate = (DateTime)dateRdv.Value.Date.AddDays(1);
                            return bdd.RendezVous.Where(r => r.Horaire >= (DateTime)dateRdv.Value.Date && r.Horaire < tempDate && r.Recu == true && r.Emetteur.UtilisateurID == idspecialiste).OrderBy(r => r.Horaire).ToList();
                        }
                        else return bdd.RendezVous.Where(r => r.Recu == true && r.Emetteur.UtilisateurID == idspecialiste).OrderBy(r => r.Horaire).ToList();

                    }
                    if ((int)etatRdv == 1)
                    {
                        if (dateRdv.HasValue)
                        {
                            DateTime tempDate = (DateTime)dateRdv.Value.Date.AddDays(1);
                            return bdd.RendezVous.Where(r => r.Horaire >= (DateTime)dateRdv.Value.Date && r.Horaire < tempDate && r.Manque == true && r.Emetteur.UtilisateurID == idspecialiste).OrderBy(r => r.Horaire).ToList();
                        }
                        else return bdd.RendezVous.Where(r => r.Manque == true && r.Emetteur.UtilisateurID == idspecialiste).OrderBy(r => r.Horaire).ToList();

                    }
                    if ((int)etatRdv == 2)
                    {
                        if (dateRdv.HasValue)
                        {
                            DateTime tempDate = (DateTime)dateRdv.Value.Date.AddDays(1);
                            return bdd.RendezVous.Where(r => r.Horaire >= (DateTime)dateRdv.Value.Date && r.Horaire < tempDate && r.Actif == false && r.Emetteur.UtilisateurID == idspecialiste).OrderBy(r => r.Horaire).ToList();
                        }
                        else return bdd.RendezVous.Where(r => r.Actif == false && r.Emetteur.UtilisateurID == idspecialiste).OrderBy(r => r.Horaire).ToList();

                    }

                    return null;
                }
                else
                {
                    if (dateRdv.HasValue)
                    {
                        DateTime tempDate = (DateTime)dateRdv.Value.Date.AddDays(1);
                        return bdd.RendezVous.Where(r => r.Horaire >= (DateTime)dateRdv.Value.Date && r.Horaire < tempDate && r.Emetteur.UtilisateurID == idspecialiste).OrderBy(r => r.Horaire).ToList();
                    }
                    else return bdd.RendezVous.Where(r => r.Emetteur.UtilisateurID == idspecialiste).OrderBy(r => r.Horaire).ToList();
                }

            }
            else
            {
                if (etatRdv.HasValue)
                {
                    //0 pour recu 1 pour manque 2 pour annule
                    if ((int)etatRdv == 0)
                    {
                        if (dateRdv.HasValue)
                        {
                            DateTime tempDate = (DateTime)dateRdv.Value.Date.AddDays(1);
                            return bdd.RendezVous.Where(r => r.Horaire >= (DateTime)dateRdv.Value.Date && r.Horaire < tempDate && r.Recu == true).OrderBy(r => r.Horaire).ToList();
                        }
                        else return bdd.RendezVous.Where(r => r.Recu == true).OrderBy(r => r.Horaire).ToList();

                    }
                    if ((int)etatRdv == 1)
                    {
                        if (dateRdv.HasValue)
                        {
                            DateTime tempDate = (DateTime)dateRdv.Value.Date.AddDays(1);
                            return bdd.RendezVous.Where(r => r.Horaire >= (DateTime)dateRdv.Value.Date && r.Horaire < tempDate && r.Manque == true).OrderBy(r => r.Horaire).ToList();
                        }
                        else return bdd.RendezVous.Where(r => r.Manque == true).OrderBy(r => r.Horaire).ToList();

                    }
                    if ((int)etatRdv == 2)
                    {
                        if (dateRdv.HasValue)
                        {
                            DateTime tempDate = (DateTime)dateRdv.Value.Date.AddDays(1);
                            return bdd.RendezVous.Where(r => r.Horaire >= (DateTime)dateRdv.Value.Date && r.Horaire < tempDate && r.Actif == false).OrderBy(r => r.Horaire).ToList();
                        }
                        else return bdd.RendezVous.Where(r => r.Actif == false).OrderBy(r => r.Horaire).ToList();

                    }
                    return null;
                }
                else
                {
                    if (dateRdv.HasValue)
                    {
                        DateTime tempDate = (DateTime)dateRdv.Value.Date.AddDays(1);
                        return bdd.RendezVous.Where(r => r.Horaire >= (DateTime)dateRdv.Value.Date && r.Horaire < tempDate).OrderBy(r => r.Horaire).ToList();
                    }
                    else return bdd.RendezVous.OrderBy(r => r.Horaire).ToList();

                }
            }

        }


        /*
 
        * Date du 15 Janvier - @Hn
 
        */
        public MaladieVM ConvertirMaladieMaladieVM(MALADIE maladie)
        {
            MaladieVM mvm = null;
            if (maladie != null)
            {
                mvm = new MaladieVM();
                mvm.Id = maladie.MaladieID;
                mvm.NomMaladie = maladie.Intitule;
            }

            return mvm;
        }

        public MALADIE ObtenirMaladieParId(String idmaladie)
        {
            return bdd.Maladies.FirstOrDefault(m => m.MaladieID == idmaladie);
        }

        public UTILISATEUR ObtenirUtilisateurAvecIdentifiants(string login, string password)
        {
            List<UTILISATEUR> listeU = ObtenirTousLesUtilisateurs();
            if (listeU != null)
                return listeU.FirstOrDefault(u => u.Login == CRYPTAGE.StringHelpers.Encrypt(login) && u.Password == CRYPTAGE.StringHelpers.Encrypt(password));
            return null;
        }


        /*
 
        * Date du 18 Janvier - @Hn
 
        */
        public PERSONNE ObtenirPersonneParId(String personneID)
        {
            return bdd.Personnes.FirstOrDefault(p => p.PersonneID == personneID);
        }


        /*
 
        * Date du 19 Janvier - @Hn
 
        */
        public PARAMETRE ObtenirParametreParId(String parametreID)
        {
            return bdd.Parametres.FirstOrDefault(p => p.ParametreID == parametreID);
        }

        public ParametreVM2 ConvertirParametreParametreVM2(PARAMETRE parametre)
        {
            ParametreVM2 temp = null;
            if (parametre != null)
            {
                temp = new ParametreVM2();
                temp.Avis = CRYPTAGE.StringHelpers.Decrypt(parametre.Avis);
                temp.DossierID = parametre.Dossier.DossierID;
                temp.Id = parametre.ParametreID;
                temp.ListeParametres = RecupererTousLesParametresDossier(parametre.Dossier);
                temp.Patient = CRYPTAGE.StringHelpers.Decrypt(parametre.Dossier.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(parametre.Dossier.Patient.Prenom);
                temp.Poids = (float)parametre.Poids;
                temp.Pouls = (float)parametre.Pouls;
                temp.Temperature = (float)parametre.Temperature;
                temp.Tension = parametre.Tension;
                temp.CodeDossier = CRYPTAGE.StringHelpers.Decrypt(parametre.Dossier.Code);
                if (parametre.Dossier.Archived) temp.isArchived = true;

                if (temp.ListeParametres != null)
                {
                    foreach (var p in temp.ListeParametres)
                        if (p != null)
                        {
                            p.Avis = CRYPTAGE.StringHelpers.Decrypt(p.Avis);
                            p.Avis = ReduireTaille(p.Avis, 90);
                        }
                }

            }
            return temp;

        }


        /*
         * Date du 23 Jan 2018 - @Hn
         */
        public List<UTILISATEUR> ObtenirTousLesUtilisateurs()
        {
            return bdd.Utilisateurs.Where(u => u.Actif == true).ToList();
        }
        public List<TYPEGROUPE> ObtenirTousLesTypesDeGC()
        {
            return bdd.TypeGroupes.ToList();
        }
        public TYPEGROUPE ObtenirTypeGroupeParId(String idType)
        {
            return bdd.TypeGroupes.FirstOrDefault(t => t.TypeGroupeID == idType);
        }
        public String EnregistrerGroupeCible(GROUPECIBLE groupeCible)
        {
            GROUPECIBLE tempGC = new GROUPECIBLE();
            tempGC.Intitule = groupeCible.Intitule;
            tempGC.Objet = groupeCible.Objet;
            tempGC.Type = groupeCible.Type;
            tempGC.DateCreationGroupe = groupeCible.DateCreationGroupe;
            tempGC.DateClotureGroupe = groupeCible.DateClotureGroupe;
            tempGC.DateArchivageGroupe = groupeCible.DateArchivageGroupe;
            tempGC.Createur = ObtenirUtilisateurParId(groupeCible.Createur.UtilisateurID);
            tempGC.Archived = groupeCible.Archived;
            tempGC.Closed = groupeCible.Closed;
            tempGC.Administrateur = ObtenirUtilisateurParId(groupeCible.Administrateur.UtilisateurID);

            tempGC.Code = CRYPTAGE.StringHelpers.Encrypt(GenerationCodeGroupe(tempGC.DateCreationGroupe, 'T', 1));
            tempGC.GroupeCibleID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(tempGC.DateCreationGroupe, "GROUPECIBLE", 'T', 1));
            tempGC.IsDeleted = false;
            tempGC.IsModified = false;
            tempGC.DateModification = tempGC.DateCreationGroupe;
            tempGC.DateSuppression = tempGC.DateCreationGroupe;
            bdd.GroupeCibles.Add(tempGC);
            bdd.SaveChanges();

            return tempGC.GroupeCibleID;

        }

        public List<GROUPECIBLE> ObtenirTousLesGroupeCibles()
        {
            return bdd.GroupeCibles.ToList();
        }

        public GROUPECIBLE ObtenirGroupeCibleParId(String idGroupe)
        {
            return bdd.GroupeCibles.FirstOrDefault(g => g.GroupeCibleID == idGroupe);
        }

        public String GenerationCodeGroupe(DateTime dateCreation, char systeme, int lieu)
        {
            String temp = "G";
            temp = temp + dateCreation.Hour;
            temp = temp + systeme;
            if (dateCreation.Month < 10)
                temp = temp + "0" + dateCreation.Month;
            else temp = temp + dateCreation.Month;
            temp = temp + Convert.ToString(dateCreation.Year).Substring(2, 2);
            temp = temp + dateCreation.Minute;
            temp = temp + lieu;
            if (dateCreation.Day < 10)
                temp = temp + "0" + Convert.ToString(dateCreation.Day);
            else temp = temp + Convert.ToString(dateCreation.Day);
            temp = temp + dateCreation.Second;

            return temp;
        }

        public GroupeCibleVM2 ConvertirGroupeCibleGroupeCibleVM2(GROUPECIBLE groupeCible)
        {
            GroupeCibleVM2 groupeCibleVM2 = null;

            if (groupeCible.Type != null && groupeCible.Administrateur != null)
            {
                groupeCibleVM2 = new GroupeCibleVM2();
                groupeCibleVM2.Id = groupeCible.GroupeCibleID;
                groupeCibleVM2.Code = CRYPTAGE.StringHelpers.Decrypt(groupeCible.Code);
                if (groupeCible.Code.Length >= 4) groupeCibleVM2.Code = getCodeFormat(groupeCibleVM2.Code);
                groupeCibleVM2.Intitule = groupeCible.Intitule;
                groupeCibleVM2.Objet = groupeCible.Objet;
                groupeCibleVM2.DateCreationGroupe = ConvertirDateChaine(groupeCible.DateCreationGroupe);
                groupeCibleVM2.DateClotureGroupe = groupeCible.DateClotureGroupe;

                groupeCibleVM2.TypeGroupe = new TYPEGROUPE();
                groupeCibleVM2.TypeGroupe.TypeGroupeID = groupeCible.Type.TypeGroupeID;
                groupeCibleVM2.TypeGroupe.Objet = CRYPTAGE.StringHelpers.Decrypt(groupeCible.Type.Objet);

                groupeCibleVM2.Admin = new UtilisateurVM2();
                groupeCibleVM2.Admin.Id = groupeCible.Administrateur.UtilisateurID;
                groupeCibleVM2.Admin.Nom = CRYPTAGE.StringHelpers.Decrypt(groupeCible.Administrateur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(groupeCible.Administrateur.Personne.Prenom);
                groupeCibleVM2.Closed = groupeCible.Closed;
                groupeCibleVM2.Archived = groupeCible.Archived;
                if (groupeCible.Archived) groupeCibleVM2.DateArchivage = ConvertirDateChaine(groupeCible.DateArchivageGroupe);

            }

            return groupeCibleVM2;

        }

        public List<LIAISONDOSSIERGROUPECIBLE> ObtenirToutesLesLiaisonsDunGroupeParId(String idGroupe, int etatLiaison)
        {
            if (etatLiaison == 1)
                return bdd.LiaisonDossierGroupes.Where(l => l.GC.GroupeCibleID == idGroupe && l.Actif == true).ToList();
            else
                if (etatLiaison == 0)
                return bdd.LiaisonDossierGroupes.Where(l => l.GC.GroupeCibleID == idGroupe && l.Actif == false).ToList();
            else
                return bdd.LiaisonDossierGroupes.Where(l => l.GC.GroupeCibleID == idGroupe).ToList();

        }

        public List<GROSSESSE> ObtenirInfosGrossesseParLiaison(String idLiaison)
        {
            return bdd.Grossesses.Where(g => g.Maternite.LiaisonDossierGroupeCibleID == idLiaison).ToList();
        }

        public MembreGroupeCible ConvertirGrossesseMembreGroupeCible(GROSSESSE grossesse)
        {
            MembreGroupeCible mgc = null;
            if (grossesse != null)
            {
                mgc = new MembreGroupeCible();
                mgc.LiaisonId = grossesse.Maternite.LiaisonDossierGroupeCibleID;
                mgc.CodeDosser = CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Code);
                mgc.DateIntegration = ConvertirDateChaine(grossesse.Maternite.DateIntegration);
                mgc.DossierId = grossesse.Maternite.Dossier.DossierID;
                mgc.GrossesseId = grossesse.GrossesseID;
                mgc.Id = grossesse.Maternite.LiaisonDossierGroupeCibleID;
                mgc.NomPatient = CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(grossesse.Maternite.Dossier.Patient.Prenom);
                mgc.Specialiste = CRYPTAGE.StringHelpers.Decrypt(grossesse.MedecinTraitant.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(grossesse.MedecinTraitant.Personne.Prenom);
                mgc.EtatGrossesse = GetEtatGrossesse(grossesse);

            }

            return mgc;
        }

        /*
         * Date du 24 Jan 2018 - @Hn
         */
        public UtilisateurVM2 ConvertirUtilisateurUtilisateurVM2(UTILISATEUR user)
        {
            UtilisateurVM2 temp = null;
            if (user != null)
            {
                temp = new UtilisateurVM2();
                temp.Id = user.UtilisateurID;
                temp.Nom = CRYPTAGE.StringHelpers.Decrypt(user.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(user.Personne.Prenom);
            }

            return temp;
        }

        public void ModifierGroupeCible(GROUPECIBLE groupe)
        {
            if (groupe != null && groupe.Administrateur != null && groupe.Type != null)
            {
                GROUPECIBLE temp = ObtenirGroupeCibleParId(CRYPTAGE.StringHelpers.Encrypt(groupe.GroupeCibleID));
                temp.Objet = groupe.Objet;
                temp.Intitule = groupe.Intitule;
                temp.DateClotureGroupe = groupe.DateClotureGroupe;
                temp.Administrateur = ObtenirUtilisateurParId(groupe.Administrateur.UtilisateurID);
                temp.Type = ObtenirTypeGroupeParId(groupe.Type.TypeGroupeID);
                temp.IsModified = true;
                temp.DateModification = DateTime.Now;

                bdd.SaveChanges();
            }
        }

        public List<SearchDossier> ObtenirListeDesPersonnesAdmissiblesAuGroupeFemmeEnceinte(GROUPECIBLE groupe)
        {
            List<SearchDossier> listeSearchDossier = null;

            List<LIAISONDOSSIERGROUPECIBLE> tempListeLiaisonGCDossierActives = ObtenirToutesLesLiaisonsDunGroupeParId(groupe.GroupeCibleID, 1);
            if (tempListeLiaisonGCDossierActives != null)
            {
                //Liste des personnes déjà présentes dans le groupe
                List<DOSSIER> tempListeDossierPresentGroupe = new List<DOSSIER>();
                foreach (var lgcd in tempListeLiaisonGCDossierActives)
                {

                    if (lgcd != null && lgcd.Dossier != null && lgcd.Dossier.Archived == false && lgcd.Dossier.Patient.Sexe == 1)
                    {
                        tempListeDossierPresentGroupe.Add(lgcd.Dossier);
                    }
                }

                //Liste des personnes présentes en bd
                List<DOSSIER> tempListeDossierPresentBD = ObtenirTousLesDossiers(false);

                //Opération de filtrage
                if (tempListeDossierPresentBD != null)
                {
                    listeSearchDossier = new List<SearchDossier>();
                    foreach (var d in tempListeDossierPresentBD)
                    {
                        if (d != null && d.Patient.Sexe == 1)
                            if (!VerifierPresenceDossierListeDossier(tempListeDossierPresentGroupe, d))
                                listeSearchDossier.Add(ConvertirDossierSearchDossier(d));
                    }
                }

            }

            return listeSearchDossier;

        }

        public List<DOSSIER> ObtenirTousLesDossiers(Boolean IsArchived)
        {
            return bdd.Dossiers.Where(d => d.Archived == IsArchived).ToList();
        }

        public Boolean VerifierPresenceDossierListeDossier(List<DOSSIER> liste, DOSSIER dossier)
        {
            bool verif = false;
            if (liste != null)
            {
                foreach (var d in liste)
                {
                    if (d != null && d.Code == dossier.Code)
                    {
                        verif = true;
                        break;
                    }
                }
            }

            return verif;
        }

        public Boolean VerifierPresenceActiveDossierGroupe(DOSSIER dossier, GROUPECIBLE groupe)
        {
            if (groupe != null && dossier != null)
            {
                LIAISONDOSSIERGROUPECIBLE ldgc = bdd.LiaisonDossierGroupes.FirstOrDefault(l => l.Dossier.DossierID == dossier.DossierID && l.GC.GroupeCibleID == groupe.GroupeCibleID);
                if (ldgc != null && ldgc.Actif)
                    return true;
                else return false;
            }
            return false;
        }

        public void EnregistrerLiaisonDossierGroupeCible(LIAISONDOSSIERGROUPECIBLE ldgc)
        {
            LIAISONDOSSIERGROUPECIBLE temp_ldgc = new LIAISONDOSSIERGROUPECIBLE();
            if (ldgc.Dossier != null && ldgc.GC != null)
            {
                temp_ldgc.Actif = ldgc.Actif;
                temp_ldgc.DateDepart = ldgc.DateIntegration;
                temp_ldgc.DateIntegration = ldgc.DateIntegration;
                temp_ldgc.Dossier = ObtenirDossierParId(ldgc.Dossier.DossierID);
                temp_ldgc.GC = ObtenirGroupeCibleParId(ldgc.GC.GroupeCibleID);
                temp_ldgc.IsDeleted = false;
                temp_ldgc.IsModified = false;
                temp_ldgc.DateSuppression = DateTime.Now;
                temp_ldgc.DateModification = DateTime.Now;
                temp_ldgc.LiaisonDossierGroupeCibleID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "LIAISONDOSSIERGROUPECIBLE", 'T', 1));

                bdd.LiaisonDossierGroupes.Add(temp_ldgc);
                bdd.SaveChanges();

                //Enregistrement de la grossesse correspondante
                GROSSESSE grossesse = new GROSSESSE();
                grossesse.DateEnregistrement = temp_ldgc.DateIntegration;
                grossesse.DateResultat = temp_ldgc.DateIntegration;
                grossesse.Maternite = ObtenirLiaisonDossierGroupeParId(temp_ldgc.LiaisonDossierGroupeCibleID);
                grossesse.MedecinTraitant = ObtenirGroupeCibleParCode(grossesse.Maternite.GC.Code).Administrateur;
                grossesse.Resultat = 0;
                grossesse.IsDeleted = false;
                grossesse.IsModified = false;
                grossesse.DateSuppression = DateTime.Now;
                grossesse.DateModification = DateTime.Now;
                grossesse.GrossesseID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "GROSSESSE", 'T', 1));

                bdd.Grossesses.Add(grossesse);
                bdd.SaveChanges();

            }
        }

        public GROUPECIBLE ObtenirGroupeCibleParCode(String code)
        {
            return bdd.GroupeCibles.FirstOrDefault(g => g.Code == code);
        }

        public List<LIAISONDOSSIERGROUPECIBLE> ObtenirLesGroupesCiblesDunPatient(String DossierId)
        {
            return bdd.LiaisonDossierGroupes.Where(ld => ld.Dossier.DossierID == DossierId).ToList();
        }

        public LIAISONDOSSIERGROUPECIBLE ObtenirLiaisonDossierGroupeParId(String id)
        {
            return bdd.LiaisonDossierGroupes.FirstOrDefault(g => g.LiaisonDossierGroupeCibleID == id);
        }

        public GroupeCibleVM3 ConvertirGroupeCibleGroupeCibleVM3(GROUPECIBLE groupe)
        {
            GroupeCibleVM3 temp = null;
            if (groupe != null)
            {
                temp = new GroupeCibleVM3();
                temp.Id = groupe.GroupeCibleID;
                temp.Type = CRYPTAGE.StringHelpers.Decrypt(groupe.Type.Objet);
                temp.Intitule = groupe.Intitule;
                temp.DateCreationGroupe = ConvertirDateChaine(groupe.DateCreationGroupe);
                if (groupe.Closed) temp.DateClotureGroupe = ConvertirDateChaine(groupe.DateClotureGroupe);
                else temp.DateClotureGroupe = "-";
                temp.Code = CRYPTAGE.StringHelpers.Decrypt(groupe.Code);
                if (temp.Code.Length >= 4) temp.Code = getCodeFormat(temp.Code);
                temp.Administrateur = CRYPTAGE.StringHelpers.Decrypt(groupe.Administrateur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(groupe.Administrateur.Personne.Prenom);
                temp.Taille = ObtenirTailleGroupe(groupe);
            }

            return temp;
        }

        public int ObtenirTailleGroupe(GROUPECIBLE groupe)
        {
            List<GROSSESSE> tempL = bdd.Grossesses.Where(g => g.Maternite.GC.Code == groupe.Code).ToList();
            if (tempL == null) return 0;
            else return tempL.Count;
        }

        public List<GROUPECIBLE> ObtenirTousLesGroupesCibles(int IsArchived)
        {
            if (IsArchived == 0)
                return bdd.GroupeCibles.Where(g => g.Archived == false).ToList();
            else
                if (IsArchived == 1)
                return bdd.GroupeCibles.Where(g => g.Archived == true).ToList();
            else
                return bdd.GroupeCibles.ToList();
        }

        public GROSSESSE ObtenirGrossesseParId(String idgrossesse)
        {
            return bdd.Grossesses.FirstOrDefault(g => g.GrossesseID == idgrossesse);
        }

        public List<VISITEPRENATALE> ObtenirToutesLesVisitesPrenatalesGrossesse(GROSSESSE grossesse)
        {
            if (grossesse != null)
            {
                return bdd.VisitePrenatales.Where(v => v.Grossesse.GrossesseID == grossesse.GrossesseID).ToList();
            }
            return null;
        }

        public String GetEtatGrossesse(GROSSESSE grossesse)
        {
            if (grossesse != null)
            {
                if (grossesse.Resultat == 0) return "En cours";
                else
                    if (grossesse.Resultat == 2) return "Grossesse à terme | Accouchement normal";
                else
                        if (grossesse.Resultat == 1) return "Grossesse à terme | Accouchement par césarienne";
                else
                            if (grossesse.Resultat == -1) return "Grossesse à terme | Enfant(s) décédé(s) à la naissance";
                else
                                if (grossesse.Resultat == -2) return "Grossesse interrompue | Fausse couche";
                else
                                    if (grossesse.Resultat == -3) return "Grossesse à terme | Décès de la mère";
                else
                                        if (grossesse.Resultat == -4) return "Grossesse à terme | Décès de la mère et de(s) l'enfant(s)";

            }

            return "";
        }

        public SampleVisitePrenatale ConvertirVisitePrenataleSampleVisitePrenatale(VISITEPRENATALE visite)
        {
            SampleVisitePrenatale temp = null;
            if (visite != null && visite.Grossesse != null && visite.Rdv != null)
            {
                temp = new SampleVisitePrenatale();
                temp.Id = visite.VisitePrenataleID;
                temp.Commentaire = visite.Observation;
                temp.Date = visite.Rdv.Horaire;
                temp.DateVisite = ConvertirDateChaine(visite.Rdv.Horaire);
                temp.Specialiste = CRYPTAGE.StringHelpers.Decrypt(visite.Rdv.Emetteur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(visite.Rdv.Emetteur.Personne.Prenom);
                if (visite.Rdv.Recu == true) temp.EtatVisite = 1;
                else
                    if (visite.Rdv.Recu == false && visite.Rdv.Manque == true) temp.EtatVisite = 0;
                else
                        if (visite.Rdv.Recu == false && visite.Rdv.Manque == false && visite.Rdv.Actif == true)
                    temp.EtatVisite = -1;
                else temp.EtatVisite = -2;
            }

            return temp;
        }

        public String EnregistrerVisitePrenatale(VISITEPRENATALE visite)
        {
            if (visite != null && visite.Grossesse != null && visite.Rdv != null)
            {
                VISITEPRENATALE temp = new VISITEPRENATALE
                {
                    Grossesse = ObtenirGrossesseParId(visite.Grossesse.GrossesseID),
                    Observation = "",
                    Rdv = ObtenirRendezVousParId(visite.Rdv.RendezVousID),
                    IsDeleted = false,
                    IsModified = false,
                    DateSuppression = DateTime.Now,
                    DateModification = DateTime.Now,
                    VisitePrenataleID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "VISITEPRENATALE", 'T', 1))
                };

                bdd.VisitePrenatales.Add(temp);
                bdd.SaveChanges();

                return temp.VisitePrenataleID;
            }
            return null;
        }

        /*
 
         * Date du 26 Janvier - @Hn
 
         */
        public TraitementVM3 ConvertirTraitementTraitementVM3(TRAITEMENT traitement)
        {
            if (traitement != null)
            {
                TraitementVM3 traitementVM3 = new TraitementVM3();
                traitementVM3.Id = traitement.TraitementID;
                traitementVM3.DossierID = traitement.Diagnostic.Dossier.DossierID;
                traitementVM3.DiagnosticId = traitement.Diagnostic.DiagnosticId;
                traitementVM3.Traitement = CRYPTAGE.StringHelpers.Decrypt(traitement.Recommandation);
                traitementVM3.Diagnostic = CRYPTAGE.StringHelpers.Decrypt(traitement.Diagnostic.Avis);
                traitementVM3.NomPatient = CRYPTAGE.StringHelpers.Decrypt(traitement.Diagnostic.Dossier.Patient.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(traitement.Diagnostic.Dossier.Patient.Prenom);
                traitementVM3.SpecialisteTraitement = CRYPTAGE.StringHelpers.Decrypt(traitement.Specialiste.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(traitement.Specialiste.Personne.Prenom);
                traitementVM3.SpecialisteDiagnostic = CRYPTAGE.StringHelpers.Decrypt(traitement.Diagnostic.Auteur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(traitement.Diagnostic.Auteur.Personne.Prenom);

                List<DIAGNOSTIC> tempListeD = RecupererTousLesDiagnosticDossier(traitement.Diagnostic.Dossier);
                if (tempListeD != null)
                {
                    List<TRAITEMENT> tempListeT = new List<TRAITEMENT>();
                    foreach (var d in tempListeD)
                    {
                        tempListeT.AddRange(RecupererTousLesTraitementsDiagnostic(d));
                    }
                    if (tempListeT != null)
                    {
                        traitementVM3.Traitements = new List<TraitementVM>();
                        foreach (var t in tempListeT)
                        {
                            t.Recommandation = ReduireTaille(t.Recommandation, 100);
                            traitementVM3.Traitements.Add(ConvertirTraitementTraitementVM(t, true));
                        }
                    }
                }


                return traitementVM3;
            }

            return null;
        }


        /*
 
        * Date du 26 Janvier - @Hn
 
        */

        public void ModifierGrossesse(GROSSESSE grossesse)
        {
            if (grossesse != null)
            {
                GROSSESSE temp = ObtenirGrossesseParId(grossesse.GrossesseID);
                if (temp != null)
                {
                    temp.DateResultat = grossesse.DateResultat;
                    temp.Resultat = grossesse.Resultat;
                    temp.MedecinTraitant = grossesse.MedecinTraitant;
                    temp.IsModified = true;
                    temp.DateModification = DateTime.Now;
                    if (temp.MedecinTraitant != null)
                        bdd.SaveChanges();
                }
            }
        }

        public void ModifierLiaisonDossierGroupe(LIAISONDOSSIERGROUPECIBLE liaisonDossierGC)
        {
            if (liaisonDossierGC != null)
            {
                LIAISONDOSSIERGROUPECIBLE temp = ObtenirLiaisonDossierGroupeParId(liaisonDossierGC.LiaisonDossierGroupeCibleID);
                if (temp != null)
                {
                    temp.DateDepart = liaisonDossierGC.DateDepart;
                    temp.Actif = liaisonDossierGC.Actif;
                    temp.IsModified = true;
                    temp.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                }
            }
        }

        /*
         * Date du 30 Jan 2018 - @Hn
         */
        public String GenererCle(DateTime dateEnregistrement, String nomTable, char lieuLogique, int lieuPhysique)
        {
            String temp = "";
            String cle = getCleTable(nomTable);

            temp = temp + cle.Substring(1, 1);
            if (dateEnregistrement.Hour < 10)
                temp = temp + "0" + dateEnregistrement.Hour;
            else temp = temp + dateEnregistrement.Hour;
            temp = temp + lieuLogique;
            if (dateEnregistrement.Month < 10)
                temp = temp + "0" + dateEnregistrement.Month;
            else temp = temp + dateEnregistrement.Month;
            temp = temp + Convert.ToString(dateEnregistrement.Year).Substring(0, 2);
            temp = temp + cle.Substring(2, 1);
            if (dateEnregistrement.Minute < 10)
                temp = temp + "0" + dateEnregistrement.Minute;
            else temp = temp + dateEnregistrement.Minute;
            if (lieuPhysique < 10)
                temp = temp + "0" + Convert.ToString(lieuPhysique);
            else temp = temp + Convert.ToString(lieuPhysique);
            temp = temp + Convert.ToString(dateEnregistrement.Year).Substring(2, 2);
            if (dateEnregistrement.Day < 10)
                temp = temp + "0" + Convert.ToString(dateEnregistrement.Day);
            else temp = temp + Convert.ToString(dateEnregistrement.Day);
            if (dateEnregistrement.Second < 10)
                temp = temp + "0" + Convert.ToString(dateEnregistrement.Second);
            else temp = temp + Convert.ToString(dateEnregistrement.Second);
            temp = temp + cle.Substring(0, 1);
            if (dateEnregistrement.Millisecond < 10)
                temp = temp + "00" + Convert.ToString(dateEnregistrement.Millisecond);
            else if (dateEnregistrement.Millisecond < 100)
                temp = temp + "0" + Convert.ToString(dateEnregistrement.Millisecond);
            else temp = temp + Convert.ToString(dateEnregistrement.Millisecond);

            return temp;
        }

        public String getCleTable(String nomTable)
        {
            CLETABLE temp = bdd.CleTables.FirstOrDefault(t => t.NomTable == nomTable);
            if (temp != null) return temp.DesignationTable;
            else return "";
        }

        public String getCodeFormat(String code)
        {
            if (code.Length >= 4)
            {
                String temp = "";
                int i = 0;
                while (i <= code.Length - 4)
                {
                    temp = temp + code.Substring(i, 4) + " ";
                    i = i + 4;
                }

                if (code.Length >= i)
                {
                    temp = temp + code.Substring(i);
                }

                code = temp;
                if (code.EndsWith("-")) { code = temp.Remove(temp.Length - 1); }
            }

            return code;
        }


        /*
         * 01 Fev 2018 - @Hn
         */

        public void ModifierDossier(DOSSIER dossier, string UtilisateurID)
        {
            if (dossier != null && ObtenirUtilisateurParId(UtilisateurID) != null)
            {
                DOSSIER temp = ObtenirDossierParId(dossier.DossierID);
                if (temp != null)
                {
                    temp.PenseBete = dossier.PenseBete;
                    temp.DateModification = DateTime.Now;
                    temp.IsModified = true;

                    MODIFICATION modif = new MODIFICATION
                    {
                        Auteur = ObtenirUtilisateurParId(UtilisateurID),
                        DateModification = DateTime.Now,
                        Dossier = temp,
                        ModificationID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "MODIFICATION", 'T', 1))
                    };
                    bdd.Modifications.Add(modif);
                    bdd.SaveChanges();
                }
            }
        }


        /*
         * 02 Fev 2018 - @Hn
         */
        public String NettoyerChaine(String chaine)
        {
            String[] ordures = { "-", ".", "\\", "|", "_", " " };
            if (String.IsNullOrEmpty(chaine))
                return chaine;
            else
            {
                foreach (var c in ordures)
                {
                    chaine = chaine.Replace(c, "");
                }
                return chaine;
            }


        }

        public List<DOSSIER> ObtenirListeDossierParCode(String code)
        {
            List<DOSSIER> tempLD = bdd.Dossiers.Where(d => !d.Archived).ToList();
            List<DOSSIER> tempLDresult = new List<DOSSIER>();
            foreach (var d in tempLD)
            {
                if (CRYPTAGE.StringHelpers.Decrypt(d.Code).Contains(code))
                {
                    tempLDresult.Add(d);
                }
            }
            return tempLDresult;
        }

        public ROLE ObtenirRoleParId(String roleID)
        {
            return bdd.Roles.FirstOrDefault(r => r.RoleID == roleID);
        }

        public String EnregistrerUtilisateur(UTILISATEUR utilisateur)
        {
            if (String.IsNullOrEmpty(utilisateur.UtilisateurID) || String.IsNullOrWhiteSpace(utilisateur.UtilisateurID))
            {
                UTILISATEUR user = new UTILISATEUR
                {
                    Actif = true,
                    DateCreation = DateTime.Now,
                    Fonction = CRYPTAGE.StringHelpers.Encrypt(utilisateur.Fonction),
                    Login = CRYPTAGE.StringHelpers.Encrypt(utilisateur.Login),
                    Personne = ObtenirPersonneParId(utilisateur.Personne.PersonneID),
                    Role = ObtenirRoleParId(utilisateur.Role.RoleID),
                    IsDeleted = false,
                    IsModified = false,
                    DateSuppression = DateTime.Now,
                    DateModification = DateTime.Now,
                    UtilisateurID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "UTILISATEUR", 'T', 1))

                };
                if (!String.IsNullOrEmpty(utilisateur.Password) || !String.IsNullOrWhiteSpace(utilisateur.Password))
                    user.Password = CRYPTAGE.StringHelpers.Encrypt(utilisateur.Password);
                bdd.Utilisateurs.Add(user);
                bdd.SaveChanges();

                return user.UtilisateurID;
            }
            else
            {
                UTILISATEUR user = ObtenirUtilisateurParId(utilisateur.UtilisateurID);
                user.Actif = utilisateur.Actif;
                user.Fonction = CRYPTAGE.StringHelpers.Encrypt(utilisateur.Fonction);
                if (!String.IsNullOrEmpty(utilisateur.Login) || !String.IsNullOrWhiteSpace(utilisateur.Login))
                    user.Login = CRYPTAGE.StringHelpers.Encrypt(utilisateur.Login);
                if (!String.IsNullOrEmpty(utilisateur.Password) || !String.IsNullOrWhiteSpace(utilisateur.Password))
                    user.Password = CRYPTAGE.StringHelpers.Encrypt(utilisateur.Password);
                user.Role = ObtenirRoleParId(utilisateur.Role.RoleID);
                user.IsModified = utilisateur.IsModified;
                user.DateModification = DateTime.Now;

                bdd.SaveChanges();

                return user.UtilisateurID;
            }


        }

        public UtilisateurVM4 ConvertirUtilisateurUtilisateurVM4(UTILISATEUR utilisateur)
        {
            if (utilisateur == null) return null;
            else
            {
                UtilisateurVM4 uvm4 = new UtilisateurVM4();
                uvm4.Id = utilisateur.UtilisateurID;
                uvm4.NomUtilisateur = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.Prenom);
                uvm4.Contact = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.TelephonePrincipal);
                if (uvm4.Contact == null) uvm4.Contact = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.TelephoneSecondaire);
                if (uvm4.Contact == null) uvm4.Contact = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.Email);
                uvm4.Actif = utilisateur.Actif;
                uvm4.DateCreation = utilisateur.DateCreation;
                uvm4.Role = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Role.Intitule);

                return uvm4;

            }
        }

        public List<UTILISATEUR> ObtenirTousLesUtilisateurs(int etat, String Role)
        {
            if (!String.IsNullOrEmpty(Role) || !String.IsNullOrWhiteSpace(Role))
            {
                if (Role == "-1")
                {
                    if (etat == -1)
                    {
                        return bdd.Utilisateurs.ToList();
                    }
                    else if (etat == 0)
                    {
                        return bdd.Utilisateurs.Where(u => u.Actif == true).ToList();
                    }
                    else if (etat == 1)
                    {
                        return bdd.Utilisateurs.Where(u => u.Actif == false).ToList();
                    }
                    else
                    {
                        return bdd.Utilisateurs.ToList();
                    }
                }
                else
                {
                    //Role = CRYPTAGE.StringHelpers.Decrypt(Role);

                    if (etat == -1)
                    {
                        return bdd.Utilisateurs.Where(u => u.Role.RoleID == Role).ToList();
                    }
                    if (etat == 0)
                    {
                        return bdd.Utilisateurs.Where(u => u.Actif == true && u.Role.RoleID == Role).ToList();
                    }
                    else if (etat == 1)
                    {
                        return bdd.Utilisateurs.Where(u => u.Actif == false && u.Role.RoleID == Role).ToList();
                    }
                    else
                    {
                        return bdd.Utilisateurs.ToList();
                    }
                }

            }
            else
            {
                if (etat == 0)
                {
                    return bdd.Utilisateurs.Where(u => u.Actif == true).ToList();
                }
                else if (etat == 1)
                {
                    return bdd.Utilisateurs.Where(u => u.Actif == false).ToList();
                }
                else
                {
                    return bdd.Utilisateurs.ToList();
                }
            }

        }

        /*
         * 05 Fev 2018 - @Hn
         */
        public UtilisateurVM3 ConvertirUtilisateurUtilisateurVM3(UTILISATEUR utilisateur)
        {
            if (utilisateur == null) return null;
            else
            {
                UtilisateurVM3 uvm3 = new UtilisateurVM3();
                uvm3.Id = utilisateur.UtilisateurID;

                uvm3.InfosPersonne = new PersonneVM();
                uvm3.InfosPersonne.Adresse = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.Adresse);
                uvm3.InfosPersonne.Email = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.Email);
                uvm3.InfosPersonne.Id = utilisateur.Personne.PersonneID;
                uvm3.InfosPersonne.Nom = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.Nom);
                uvm3.InfosPersonne.Prenom = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.Prenom);
                uvm3.InfosPersonne.Sexe = utilisateur.Personne.Sexe;
                uvm3.InfosPersonne.TelephonePrincipal = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.TelephonePrincipal);
                uvm3.InfosPersonne.TelephoneSecondaire = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Personne.TelephoneSecondaire);

                uvm3.InfosConnexion = new UtilisateurVM();
                uvm3.Role = new ROLE();
                uvm3.InfosConnexion.Login = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Login);
                uvm3.InfosConnexion.Password = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Password);
                uvm3.InfosConnexion.Fonction = CRYPTAGE.StringHelpers.Decrypt(utilisateur.Fonction);
                uvm3.InfosConnexion.Actif = utilisateur.Actif;
                uvm3.Role = utilisateur.Role;


                return uvm3;

            }
        }


        public void DesactiverUtilisateur(UTILISATEUR utilisateur)
        {
            if (utilisateur != null)
            {
                UTILISATEUR user = ObtenirUtilisateurParId(utilisateur.UtilisateurID);
                user.Actif = false;
                user.IsModified = true;
                user.DateModification = DateTime.Now;
                bdd.SaveChanges();
            }
        }

        public List<ROLE> ObtenirTousLesRoles()
        {
            return bdd.Roles.ToList();
        }

        public RoleVM ConvertirRoleRoleVM(ROLE role)
        {
            if (role == null) return null;
            else
            {
                RoleVM rvm = new RoleVM();
                rvm.RoleID = role.RoleID;
                rvm.Intitule = CRYPTAGE.StringHelpers.Decrypt(role.Intitule);
                return rvm;
            }
        }

        public UtilisateurVM5 ConvertirUtilisateurUtilisateurVM5(UTILISATEUR user)
        {
            if (user == null) return null;
            else
            {
                UtilisateurVM5 uvm5 = new UtilisateurVM5();
                uvm5.Id = user.UtilisateurID;
                uvm5.NomUtilisateur = CRYPTAGE.StringHelpers.Decrypt(user.Personne.Nom).ToUpper() + " " + CRYPTAGE.StringHelpers.Decrypt(user.Personne.Prenom);
                uvm5.Login = CRYPTAGE.StringHelpers.Decrypt(user.Login);
                uvm5.Password = CRYPTAGE.StringHelpers.Decrypt(user.Password);
                uvm5.Actif = user.Actif;
                uvm5.RoleID = user.Role.RoleID;

                return uvm5;
            }

        }


        public List<PRIVILEGE> ObtenirTousLesPrivileges()
        {
            return bdd.Privileges.ToList();
        }

        public List<ACCES> ObtenirTousLesAccesParRole(ROLE role)
        {
            return bdd.Acces.Where(a => a.Role.RoleID == role.RoleID && a.IsRemoved == false).ToList();
        }

        public RoleVM2 ConvertirRoleRoleVM2(ROLE role, Boolean chargerListe)
        {
            if (role == null) return null;
            else
            {
                RoleVM2 rvm2 = new RoleVM2();
                rvm2.RoleID = role.RoleID;
                rvm2.Actif = !role.IsDeleted;
                rvm2.DateCreation = ConvertirDateChaine(role.DateCreation);
                rvm2.Intitule = CRYPTAGE.StringHelpers.Decrypt(role.Intitule);
                List<UTILISATEUR> tempL = ObtenirTousLesUtilisateurs(1, role.RoleID);
                if (tempL != null) rvm2.taille = tempL.Count();
                else rvm2.taille = 0;

                if (chargerListe)
                {
                    List<ACCES> listeA = ObtenirTousLesAccesParRole(role);
                    if (listeA != null)
                    {
                        rvm2.ListePrivileges = new List<PRIVILEGE>();
                        foreach (var a in listeA)
                        {
                            rvm2.ListePrivileges.Add(a.Privilege);

                        }
                    }

                }

                return rvm2;

            }
        }

        public AccesVM ConvertirAccesAccesVM(ACCES acces)
        {
            if (acces == null) return null;
            else
            {
                AccesVM acvm = new AccesVM();
                acvm.AccesID = acces.AccesID;
                acvm.PrivilegeID = acces.Privilege.PrivilegeID;
                acvm.RoleID = acces.Role.RoleID;
                acvm.Intitule = CRYPTAGE.StringHelpers.Decrypt(acces.Privilege.Peut);
                return acvm;
            }

        }


        public void CreerRole(RoleVM2 role)
        {
            if (role != null)
            {
                ROLE r = new ROLE
                {
                    DateCreation = DateTime.Now,
                    DateModification = DateTime.Now,
                    DateSuppression = DateTime.Now,
                    Intitule = CRYPTAGE.StringHelpers.Encrypt(role.Intitule),
                    IsDeleted = false,
                    IsModified = false,
                    RoleID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "ROLE", 'T', 1)),

                };

                bdd.Roles.Add(r);
                bdd.SaveChanges();



            }

        }

        public Boolean ExisteRole(String intitule)
        {
            List<ROLE> listeR = ObtenirTousLesRoles();
            if (listeR == null) return false;
            else
            {
                foreach (var r in listeR)
                {
                    if (r != null) if (CRYPTAGE.StringHelpers.Decrypt(r.Intitule).ToUpper() == intitule.ToUpper()) return true;
                }

                return false;

            }
        }

        public ACCES ObtenirAccesParRoleIdParPrivilegeId(String RoleID, int PrivilegeID)
        {
            ROLE tempRole = ObtenirRoleParId(RoleID);
            PRIVILEGE tempPrivilege = ObtenirPrivilegeParId(PrivilegeID);
            if (tempRole != null && tempPrivilege != null)
            {
                ACCES tempAcces = bdd.Acces.FirstOrDefault(a => (a.Role.RoleID == RoleID) && (a.Privilege.PrivilegeID == PrivilegeID));
                return tempAcces;
            }
            return null;

        }

        /*
         * 07 Fev 2018 - @Hn
         */

        public PRIVILEGE ObtenirPrivilegeParId(int PrivilegeID)
        {
            return bdd.Privileges.FirstOrDefault(p => p.PrivilegeID == PrivilegeID);
        }

       
        public List<PRIVILEGE> OperandeListePrivilege(List<PRIVILEGE> ListePrivilegeA, List<PRIVILEGE> ListePrivilegeB)
        {
            if (ListePrivilegeA == null)
                return null;
            else
            {
                if (ListePrivilegeB == null) return ListePrivilegeA;
                else
                {
                    List<PRIVILEGE> tempLP = new List<PRIVILEGE>();
                    foreach (var pa in ListePrivilegeA)
                        if (!ListePrivilegeB.Contains(pa))
                            tempLP.Add(pa);

                    return tempLP;
                }
            }
        }

        public void ModifierRole(ROLE role)
        {
            ROLE r = ObtenirRoleParId(role.RoleID);
            if (r != null)
            {
                if (role.IsDeleted != r.IsDeleted)
                {
                    r.IsDeleted = role.IsDeleted;
                    r.DateSuppression = DateTime.Now;
                }
                r.Intitule = CRYPTAGE.StringHelpers.Encrypt(role.Intitule);
                r.IsModified = true;
                r.DateModification = DateTime.Now;
                bdd.SaveChanges();
            }
        }


        /*
         * 08 Fev 2018 - @Hn
         */

        public List<PRIVILEGE> ObtenirListePrivilegesParListeAcces(List<ACCES> listeacces)
        {
            if (listeacces == null) return null;
            else
            {
                List<PRIVILEGE> listeP = new List<PRIVILEGE>();
                foreach (var a in listeacces)
                {
                    if (a != null) listeP.Add(a.Privilege);
                }
                return listeP;
            }
        }

        public void RetirerAcces(ACCES acces)
        {
            if (acces != null)
            {
                acces = ObtenirAccesParId(acces.AccesID);
                if (acces != null)
                {
                    acces.IsRemoved = true;
                    acces.DateRemoved = DateTime.Now;
                    acces.IsModified = true;
                    acces.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                }

            }
        }

        public ACCES ObtenirAccesParId(String AccesId)
        {
            return bdd.Acces.FirstOrDefault(a => a.AccesID == AccesId);
        }

        public void CreerAcces(String RoleId, int PrivilegeID)
        {
            ACCES ancien = ObtenirAccesParRoleIdParPrivilegeId(RoleId, PrivilegeID);
            if (ancien != null)
            {
                ancien.IsRemoved = false;
                ancien.IsModified = true;
                ancien.DateModification = DateTime.Now;
                bdd.SaveChanges();
            }
            else
            {
                ACCES nouveau = new ACCES
                {
                    DateModification = DateTime.Now,
                    DateRemoved = DateTime.Now,
                    DateSuppression = DateTime.Now,
                    IsDeleted = false,
                    IsModified = false,
                    IsRemoved = false,
                    Privilege = ObtenirPrivilegeParId(PrivilegeID),
                    Role = ObtenirRoleParId(RoleId),
                    AccesID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "ACCES", 'T', 1)),

                };
                bdd.Acces.Add(nouveau);
                bdd.SaveChanges();

            }

        }

        public String CreerRole(ROLE role)
        {
            if (role != null)
            {
                ROLE r = new ROLE
                {
                    DateCreation = DateTime.Now,
                    DateModification = DateTime.Now,
                    DateSuppression = DateTime.Now,
                    Intitule = CRYPTAGE.StringHelpers.Encrypt(role.Intitule),
                    IsDeleted = false,
                    IsModified = false,
                    RoleID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "ROLE", 'T', 1))
                };

                bdd.Roles.Add(r);
                bdd.SaveChanges();
                return r.RoleID;
            }

            return null;
        }

        /*
         * 09 Fev 2018 - @Hn
         */
        public Boolean VerifierAccesParUtilisateurIdParPrivilegePeut(String UtilisateurID, String Peut)
        {
            Boolean grant = false;
            PRIVILEGE privilege = ObtenirPrivilegeParPeut(Peut);
            UTILISATEUR user = ObtenirUtilisateurParId(UtilisateurID);
            if (user != null && user.Role != null && privilege != null)
            {
                ACCES acces = ObtenirAccesParRoleIdParPrivilegeId(user.Role.RoleID, privilege.PrivilegeID);
                if (acces != null && acces.IsRemoved == false) grant = true;
            }

            return grant;

        }

        public PRIVILEGE ObtenirPrivilegeParPeut(String peut)
        {
            String encryptPeut = CRYPTAGE.StringHelpers.Encrypt(peut);
            return bdd.Privileges.FirstOrDefault(p => p.Peut == encryptPeut);
        }

        public GROUPEMALADIE ObtenirGroupeMaladieParId(String GroupeMaladieID)
        {
            return bdd.GroupeMaladies.FirstOrDefault(gm => gm.GroupeMaladieID == GroupeMaladieID && gm.IsDeleted == false);
        }

        public void ModifierMaladie(MALADIE maladie)
        {
            if (maladie != null)
            {
                MALADIE m = ObtenirMaladieParId(maladie.MaladieID);
                if (m != null)
                {
                    Boolean modifie = true;
                    if (m.Intitule != maladie.Intitule)
                    {
                        modifie = true;
                        m.Intitule = maladie.Intitule;
                        m.IsModified = true;
                        m.DateModification = DateTime.Now;
                    }
                    if (m.IsDeleted != maladie.IsDeleted && maladie.IsDeleted == true)
                    {
                        modifie = true;
                        m.IsDeleted = maladie.IsDeleted;
                        m.DateSuppression = DateTime.Now;
                        m.IsModified = true;
                        m.DateModification = DateTime.Now;
                    }

                    if (modifie) bdd.SaveChanges();
                }
            }
        }

        public void ModifierGroupeMaladie(GROUPEMALADIE groupemaladie)
        {
            if (groupemaladie != null)
            {
                GROUPEMALADIE gme = ObtenirGroupeMaladieParId(groupemaladie.GroupeMaladieID);
                if (gme != null)
                {
                    Boolean modifie = false;
                    if (gme.IntituleGroupe != groupemaladie.IntituleGroupe)
                    {
                        gme.IntituleGroupe = groupemaladie.IntituleGroupe;
                        gme.DateModification = DateTime.Now;
                        gme.IsModified = true;
                        modifie = true;

                    }
                    if (groupemaladie.IsDeleted == true)
                    {
                        gme.IsDeleted = true;
                        gme.DateSuppression = DateTime.Now;
                        modifie = true;
                    }

                    if (modifie) bdd.SaveChanges();


                }

            }


        }

        public GroupeMaladieVM ConvertirGroupeMaladieGroupeMaladieVM(GROUPEMALADIE groupemaladie)
        {
            if (groupemaladie != null && !groupemaladie.IsDeleted)
            {
                GroupeMaladieVM gmvm = new GroupeMaladieVM();
                gmvm.GroupeMaladieID = groupemaladie.GroupeMaladieID;
                gmvm.IntituleGroupe = CRYPTAGE.StringHelpers.Decrypt(groupemaladie.IntituleGroupe);
                gmvm.DateCreation = ConvertirDateChaine(groupemaladie.DateCreation);
                gmvm.ListMaladie = new List<MaladieVM>();
                List<MALADIE> listeMaladie = ObtenirToutesLesMaladiesDunGroupe(groupemaladie.GroupeMaladieID);
                if (listeMaladie != null)
                    foreach (var m in listeMaladie)
                    {
                        gmvm.ListMaladie.Add(ConvertirMaladieMaladieVM(m));

                    }
                return gmvm;

            }

            return null;
        }

        /*
        * 23 Fev 2018 - @Hn
        */
        public Boolean ExisteGroupeMaladieParNom(String nom)
        {
            nom = CRYPTAGE.StringHelpers.Encrypt(nom);
            GROUPEMALADIE gm = bdd.GroupeMaladies.FirstOrDefault(g => g.IntituleGroupe == nom);
            if (gm != null) return true;
            return false;
        }

        /*
         * 23 Avril 2018 - @Hn
         * 
         */
        public String FormateAge(DateTime datetime)
        {
            if (datetime != null)
            {
                DateTime dateActu = DateTime.Now;
                if (datetime.CompareTo(dateActu) > 0)
                {
                    return "error";
                }
                else
                {
                    if ((dateActu.Month - datetime.Month) >= 0)
                    {
                        return (dateActu.Year - datetime.Year) + " ans " + (dateActu.Month - datetime.Month) + " mois ";
                    }
                    else
                    {
                        return (dateActu.Year - datetime.Year - 1) + " ans " + (12 + (dateActu.Month - datetime.Month)) + " mois ";
                    }
                }
            }
            return "error";
        }

        /*
       * 26 Avril 2018 - @Hn
       * 
       */
        public int CalculAge(DateTime datetime)
        {
            if (datetime != null)
            {
                DateTime dateActu = DateTime.Now;
                if (datetime.CompareTo(dateActu) > 0)
                {
                    return 0;
                }
                else
                {
                    if ((dateActu.Month - datetime.Month) >= 0)
                    {
                        return (dateActu.Year - datetime.Year);
                    }
                    else
                    {
                        return (dateActu.Year - datetime.Year - 1);
                    }
                }
            }
            return 0;
        }

        /*
        * 27 Avril 2018 - @Hn
        * 
        */
        public GROSSESSE ObtenirGrossesseParLiaisonId(String LiaisonId)
        {
            return bdd.Grossesses.FirstOrDefault(g => g.Maternite.LiaisonDossierGroupeCibleID == LiaisonId);
        }

        /*
        * 25 Mai 2018 - @Hn
        * 
        */


        public String EnregistrerGrossesse(LIAISONDOSSIERGROUPECIBLE temp_ldgc)
        {
            if (temp_ldgc != null)
            {
                GROSSESSE grossesse = new GROSSESSE();
                grossesse.DateEnregistrement = DateTime.Now;
                grossesse.DateResultat = DateTime.Now;
                grossesse.Maternite = ObtenirLiaisonDossierGroupeParId(temp_ldgc.LiaisonDossierGroupeCibleID);
                grossesse.MedecinTraitant = ObtenirGroupeCibleParCode(grossesse.Maternite.GC.Code).Administrateur;
                grossesse.Resultat = 0;
                grossesse.IsDeleted = false;
                grossesse.IsModified = false;
                grossesse.DateSuppression = DateTime.Now;
                grossesse.DateModification = DateTime.Now;
                grossesse.GrossesseID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "GROSSESSE", 'T', 1));

                bdd.Grossesses.Add(grossesse);
                bdd.SaveChanges();
                return grossesse.GrossesseID;
            }
            else return null;
        }

        /*
        *07 Août 2018 - @Hn
        * 
        */
        public int getLongeur()
        {
            return this.LONGUEUR;
        }

        /*
        * 29 Août 2018 - @Hn
        * 
        */
        public string getErrorMessageFailedAuthorization()
        {
            return this.ERROR_MSG_FAILED_AUTHORIZATION;
        }

        /*
 
         * Date du 29 Août 2018 - @Hn
 
         */

        public String ObtenirIdDernierDossierArchived()
        {
            if (ObtenirNombreDossierArchived() > 0)
                return bdd.Dossiers.Where(d => d.Archived).OrderByDescending(d => d.DateCreation).ToList().First().DossierID;
            else return null;
        }

        public String ObtenirIdPremierDossierArchived()
        {
            if (ObtenirNombreDossierArchived() > 0)
                return bdd.Dossiers.Where(d => d.Archived).OrderBy(d => d.DateCreation).ToList().First().DossierID;
            else return null;
        }

        public int ObtenirNombreDossierArchived()
        {
            return bdd.Dossiers.Where(d => d.Archived).Count();
        }

        public string getErrorMessageArchivedFolder()
        {
            return this.ERROR_MSG_FAILED_ARCHIVE_FOLDER;
        }

        #endregion

        /*

        * Date du 27 Avril 2019 - @Hn

        */

        #region Hn : Implementation des Methodes


        #region Saving

        public String EnregistrerStock(STOCK Stock)
        {
            if (String.IsNullOrEmpty(Stock.StockID) || String.IsNullOrWhiteSpace(Stock.StockID))
            {
                STOCK stk = new STOCK
                {
                    Nom = CRYPTAGE.StringHelpers.Encrypt(Stock.Nom),
                    IsStocktCentral = Stock.IsStocktCentral,
                    Utilisateur = Stock.Utilisateur,
                    StockType = Stock.StockType,
                    DateCreation = DateTime.Now,
                    StockID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "STOCK", 'T', 1))
                };

                bdd.Stocks.Add(stk);
                bdd.SaveChanges();
                return stk.StockID;
            }
            else
            {
                STOCK stk = ObtenirStockParId(Stock.StockID);
                if (stk != null)
                {
                    stk.Nom = Stock.Nom;
                    stk.IsStocktCentral = Stock.IsStocktCentral;
                    stk.Utilisateur = Stock.Utilisateur;
                    stk.StockType = Stock.StockType;

                    stk.IsDeleted = false;
                    stk.IsModified = true;
                    stk.DateModification = DateTime.Now;

                    bdd.SaveChanges();
                    return stk.StockID;
                }
                return null;
            }
        }
        public String EnregistrerStockType(STOCKTYPE StockType)
        {
            if (String.IsNullOrEmpty(StockType.StockTypeID) || String.IsNullOrWhiteSpace(StockType.StockTypeID))
            {
                STOCKTYPE stockType = new STOCKTYPE
                {
                    Nom = CRYPTAGE.StringHelpers.Encrypt(StockType.Nom),
                    IsActif = true,
                    DateCreation = DateTime.Now,
                    StockTypeID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "STOCKTYPE", 'T', 1))
                };

                bdd.StockTypes.Add(stockType);
                bdd.SaveChanges();
                return stockType.StockTypeID;
            }
            else
            {
                STOCKTYPE stockType = ObtenirStockTypeParId(StockType.StockTypeID);
                if (stockType != null)
                {
                    stockType.Nom = CRYPTAGE.StringHelpers.Encrypt(StockType.Nom);
                    stockType.IsActif = StockType.IsActif;
                    stockType.IsDeleted = false;
                    stockType.IsModified = true;
                    stockType.DateModification = DateTime.Now;

                    bdd.SaveChanges();
                    return stockType.StockTypeID;
                }
                return null;
            }
        }
        public String EnregistrerProduit(PRODUIT Produit)
        {
            if (String.IsNullOrEmpty(Produit.ProduitID) || String.IsNullOrWhiteSpace(Produit.ProduitID))
            {
                PRODUIT Prod = new PRODUIT
                {
                    Nom = CRYPTAGE.StringHelpers.Encrypt(Produit.Nom),
                    Stock = Produit.Stock,
                    Rayon = Produit.Rayon,
                    Fabricant = Produit.Fabricant,
                    Reference = CRYPTAGE.StringHelpers.Encrypt(GenerationReferenceProduit(DateTime.Now, 'H', 1)),
                    PrixVente = Produit.PrixVente,
                    PrixAchat = Produit.PrixAchat,
                    ReferenceExterne = Produit.ReferenceExterne,
                    Description = Produit.Description,
                    DateCreation = DateTime.Now,
                    ProduitID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "PRODUIT", 'H', 1))
                };
                bdd.Produits.Add(Prod);
                bdd.SaveChanges();
                return Prod.ProduitID;
            }
            else
            {
                PRODUIT Prod = ObtenirProduitParId(Produit.ProduitID);
                if (Prod != null)
                {
                    Prod.Nom = CRYPTAGE.StringHelpers.Encrypt(Produit.Nom);
                    Prod.IsDeleted = false;
                    Prod.IsModified = true;
                    Prod.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return Prod.ProduitID;
                }
                return null;
            }
        }
        public String EnregistrerFabricant(FABRICANT Fabricant)
        {
            if (String.IsNullOrEmpty(Fabricant.FabricantID) || String.IsNullOrWhiteSpace(Fabricant.FabricantID))
            {
                FABRICANT Fab = new FABRICANT
                {
                    Nom = Fabricant.Nom, // CRYPTAGE.StringHelpers.Encrypt(Fabricant.Nom),
                    FabricantID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "FABRICANT", 'T', 1))
                };
                bdd.Fabricants.Add(Fab);
                bdd.SaveChanges();
                return Fab.FabricantID;
            }
            else
            {
                FABRICANT Fab = ObtenirFabricantParId(Fabricant.FabricantID);
                if (Fab != null)
                {
                    Fab.Nom = Fabricant.FabricantID; //CRYPTAGE.StringHelpers.Encrypt(Produit.Nom);
                    Fab.IsDeleted = false;
                    Fab.IsModified = true;
                    Fab.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return Fab.FabricantID;
                }
                return null;
            }
        }
        public String EnregistrerProduitEnStock(STOCKDETAILS Stockdetails)
        {
            if (String.IsNullOrEmpty(Stockdetails.StockDetailsID) || String.IsNullOrWhiteSpace(Stockdetails.StockDetailsID))
            {
                STOCKDETAILS stkd = new STOCKDETAILS
                {
                    StockQuantity = Stockdetails.StockQuantity,
                    Stock = Stockdetails.Stock,
                    Produit = Stockdetails.Produit,
                    StockAlert = Stockdetails.StockAlert,
                    DateExpiration = Stockdetails.DateExpiration,

                    DateCreation = DateTime.Now,
                    StockDetailsID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "STOCKDETAILS", 'H', 1))
                };
                bdd.StockDetails.Add(stkd);
                bdd.SaveChanges();
                return Stockdetails.StockDetailsID;
            }
            else
            {
                STOCKDETAILS stkd = ObtenirStockDetailsParId(Stockdetails.StockDetailsID);
                if (stkd != null)
                {
                    stkd.StockQuantity = Stockdetails.StockQuantity;
                    stkd.Stock = Stockdetails.Stock;
                    stkd.Produit = Stockdetails.Produit;
                    stkd.StockAlert = Stockdetails.StockAlert;
                    stkd.DateExpiration = Stockdetails.DateExpiration;

                    stkd.IsDeleted = false;
                    stkd.IsModified = true;
                    stkd.DateModification = DateTime.Now;

                    bdd.SaveChanges();
                    return stkd.StockDetailsID;
                }
                return null;
            }
        }
        public String EnregistrerMouvementStock(STOCKMOUVEMENT StockMouvement)
        {
            if (String.IsNullOrEmpty(StockMouvement.StockMouvementID) || String.IsNullOrWhiteSpace(StockMouvement.StockMouvementID))
            {
                STOCKMOUVEMENT stkMvt = new STOCKMOUVEMENT
                {
                    Direction = StockMouvement.Direction,
                    StockMouvementID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "STOCKMOUVEMENT", 'T', 1))
                };
                bdd.StockMouvements.Add(stkMvt);
                bdd.SaveChanges();
                return StockMouvement.StockMouvementID;
            }
            else
            {
                STOCKMOUVEMENT stkMvt = ObtenirStockMouvementParId(StockMouvement.StockMouvementID);
                if (stkMvt != null)
                {
                    //stkMvt.StockQuantity = StockMouvement.StockQuantity;
                    //stkMvt.IsDeleted = false;
                    //stkMvt.IsModified = true;
                    // stkMvt.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return stkMvt.StockMouvementID;
                }
                return null;
            }
        }
        public String EnregistrerMouvementStockDetails(STOCKMOUVEMENTDETAILS StockMouvementDetails)
        {
            if (String.IsNullOrEmpty(StockMouvementDetails.StockMouvementDetailsID) || String.IsNullOrWhiteSpace(StockMouvementDetails.StockMouvementDetailsID))
            {
                STOCKMOUVEMENTDETAILS stkMvtDetails = new STOCKMOUVEMENTDETAILS
                {
                    Quantite = StockMouvementDetails.Quantite,
                    StockMouvementDetailsID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "STOCKMOUVEMENTDETAILS", 'T', 1))
                };
                bdd.StockMouvementDetails.Add(stkMvtDetails);
                bdd.SaveChanges();
                return StockMouvementDetails.StockMouvementDetailsID;
            }
            else
            {
                STOCKMOUVEMENTDETAILS stkMvtDetails = ObtenirStockMouvementDetailsParId(StockMouvementDetails.StockMouvementDetailsID);
                if (stkMvtDetails != null)
                {
                    //stkMvtDetails.StockQuantity = StockMouvementDetails.StockQuantity;
                    //stkMvtDetails.IsDeleted = false;
                    //stkMvtDetails.IsModified = true;
                    // stkMvtDetails.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return stkMvtDetails.StockMouvementDetailsID;
                }
                return null;
            }
        }
        public String EnregistrerTransfertStock(STOCKTRANSFERT TransfertStock)
        {
            if (String.IsNullOrEmpty(TransfertStock.StockTransfertID) || String.IsNullOrWhiteSpace(TransfertStock.StockTransfertID))
            {
                STOCKTRANSFERT TransfertStk = new STOCKTRANSFERT
                {
                    Raison = TransfertStock.Raison,
                    StockTransfertID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "STOCKTRANSFERT", 'T', 1))
                };
                bdd.TransfertStocks.Add(TransfertStk);
                bdd.SaveChanges();
                return TransfertStk.StockTransfertID;
            }
            else
            {
                STOCKTRANSFERT TransfertStocks = ObtenirTransfertStockParId(TransfertStock.StockTransfertID);
                if (TransfertStocks != null)
                {
                    //TransfertStocks.StockQuantity = StockMouvementDetails.StockQuantity;
                    //TransfertStocks.IsDeleted = false;
                    //TransfertStocks.IsModified = true;
                    // TransfertStocks.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return TransfertStocks.StockTransfertID;
                }
                return null;
            }
        }
        public String EnregistrerTransfertStockDetails(STOCKTRANSFERTDETAILS TransfertStockDetails)
        {
            if (String.IsNullOrEmpty(TransfertStockDetails.StockTransfertDetailsID) || String.IsNullOrWhiteSpace(TransfertStockDetails.StockTransfertDetailsID))
            {
                STOCKTRANSFERTDETAILS TransfertStkDetails = new STOCKTRANSFERTDETAILS
                {
                    Quantite = TransfertStockDetails.Quantite,
                    StockTransfertDetailsID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "STOCKTRANSFERTDETAILS", 'T', 1))
                };
                bdd.TransfertStockDetails.Add(TransfertStkDetails);
                bdd.SaveChanges();
                return TransfertStkDetails.StockTransfertDetailsID;
            }
            else
            {
                STOCKTRANSFERTDETAILS TransfertStkDetails = ObtenirTransfertStockDetailsParId(TransfertStockDetails.StockTransfertDetailsID);
                if (TransfertStkDetails != null)
                {
                    //TransfertStkDetails.StockQuantity = StockMouvementDetails.StockQuantity;
                    //TransfertStkDetails.IsDeleted = false;
                    //TransfertStkDetails.IsModified = true;
                    // TransfertStkDetails.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return TransfertStkDetails.StockTransfertDetailsID;
                }
                return null;
            }
        }
        public String EnregistrerInventaire(INVENTAIRE Inventaire)
        {
            if (String.IsNullOrEmpty(Inventaire.InventaireID) || String.IsNullOrWhiteSpace(Inventaire.InventaireID))
            {
                INVENTAIRE Inv = new INVENTAIRE
                {
                    Reference = Inventaire.Reference,
                    InventaireID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "INVENTAIRE", 'T', 1))
                };
                bdd.Inventaires.Add(Inventaire);
                bdd.SaveChanges();
                return Inventaire.InventaireID;
            }
            else
            {
                INVENTAIRE Inv = ObtenirInventaireParId(Inventaire.InventaireID);
                if (Inv != null)
                {
                    Inv.Reference = Inventaire.Reference;
                    Inv.IsDeleted = false;
                    Inv.IsModified = true;
                    Inv.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return Inv.InventaireID;
                }
                return null;
            }
        }
        public String EnregistrerCaisse(CAISSE Caisse)
        {
            if (String.IsNullOrEmpty(Caisse.CaisseID) || String.IsNullOrWhiteSpace(Caisse.CaisseID))
            {
                CAISSE c = new CAISSE
                {
                    Nom = CRYPTAGE.StringHelpers.Encrypt(Caisse.Nom),
                    IsOpen = false,
                    DateCreation = DateTime.Now,
                    CaisseID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "CAISSE", 'T', 1))
                };
                bdd.Caisses.Add(c);
                bdd.SaveChanges();
                return c.CaisseID;
            }
            else
            {
                CAISSE c = ObtenirCaisseParId(Caisse.CaisseID);
                if (c != null)
                {
                    c.Nom = Caisse.Nom;
                    c.IsOpen = Caisse.IsOpen;
                    c.IsDeleted = false;
                    c.IsModified = true;
                    c.DateModification = DateTime.Now;
                    bdd.SaveChanges();

                    return c.CaisseID;
                }
                return null;
            }
        }
        public String EnregistrerCaisseMouvements(CAISSEMOUVEMENT CaisseMouvements)
        {
            if (String.IsNullOrEmpty(CaisseMouvements.CaisseMouvementID) || String.IsNullOrWhiteSpace(CaisseMouvements.CaisseMouvementID))
            {
                CAISSEMOUVEMENT Inv = new CAISSEMOUVEMENT
                {
                    Caisse = CaisseMouvements.Caisse,
                    Direction = CaisseMouvements.Direction,
                    Montant = CaisseMouvements.Montant,
                    Raison = CaisseMouvements.Raison,
                    Commentaire = CaisseMouvements.Commentaire,
                    EstValide = CaisseMouvements.EstValide,
                    DateCreation = DateTime.Now,

                    Reference = CRYPTAGE.StringHelpers.Encrypt(GenerationReferenceCaisseMouvement(DateTime.Now, 'H', 1)),
                    CaisseMouvementID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "CAISSEMOUVEMENT", 'H', 1))
                };
                bdd.CaisseMouvements.Add(CaisseMouvements);
                bdd.SaveChanges();
                return CaisseMouvements.CaisseMouvementID;
            }
            else
            {
                CAISSEMOUVEMENT CaisseMvt = ObtenirCaisseMouvementParId(CaisseMouvements.CaisseMouvementID);
                if (CaisseMvt != null)
                {
                    CaisseMvt.Caisse = CaisseMouvements.Caisse;
                    CaisseMvt.Direction = CaisseMouvements.Direction;
                    CaisseMvt.Montant = CaisseMouvements.Montant;
                    CaisseMvt.Raison = CaisseMouvements.Raison;
                    CaisseMvt.Commentaire = CaisseMouvements.Commentaire;
                    CaisseMvt.EstValide = CaisseMouvements.EstValide;

                    CaisseMvt.Reference = CaisseMouvements.Reference;
                    CaisseMvt.IsDeleted = false;
                    CaisseMvt.IsModified = true;
                    CaisseMvt.DateModification = DateTime.Now;

                    bdd.SaveChanges();
                    return CaisseMvt.CaisseMouvementID;
                }
                return null;
            }
        }
        public String EnregistrerCaisseOuvertureFermetures(CAISSEOUVERTUREFERMETURE CaisseOuvertureFermeture)
        {
            if (String.IsNullOrEmpty(CaisseOuvertureFermeture.CaisseOuvertureFermetureID) || String.IsNullOrWhiteSpace(CaisseOuvertureFermeture.CaisseOuvertureFermetureID))
            {
                CAISSEOUVERTUREFERMETURE COF = new CAISSEOUVERTUREFERMETURE
                {
                    Caisse = CaisseOuvertureFermeture.Caisse,
                    Utilisateur = CaisseOuvertureFermeture.Utilisateur,
                    SoldeOuverture = CaisseOuvertureFermeture.SoldeOuverture,
                    DateOuverture = DateTime.Now,
                    CommentaireOuverture = CaisseOuvertureFermeture.CommentaireOuverture,
                    DateCreation = DateTime.Now,

                    CaisseOuvertureFermetureID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "CAISSEOUVERTUREFERMETURE", 'T', 1))
                };
                bdd.CaisseOuvertureFermetures.Add(COF);
                bdd.SaveChanges();

                return COF.CaisseOuvertureFermetureID;
            }
            else
            {
                CAISSEOUVERTUREFERMETURE COF = ObtenirCaisseOuvertureFermeturesParId(CaisseOuvertureFermeture.CaisseOuvertureFermetureID);
                if (COF != null)
                {
                    COF.SoldeFermeture = CaisseOuvertureFermeture.SoldeFermeture;
                    COF.DateFermeture = DateTime.Now;
                    COF.CommentaireFermeture = CaisseOuvertureFermeture.CommentaireFermeture;

                    COF.SoldeAttendu = CaisseOuvertureFermeture.SoldeAttendu;
                    COF.SoldeManquant = CaisseOuvertureFermeture.SoldeManquant;

                    COF.IsDeleted = false;
                    COF.IsModified = true;
                    COF.DateModification = DateTime.Now;
                    bdd.SaveChanges();

                    return COF.CaisseOuvertureFermetureID;
                }
                return null;
            }
        }        
        public String EnregistrerExamenMedical(EXAMENMEDICAL ExamenMedical)
        {
            if (String.IsNullOrEmpty(ExamenMedical.ExamenMedicalId) || String.IsNullOrWhiteSpace(ExamenMedical.ExamenMedicalId))
            {
                EXAMENMEDICAL examenMedical = new EXAMENMEDICAL
                {
                    Code = ExamenMedical.Code,
                    Libelle = ExamenMedical.Libelle,
                    Description = ExamenMedical.Description,
                    Prix = ExamenMedical.Prix,
                    ExamenType = ExamenMedical.ExamenType,
                    DateCreation = DateTime.Now,
                    ExamenMedicalId = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "EXAMENMEDICAL", 'H', 1))
                };
                bdd.ExamenMedicaux.Add(examenMedical);
                bdd.SaveChanges();
                return examenMedical.ExamenMedicalId;
            }
            else
            {
                EXAMENMEDICAL examenMedical = ObtenirExamenMedicalParId(ExamenMedical.ExamenMedicalId);
                if (examenMedical != null)
                {
                    examenMedical.Code = ExamenMedical.Code;
                    examenMedical.Libelle = ExamenMedical.Libelle;
                    examenMedical.Description = ExamenMedical.Description;
                    examenMedical.Prix = ExamenMedical.Prix;
                    examenMedical.ExamenType = ExamenMedical.ExamenType;

                    examenMedical.IsDeleted = false;
                    examenMedical.IsModified = true;
                    examenMedical.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return examenMedical.ExamenMedicalId;
                }
                return null;
            }
        }
        public String EnregistrerExamen(EXAMEN Examen)
        {
            if (String.IsNullOrEmpty(Examen.ExamenID) || String.IsNullOrWhiteSpace(Examen.ExamenID))
            {
                EXAMEN examen = new EXAMEN
                {
                    Dossier = Examen.Dossier,
                    ExamenType = Examen.ExamenType,
                    Utilisateur = Examen.Utilisateur,
                    Service  = Examen.Service,
                    Reference = CRYPTAGE.StringHelpers.Encrypt(GenerationReferenceExamen(DateTime.Now, 'H', 1)),
                    DateExamen = Examen.DateExamen,
                    Description = Examen.Description,
                    DateCreation = DateTime.Now,
                    ExamenID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "EXAMEN", 'H', 1))
                };
                bdd.Examens.Add(examen);
                bdd.SaveChanges();
                return examen.ExamenID;
            }
            else
            {
                EXAMEN examen = ObtenirExamenParId(Examen.ExamenID);
                if (examen != null)
                {
                    examen.Dossier = Examen.Dossier;
                    examen.ExamenType = Examen.ExamenType;
                    examen.Utilisateur = Examen.Utilisateur;
                    examen.Service = Examen.Service;
                    examen.Reference = Examen.Reference;
                    examen.DateExamen = Examen.DateExamen;
                    examen.Description = Examen.Description;
                    examen.IsDeleted = false;
                    examen.IsModified = true;
                    examen.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return examen.ExamenID;
                }
                return null;
            }
        }
        public String EnregistrerResultat(RESULTAT Resultat)
        {
            if (String.IsNullOrEmpty(Resultat.ResultatID) || String.IsNullOrWhiteSpace(Resultat.ResultatID))
            {
                RESULTAT resultat = new RESULTAT
                {
                    Examen = Resultat.Examen,
                    Reference = CRYPTAGE.StringHelpers.Encrypt(GenerationReferenceResultat(DateTime.Now, 'H', 1)),
                    Description = Resultat.Description,
                    DateCreation = DateTime.Now,
                    ResultatID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "RESULTAT", 'H', 1))
                };
                bdd.Resultats.Add(resultat);
                bdd.SaveChanges();
                return resultat.ResultatID;
            }
            else
            {
                RESULTAT resultat = ObtenirResultatParId(Resultat.ResultatID);
                if (resultat != null)
                {
                    resultat.Examen = Resultat.Examen;
                    resultat.Reference = Resultat.Reference;
                    resultat.Description = Resultat.Description;
                    bdd.SaveChanges();
                    return resultat.ResultatID;
                }
                return null;
            }
        }
        public String EnregistrerExamenDetails(EXAMENDETAILS examenDetails)
        {
            if (String.IsNullOrEmpty(examenDetails.ExamenDetailsID) || String.IsNullOrWhiteSpace(examenDetails.ExamenDetailsID))
            {
                EXAMENDETAILS ed = new EXAMENDETAILS
                {
                    Examen = examenDetails.Examen,
                    ExamenMedical = examenDetails.ExamenMedical,
                    DateCreation = DateTime.Now,
                    ExamenDetailsID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "EXAMENDETAILS", 'H', 1))
                };
                bdd.ExamenDetails.Add(ed);
                bdd.SaveChanges();
                return ed.ExamenDetailsID;
            }
            else
            {
                EXAMENDETAILS ed = ObtenirExamenDetailsParId(examenDetails.ExamenDetailsID);
                if (ed != null)
                {
                    ed.Examen = examenDetails.Examen;
                    ed.ExamenMedical = examenDetails.ExamenMedical;
                    bdd.SaveChanges();
                    return ed.ExamenDetailsID;
                }
                return null;
            }
        }
        public String EnregistrerReglement(REGLEMENT Reglement)
        {
            if (String.IsNullOrEmpty(Reglement.ReglementID) || String.IsNullOrWhiteSpace(Reglement.ReglementID))
            {
                REGLEMENT Reg = new REGLEMENT
                {
                    Caisse = Reglement.Caisse,
                    Facture = Reglement.Facture,
                    ModePaiement = Reglement.ModePaiement,
                    MontantNet = Reglement.MontantRecu,
                    MontantRecu = Reglement.MontantRecu,
                    MontantRembourse = Reglement.MontantRembourse,
                    MontantARembourse = Reglement.MontantARembourse,
                    MontantRestant = Reglement.MontantRestant,
                    DateCreation = DateTime.Now,

                    Reference = CRYPTAGE.StringHelpers.Encrypt(GenerationReferenceReglement(DateTime.Now, 'H', 1)),

                    ReglementID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "REGLEMENT", 'H', 1))
                };
                bdd.Reglements.Add(Reg);
                bdd.SaveChanges();
                return Reg.ReglementID;
            }
            else
            {
                REGLEMENT Reg = ObtenirReglementParId(Reglement.ReglementID);
                if (Reg != null)
                {
                    Reg.Caisse = Reglement.Caisse;
                    Reg.Facture = Reglement.Facture;
                    Reg.ModePaiement = Reglement.ModePaiement;
                    Reg.MontantNet = Reglement.MontantRecu;
                    Reg.MontantRecu = Reglement.MontantRecu;
                    Reg.MontantRembourse = Reglement.MontantRembourse;
                    Reg.MontantARembourse = Reglement.MontantARembourse;
                    Reg.MontantRestant = Reglement.MontantRestant;

                    Reg.IsDeleted = false;
                    Reg.IsModified = true;
                    Reg.DateModification = DateTime.Now;

                    bdd.SaveChanges();
                    return Reg.ReglementID;
                }
                return null;
            }
        }
        public String EnregistrerExamenType(EXAMENTYPE ExamenType)
        {
            if (String.IsNullOrEmpty(ExamenType.ExamenTypeID) || String.IsNullOrWhiteSpace(ExamenType.ExamenTypeID))
            {
                EXAMENTYPE typeExamen = new EXAMENTYPE
                {
                    Libelle = ExamenType.Libelle,
                    Prix = ExamenType.Prix,
                    Description = ExamenType.Description,
                    DateCreation = DateTime.Now,
                    ExamenTypeID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "EXAMENTYPE", 'T', 1))
                };
                bdd.ExamenTypes.Add(typeExamen);
                bdd.SaveChanges();
                return typeExamen.ExamenTypeID;
            }
            else
            {
                EXAMENTYPE typeExamen = ObtenirExamenTypeParId(ExamenType.ExamenTypeID);
                if (typeExamen != null)
                {
                    typeExamen.Libelle = ExamenType.Libelle;
                    typeExamen.Prix = ExamenType.Prix;
                    typeExamen.Description = ExamenType.Description;
                    typeExamen.IsDeleted = false;
                    typeExamen.IsModified = true;
                    typeExamen.DateModification = DateTime.Now;

                    bdd.SaveChanges();
                    return typeExamen.ExamenTypeID;
                }
                return null;
            }
        }
        public String EnregistrerExamenResultat(EXAMENRESULTAT ExamenResultat)
        {
            if (String.IsNullOrEmpty(ExamenResultat.ExamenResultatID) || String.IsNullOrWhiteSpace(ExamenResultat.ExamenResultatID))
            {
                EXAMENRESULTAT examenResultat = new EXAMENRESULTAT
                {
                    Description = ExamenResultat.Description,
                    ExamenResultatID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "EXAMENRESULTAT", 'T', 1))
                };
                bdd.ExamenResultats.Add(examenResultat);
                bdd.SaveChanges();
                return ExamenResultat.ExamenResultatID;
            }
            else
            {
                EXAMENRESULTAT examenResultat = ObtenirExamenResultatParId(ExamenResultat.ExamenResultatID);
                if (examenResultat != null)
                {
                    examenResultat.Description = ExamenResultat.Description;
                    examenResultat.IsDeleted = false;
                    examenResultat.IsModified = true;
                    examenResultat.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return examenResultat.ExamenResultatID;
                }
                return null;
            }
        }
        public String EnregistrerInventaireDetail(INVENTAIREDETAILS InventaireDetail)
        {
            if (String.IsNullOrEmpty(InventaireDetail.InventaireDetailsID) || String.IsNullOrWhiteSpace(InventaireDetail.InventaireDetailsID))
            {
                INVENTAIREDETAILS examenResultat = new INVENTAIREDETAILS
                {
                    QuantiteReelle = InventaireDetail.QuantiteReelle,
                    InventaireDetailsID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "INVENTAIREDETAILS", 'T', 1))
                };
                bdd.InventaireDetails.Add(examenResultat);
                bdd.SaveChanges();
                return InventaireDetail.InventaireDetailsID;
            }
            else
            {
                INVENTAIREDETAILS inventaireDetail = ObtenirInventaireDetailParId(InventaireDetail.InventaireDetailsID);
                if (inventaireDetail != null)
                {
                    inventaireDetail.QuantiteReelle = InventaireDetail.QuantiteReelle;
                    inventaireDetail.IsDeleted = false;
                    inventaireDetail.IsModified = true;
                    inventaireDetail.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return inventaireDetail.InventaireDetailsID;
                }
                return null;
            }
        }
        public String EnregistrerFacture(FACTURE Facture)
        {
            if (String.IsNullOrEmpty(Facture.FactureID) || String.IsNullOrWhiteSpace(Facture.FactureID))
            {
                FACTURE facture = new FACTURE
                {
                    Dossier = Facture.Dossier,
                    Utilisateur = Facture.Utilisateur,
                    Reference = CRYPTAGE.StringHelpers.Encrypt(GenerationReferenceFacture(DateTime.Now, 'H', 1)),
                    DateCreation = DateTime.Now,

                    FactureID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "FACTURE", 'T', 1))
                };
                bdd.Factures.Add(facture);
                bdd.SaveChanges();
                return facture.FactureID;
            }
            else
            {
                FACTURE facture = ObtenirFactureParId(Facture.FactureID);
                if (facture != null)
                {
                    facture.Dossier = Facture.Dossier;
                    facture.Utilisateur = Facture.Utilisateur;
                    facture.EstValide = Facture.EstValide;
                    facture.EstPaye = Facture.EstPaye;
                    facture.Reference = Facture.Reference;

                    facture.IsDeleted = false;
                    facture.IsModified = true;
                    facture.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return facture.FactureID;
                }
                return null;
            }
        }
        public String EnregistrerFactureDetail(FACTUREDETAILS FactureDetails)
        {
            if (String.IsNullOrEmpty(FactureDetails.FactureDetailsID) || String.IsNullOrWhiteSpace(FactureDetails.FactureDetailsID))
            {
                FACTUREDETAILS factureDetails = new FACTUREDETAILS
                {
                    Facture = FactureDetails.Facture,
                    Produit = FactureDetails.Produit,
                    Quantite = FactureDetails.Quantite,
                    PrixUnitaire = FactureDetails.PrixUnitaire,
                    DateCreation = DateTime.Now,

                    FactureDetailsID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "FACTUREDETAILS", 'T', 1))
                };
                bdd.FactureDetails.Add(factureDetails);
                bdd.SaveChanges();
                return factureDetails.FactureDetailsID;
            }
            else
            {
                FACTUREDETAILS factureDetails = ObtenirFactureDetailParId(FactureDetails.FactureDetailsID);
                if (factureDetails != null)
                {
                    factureDetails.Facture = FactureDetails.Facture;
                    factureDetails.Produit = FactureDetails.Produit;
                    factureDetails.Quantite = FactureDetails.Quantite;
                    factureDetails.PrixUnitaire = FactureDetails.PrixUnitaire;
                    factureDetails.IsDeleted = false;
                    factureDetails.IsModified = true;
                    factureDetails.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return factureDetails.FactureDetailsID;
                }
                return null;
            }
        }
        public String EnregistrerRayon(RAYON Rayon)
        {
            if (String.IsNullOrEmpty(Rayon.RayonID) || String.IsNullOrWhiteSpace(Rayon.RayonID))
            {
                RAYON rayon = new RAYON
                {
                    Nom = Rayon.Nom,
                    RayonID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "RAYON", 'T', 1))
                };
                bdd.Rayons.Add(rayon);
                bdd.SaveChanges();
                return Rayon.RayonID;
            }
            else
            {
                RAYON rayon = ObtenirRayonParId(Rayon.RayonID);
                if (rayon != null)
                {
                    rayon.Nom = Rayon.Nom;
                    rayon.IsDeleted = false;
                    rayon.IsModified = true;
                    rayon.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return rayon.RayonID;
                }
                return null;
            }
        }
        public String EnregistrerModePaiement(MODEPAIEMENT ModePaiement)
        {
            if (String.IsNullOrEmpty(ModePaiement.ModePaiementID) || String.IsNullOrWhiteSpace(ModePaiement.ModePaiementID))
            {
                MODEPAIEMENT rayon = new MODEPAIEMENT
                {
                    Nom = ModePaiement.Nom,
                    ModePaiementID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "MODEPAIEMENT", 'T', 1))
                };
                bdd.ModePaiements.Add(rayon);
                bdd.SaveChanges();
                return ModePaiement.ModePaiementID;
            }
            else
            {
                MODEPAIEMENT modePaiement = ObtenirModePaiementParId(ModePaiement.ModePaiementID);
                if (modePaiement != null)
                {
                    modePaiement.Nom = ModePaiement.Nom;
                    modePaiement.IsDeleted = false;
                    modePaiement.IsModified = true;
                    modePaiement.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return modePaiement.ModePaiementID;
                }
                return null;
            }
        }
        public String EnregistrerLaboratoireOutil(LABORATOIREOUTILS LaboratoireOutils)
        {
            if (String.IsNullOrEmpty(LaboratoireOutils.LaboratoireOutilsID) || String.IsNullOrWhiteSpace(LaboratoireOutils.LaboratoireOutilsID))
            {
                LABORATOIREOUTILS laboratoireOutils = new LABORATOIREOUTILS
                {
                    Description = LaboratoireOutils.Description,
                    LaboratoireOutilsID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "LABORATOIREOUTILS", 'T', 1))
                };
                bdd.LaboratoireOutils.Add(laboratoireOutils);
                bdd.SaveChanges();
                return LaboratoireOutils.LaboratoireOutilsID;
            }
            else
            {
                LABORATOIREOUTILS laboratoireOutils = ObtenirLaboratoireOutilParId(LaboratoireOutils.LaboratoireOutilsID);
                if (laboratoireOutils != null)
                {
                    laboratoireOutils.Description = LaboratoireOutils.Description;
                    laboratoireOutils.IsDeleted = false;
                    laboratoireOutils.IsModified = true;
                    laboratoireOutils.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return laboratoireOutils.LaboratoireOutilsID;
                }
                return null;
            }
        }
        public String EnregistrerLaboratoire(LABORATOIRE Laboratoire)
        {
            if (String.IsNullOrEmpty(Laboratoire.LaboratoireID) || String.IsNullOrWhiteSpace(Laboratoire.LaboratoireID))
            {
                LABORATOIRE laboratoire = new LABORATOIRE
                {
                    Libelle = Laboratoire.Libelle,
                    LaboratoireID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "LABORATOIRE", 'T', 1))
                };
                bdd.Laboratoires.Add(laboratoire);
                bdd.SaveChanges();
                return Laboratoire.LaboratoireID;
            }
            else
            {
                LABORATOIRE laboratoire = ObtenirLaboratoireParId(Laboratoire.LaboratoireID);
                if (laboratoire != null)
                {
                    laboratoire.Libelle = Laboratoire.Libelle;
                    laboratoire.IsDeleted = false;
                    laboratoire.IsModified = true;
                    laboratoire.DateModification = DateTime.Now;
                    bdd.SaveChanges();
                    return laboratoire.LaboratoireID;
                }
                return null;
            }
        }

        #endregion




        #region Select By Id

        public STOCKTYPE ObtenirStockTypeParId(String StockTypeId)
        {
            return bdd.StockTypes.FirstOrDefault(s => s.StockTypeID == StockTypeId);
        }
        public STOCK ObtenirStockParId(String StockId)
        {
            return bdd.Stocks.FirstOrDefault(s => s.StockID == StockId);
        }
        public SERVICE ObtenirServiceParId(String ServiceId)
        {
            return bdd.Services.FirstOrDefault(s => s.ServiceID == ServiceId);
        }
        public STOCK ObtenirStockPrincipal()
        {
            return bdd.Stocks.FirstOrDefault(s => s.IsStocktCentral == true);
        }
        public STOCK ObtenirStockPharmacie()
        {
            String StockParmacieId = "IHdar5nRkB97y/gRyq8eFE16CW2n/gUmCm5YurfOTX4=";
            return bdd.Stocks.FirstOrDefault(s => s.StockType.StockTypeID == StockParmacieId);
        }
        public STOCK ObtenirStockLaboratoire()
        {
            return bdd.Stocks.FirstOrDefault(s => s.IsStocktCentral == true);
        }
        public FABRICANT ObtenirFabricantParId(String FabricantId)
        {
            return bdd.Fabricants.FirstOrDefault(f => f.FabricantID == FabricantId);
        }
        public STOCKDETAILS ObtenirStockDetailsParId(String StockDetailId)
        {
            return bdd.StockDetails.FirstOrDefault(sd => sd.StockDetailsID == StockDetailId);
        }
        public STOCKDETAILS ObtenirStockDetailsParProduitIdEtParStockId(String ProduitId, String StockId)
        {
            return bdd.StockDetails.FirstOrDefault(sd => sd.Produit.ProduitID == ProduitId && sd.Stock.StockID == StockId);
        }
        public List<STOCKDETAILS> ObtenirStockDetailsParProduitEtParStock(String ProduitId, String StockId)
        {
            return bdd.StockDetails.Where(sd => sd.Produit.ProduitID == ProduitId && sd.Stock.StockID == StockId).ToList();
        }
        public List<STOCKDETAILS> ObtenirStockDetailsParProduitParStockParDateExpiration(String ProduitId, String StockId, DateTime DateExpiration)
        {
            return bdd.StockDetails.Where(sd => sd.Produit.ProduitID == ProduitId && sd.Stock.StockID == StockId && sd.DateExpiration == DateExpiration).ToList();
        }
        public PRODUIT ObtenirProduitParId(String ProduitId)
        {
            return bdd.Produits.FirstOrDefault(p => p.ProduitID == ProduitId);
        }
        public List<PRODUIT> ObtenirProduitParReference(String ReferenceProduit)
        {
            return bdd.Produits.Where(p => p.Reference == ReferenceProduit).ToList();
        }
        public List<PRODUIT> ObtenirProduitParFabricantId(String FabricantId)
        {
            return bdd.Produits.Where(p => p.Fabricant.FabricantID == FabricantId).ToList();
        }
        public List<PRODUIT> ObtenirProduitParStockId(String StockId)
        {
            return bdd.Produits.Where(p => p.Stock.StockID == StockId).ToList();
        }
        public List<PRODUIT> ObtenirProduitParStocktTypeId(String StocktTypeId)
        {
            return bdd.Produits.Where(p => p.Stock.StockType.StockTypeID == StocktTypeId).ToList();
        }
        public List<PRODUIT> ObtenirProduitParReferenceEtStocktType(String Ref, String StocktTypeId)
        {
            return bdd.Produits.Where(p => p.Reference == Ref && p.Stock.StockType.StockTypeID == StocktTypeId).ToList();
        }
        public List<PRODUIT> ObtenirProduitParFabricantEtStocktType(String FabricandId, String StocktTypeId)
        {
            return bdd.Produits.Where(p => p.Fabricant.FabricantID == FabricandId && p.Stock.StockType.StockTypeID == StocktTypeId).ToList();
        }
        public STOCKMOUVEMENT ObtenirStockMouvementParId(String StockMouvementId)
        {
            return bdd.StockMouvements.FirstOrDefault(sm => sm.StockMouvementID == StockMouvementId);
        }
        public STOCKMOUVEMENT ObtenirStockMouvementParDirection(String Direction)
        {
            return bdd.StockMouvements.FirstOrDefault(sm => sm.Direction == Direction);
        }
        public STOCKMOUVEMENTDETAILS ObtenirStockMouvementDetailsParId(String StockMouvementDetailId)
        {
            return bdd.StockMouvementDetails.FirstOrDefault(smd => smd.StockMouvementDetailsID == StockMouvementDetailId);
        }
        public STOCKTRANSFERT ObtenirTransfertStockParId(String TransfertStockId)
        {
            return bdd.TransfertStocks.FirstOrDefault(ts => ts.StockTransfertID == TransfertStockId);
        }
        public STOCKTRANSFERTDETAILS ObtenirTransfertStockDetailsParId(String TransfertStockDetailId)
        {
            return bdd.TransfertStockDetails.FirstOrDefault(smd => smd.StockTransfertDetailsID == TransfertStockDetailId);
        }
        public INVENTAIRE ObtenirInventaireParId(String InventaireId)
        {
            return bdd.Inventaires.FirstOrDefault(i => i.InventaireID == InventaireId);
        }
        public CAISSE ObtenirCaisseParId(String CaisseId)
        {
            return bdd.Caisses.FirstOrDefault(i => i.CaisseID == CaisseId);
        }
        public CAISSEMOUVEMENT ObtenirCaisseMouvementParId(String CaisseMouvementId)
        {
            return bdd.CaisseMouvements.FirstOrDefault(i => i.CaisseMouvementID == CaisseMouvementId);
        }
        public CAISSEOUVERTUREFERMETURE ObtenirCaisseOuvertureFermeturesParId(String CaisseOuvertureFermetureId)
        {
            return bdd.CaisseOuvertureFermetures.FirstOrDefault(i => i.CaisseOuvertureFermetureID == CaisseOuvertureFermetureId);
        }
        public REGLEMENT ObtenirReglementParId(String ReglementId)
        {
            return bdd.Reglements.FirstOrDefault(r => r.ReglementID == ReglementId);
        }
        public EXAMEN ObtenirExamenParId(String ExamenId)
        {
            return bdd.Examens.FirstOrDefault(i => i.ExamenID == ExamenId);
        }
        public RESULTAT ObtenirResultatParId(String ResultatId)
        {
            return bdd.Resultats.FirstOrDefault(r => r.ResultatID == ResultatId);
        }
        public RESULTAT ObtenirResultatParExamenId(String ExamenId)
        {
            return bdd.Resultats.FirstOrDefault(r => r.Examen.ExamenID == ExamenId);
        }
        public EXAMENDETAILS ObtenirExamenDetailsParId(String ExamenDetailsId)
        {
            return bdd.ExamenDetails.FirstOrDefault(ed => ed.ExamenDetailsID == ExamenDetailsId);
        }
        public List<EXAMENDETAILS> ObtenirExamenDetailsParExamenId(String ExamenId)
        {            
              return bdd.ExamenDetails.Where(e => e.Examen.ExamenID == ExamenId).ToList();
        }
        public List<EXAMEN> ObtenirExamenParDossier(DOSSIER Dossier)
        {
            if(Dossier != null)
            {
                 return bdd.Examens.Where(e => e.Dossier.DossierID == Dossier.DossierID).ToList();
            }
            return null; 
        }
        public EXAMENMEDICAL ObtenirExamenMedicalParId(String ExamenMedicalId)
        {
            return bdd.ExamenMedicaux.FirstOrDefault(em => em.ExamenMedicalId == ExamenMedicalId);
        }
        public EXAMENTYPE ObtenirExamenTypeParId(String ExamenTypeId)
        {
            return bdd.ExamenTypes.FirstOrDefault(e => e.ExamenTypeID == ExamenTypeId);
        }
        public EXAMENRESULTAT ObtenirExamenResultatParId(String ExamenResultatId)
        {
            return bdd.ExamenResultats.FirstOrDefault(i => i.ExamenResultatID == ExamenResultatId);
        }
        public INVENTAIREDETAILS ObtenirInventaireDetailParId(String InventaireDetailsID)
        {
            return bdd.InventaireDetails.FirstOrDefault(i => i.InventaireDetailsID == InventaireDetailsID);
        }
        public FACTURE ObtenirFactureParId(String FactureId)
        {
            return bdd.Factures.FirstOrDefault(i => i.FactureID == FactureId);
        }
        public FACTURE ObtenirFactureParReference(String Reference)
        {
            return bdd.Factures.FirstOrDefault(fact => fact.Reference == Reference);
        }
        public List<FACTURE> ObtenirFactureParDossierId(String DossierId)
        {
            return bdd.Factures.Where(fact => fact.Dossier.DossierID == DossierId).ToList();
        }
        public FACTUREDETAILS ObtenirFactureDetailParId(String FactureDetailId)
        {
            return bdd.FactureDetails.FirstOrDefault(i => i.FactureDetailsID == FactureDetailId);
        }
        public List<FACTUREDETAILS> ObtenirTousLesFactureDetailsParFactureId(String FactureId)
        {
            return bdd.FactureDetails.Where(fd => fd.Facture.FactureID == FactureId).ToList();
        }
        public RAYON ObtenirRayonParId(String RayonId)
        {
            return bdd.Rayons.FirstOrDefault(r => r.RayonID == RayonId);
        }
        public MODEPAIEMENT ObtenirModePaiementParId(String ModePaiementId)
        {
            return bdd.ModePaiements.FirstOrDefault(r => r.ModePaiementID == ModePaiementId);
        }
        public LABORATOIREOUTILS ObtenirLaboratoireOutilParId(String LaboratoireOutilId)
        {
            return bdd.LaboratoireOutils.FirstOrDefault(r => r.LaboratoireOutilsID == LaboratoireOutilId);
        }
        public LABORATOIRE ObtenirLaboratoireParId(String LaboratoireId)
        {
            return bdd.Laboratoires.FirstOrDefault(r => r.LaboratoireID == LaboratoireId);
        }
        public List<REGLEMENT> ObtenirReglementParFactureId(String FactureId)
        {
            return bdd.Reglements.Where(reg => reg.Facture.FactureID == FactureId).ToList();
        }
        public List<REGLEMENT> ObtenirTousLesReglementsParFactureId(String FactureId)
        {
            return bdd.Reglements.Where(reg => reg.Facture.FactureID == FactureId).ToList();
        }
        public REGLEMENT ObtenirReglementParReference(String Reference)
        {
            return bdd.Reglements.FirstOrDefault(reg => reg.Reference == Reference);
        }

        #endregion




        #region Select All
        public List<STOCKTYPE> ObtenirTousLesStockTypes()
        {
            return bdd.StockTypes.ToList();
        }

        public List<STOCK> ObtenirTousLesStocks()
        {
            return bdd.Stocks.ToList();
        }

        public List<SERVICE> ObtenirTousLesServices()
        {
            return bdd.Services.ToList(); 
        }

        public List<STOCKDETAILS> ObtenirTousLesStockDetails()
        {
            //return bdd.GroupeMaladies.Where(g => g.IsDeleted == false).ToList();
            return bdd.StockDetails.ToList();
        }

        public List<PRODUIT> ObtenirTousLesProduits()
        {
            return bdd.Produits.Where(p => p.IsDeleted == false).ToList();
        }

        public List<FABRICANT> ObtenirTousLesFabricants()
        {
            //return bdd.GroupeMaladies.Where(g => g.IsDeleted == false).ToList();
            return bdd.Fabricants.ToList();
        }

        public List<STOCKMOUVEMENT> ObtenirTousLesStockMouvements()
        {
            return bdd.StockMouvements.ToList();
        }

        public List<STOCKMOUVEMENTDETAILS> ObtenirTousLesStockMouvementDetails()
        {
            return bdd.StockMouvementDetails.ToList();
        }

        public List<STOCKTRANSFERT> ObtenirTousLesTransfertStocks()
        {
            return bdd.TransfertStocks.ToList();
        }

        public List<STOCKTRANSFERTDETAILS> ObtenirTousLesTransfertStockDetails()
        {
            return bdd.TransfertStockDetails.ToList();
        }

        public List<INVENTAIRE> ObtenirTousLesInventaires()
        {
            return bdd.Inventaires.ToList();
        }

        public List<CAISSE> ObtenirTousLesCaisses()
        {
            return bdd.Caisses.ToList(); 
        }

        public List<CAISSEMOUVEMENT> ObtenirTousLesCaisseMouvements()
        {
            return bdd.CaisseMouvements.ToList();
        }

        public List<CAISSEOUVERTUREFERMETURE> ObtenirTousLesCaisseOuvertureFermetures()
        {
            return bdd.CaisseOuvertureFermetures.ToList(); 
        }

        public List<EXAMEN> ObtenirTousLesExamens()
        {
            return bdd.Examens.ToList(); 
        }
        public List<RESULTAT> ObtenirTousLesResultats()
        {
            return bdd.Resultats.ToList();
        }

        public List<EXAMENMEDICAL> ObtenirTousLesExamenMedicaux()
        {
            return bdd.ExamenMedicaux.ToList(); 
        }

        public List<EXAMENTYPE> ObtenirTousLesExamenTypes()
        {
            return bdd.ExamenTypes.ToList();
        }

        public List<EXAMENRESULTAT> ObtenirTousLesExamenResultats()
        {
            return bdd.ExamenResultats.ToList();
        }

        public List<INVENTAIREDETAILS> ObtenirTousLesInventaireDetails()
        {
            return bdd.InventaireDetails.ToList();
        }

        public List<FACTURE> ObtenirTousLesFactures()
        {
            return bdd.Factures.ToList();
        }

        public List<FACTUREDETAILS> ObtenirTousLesFactureDetails()
        {
            return bdd.FactureDetails.ToList();
        }

        public List<RAYON> ObtenirTousLesRayons()
        {
            return bdd.Rayons.ToList();
        }

        public List<MODEPAIEMENT> ObtenirTousLesModePaiements()
        {
            return bdd.ModePaiements.ToList();
        }

        public List<LABORATOIREOUTILS> ObtenirTousLesLaboratoireOutils()
        {
            return bdd.LaboratoireOutils.ToList();
        }

        public List<LABORATOIRE> ObtenirTousLesLaboratoire()
        {
            return bdd.Laboratoires.ToList();
        }

        public List<REGLEMENT> ObtenirTousLesReglements()
        {
            return bdd.Reglements.ToList();
        }


        #endregion




        #region Utulities

        public String GenererFactureConsultation(DOSSIER Dossier)
        {
            FACTURE Facture = new FACTURE();
            //PRODUIT Produit = ObtenirProduitParProduitId("");
            int Quantite = 1;

            //Facture.Date = DateTime.Now;
            Facture.Dossier = Dossier;
            Facture.EstPaye = false;
            Facture.EstValide = false;

            //Facture.Montant = (Produit.PrixVente * Quantite).ToString();
            Facture.Reference = GenerationReferenceFacture(Facture.DateCreation, 'H', 1);

            Facture.FactureID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "FACTURE", 'T', 1));
            bdd.Factures.Add(Facture);
            bdd.SaveChanges();

            FACTUREDETAILS FDetails = new FACTUREDETAILS();

            FDetails.FactureDetailsID = Facture.FactureID;
            //FDetails.Produit = Produit;
            FDetails.Quantite = Quantite;
            //FDetails.PrixUnitaire = Produit.PrixVente;
            FDetails.DateCreation = DateTime.Now;


            FDetails.FactureDetailsID = CRYPTAGE.StringHelpers.Encrypt(GenererCle(DateTime.Now, "FACTUREDETAILS", 'T', 1));
            bdd.FactureDetails.Add(FDetails);
            bdd.SaveChanges();


            return Facture.Reference;
        }

        public String GenerationReferenceProduit(DateTime dateCreation, char systeme, int lieu)
        {
            String temp = "PR";
            temp = temp + dateCreation.Hour;
            temp = temp + systeme;
            if (dateCreation.Month < 10)
                temp = temp + "0" + dateCreation.Month;
            else temp = temp + dateCreation.Month;
            temp = temp + Convert.ToString(dateCreation.Year).Substring(2, 2);
            temp = temp + dateCreation.Minute;
            temp = temp + lieu;
            if (dateCreation.Day < 10)
                temp = temp + "0" + Convert.ToString(dateCreation.Day);
            else temp = temp + Convert.ToString(dateCreation.Day);
            temp = temp + dateCreation.Second;

            return temp;
        }


        public String GenerationReferenceCaisseMouvement(DateTime dateCreation, char systeme, int lieu)
        {
            String temp = "CSSMVT";
            temp = temp + dateCreation.Hour;
            temp = temp + systeme;
            if (dateCreation.Month < 10)
                temp = temp + "0" + dateCreation.Month;
            else temp = temp + dateCreation.Month;
            temp = temp + Convert.ToString(dateCreation.Year).Substring(2, 2);
            temp = temp + dateCreation.Minute;
            temp = temp + lieu;
            if (dateCreation.Day < 10)
                temp = temp + "0" + Convert.ToString(dateCreation.Day);
            else temp = temp + Convert.ToString(dateCreation.Day);
            temp = temp + dateCreation.Second;

            return temp;
        }


        public String GenerationReferenceFacture(DateTime dateCreation, char systeme, int lieu)
        {
            String temp = "FACT";
            temp = temp + dateCreation.Hour;
            temp = temp + systeme;
            if (dateCreation.Month < 10)
                temp = temp + "0" + dateCreation.Month;
            else temp = temp + dateCreation.Month;
            temp = temp + Convert.ToString(dateCreation.Year).Substring(2, 2);
            temp = temp + dateCreation.Minute;
            temp = temp + lieu;
            if (dateCreation.Day < 10)
                temp = temp + "0" + Convert.ToString(dateCreation.Day);
            else temp = temp + Convert.ToString(dateCreation.Day);
            temp = temp + dateCreation.Second;

            return temp;
        }
        public String GenerationReferenceReglement(DateTime dateCreation, char systeme, int lieu)
        {
            String temp = "HN";
            temp = temp + dateCreation.Hour;
            temp = temp + systeme;
            if (dateCreation.Month < 10)
                temp = temp + "0" + dateCreation.Month;
            else temp = temp + dateCreation.Month;
            temp = temp + Convert.ToString(dateCreation.Year).Substring(2, 2);
            temp = temp + dateCreation.Minute;
            temp = temp + lieu;
            if (dateCreation.Day < 10)
                temp = temp + "0" + Convert.ToString(dateCreation.Day);
            else temp = temp + Convert.ToString(dateCreation.Day);
            temp = temp + dateCreation.Second;

            return temp;
        }
        public String GenerationReferenceExamen(DateTime dateCreation, char systeme, int lieu)
        {
            String temp = "LHI";
            temp = temp + dateCreation.Hour;
            temp = temp + systeme;
            if (dateCreation.Month < 10)
                temp = temp + "0" + dateCreation.Month;
            else temp = temp + dateCreation.Month;
            temp = temp + Convert.ToString(dateCreation.Year).Substring(2, 2);
            temp = temp + dateCreation.Minute;
            temp = temp + lieu;
            if (dateCreation.Day < 10)
                temp = temp + "0" + Convert.ToString(dateCreation.Day);
            else temp = temp + Convert.ToString(dateCreation.Day);
            temp = temp + dateCreation.Second;

            return temp;
        }
        public String GenerationReferenceResultat(DateTime dateCreation, char systeme, int lieu)
        {
            String temp = "RES";
            temp = temp + dateCreation.Hour;
            temp = temp + systeme;
            if (dateCreation.Month < 10)
                temp = temp + "0" + dateCreation.Month;
            else temp = temp + dateCreation.Month;
            temp = temp + Convert.ToString(dateCreation.Year).Substring(2, 2);
            temp = temp + dateCreation.Minute;
            temp = temp + lieu;
            if (dateCreation.Day < 10)
                temp = temp + "0" + Convert.ToString(dateCreation.Day);
            else temp = temp + Convert.ToString(dateCreation.Day);
            temp = temp + dateCreation.Second;

            return temp;
        }
        public CAISSE CaisseOuverteParCaissierId(String CaissierId)
        {
            CAISSEOUVERTUREFERMETURE Cof = bdd.CaisseOuvertureFermetures.Where(cof => cof.Utilisateur.UtilisateurID == CaissierId && cof.Caisse.IsOpen == true).FirstOrDefault();
            if (Cof != null)
            {
                return ObtenirCaisseParId(Cof.Caisse.CaisseID);
            }
            else
            {
                return null;
            }
        }
        public Boolean MettreAJourFactureReglee(REGLEMENT Reg)
        {
            if (Reg != null)
            {
                FACTURE Facture = ObtenirFactureParId(Reg.Facture.FactureID);
                if (Facture != null)
                {
                    Facture.EstPaye = true;
                    EnregistrerFacture(Facture);
                    return true;
                }
                return false;
            }
            return false;
        }
        public void MettreStockStockPrincipal(STOCK Stock)
        {
            if (Stock != null)
            {
                List<STOCK> listeStock = ObtenirTousLesStocks();

                foreach (var stk in listeStock)
                {
                    if (stk.StockID != Stock.StockID)
                    {
                        stk.IsStocktCentral = false;
                        EnregistrerStock(stk);
                    }
                }
            }
        }



        public decimal SommeTotalePayeeParFacture(FACTURE Facture)
        {
            List<REGLEMENT> ListeReglements = ObtenirReglementParFactureId(Facture.FactureID);
            decimal MontantGlobalRecu = 0;

            foreach (var reg in ListeReglements)
            {
                if (reg != null)
                {
                    MontantGlobalRecu += reg.MontantRecu;
                }
            }
            return MontantGlobalRecu; 
        }

        #endregion




        #region Convert
        public ProduitVM ConvertirProduitProduitVM(PRODUIT Produit)
        {
            if (Produit != null)
            {
                ProduitVM ProdVM = new ProduitVM();
                ProdVM.ProduitID = Produit.ProduitID;
                ProdVM.StockID = Produit.Stock.StockID;
                ProdVM.RayonID = Produit.Rayon.RayonID;
                ProdVM.FabricantID = Produit.Fabricant.FabricantID;
                ProdVM.Nom = Produit.Nom;
                ProdVM.Reference = Produit.Reference;

                if (ObtenirStockDetailsParProduitIdEtParStockId(Produit.ProduitID, Produit.Stock.StockID) != null)
                {
                    ProdVM.SeuilAlert = ObtenirStockDetailsParProduitIdEtParStockId(Produit.ProduitID, Produit.Stock.StockID).StockAlert;
                }
                else
                {
                    ProdVM.SeuilAlert = 0;
                }

                List<STOCKDETAILS> ListeStkd = ObtenirStockDetailsParProduitEtParStock(Produit.ProduitID, Produit.Stock.StockID);
                if (ListeStkd != null)
                {
                    int quantite = 0;
                    foreach (var el in ListeStkd)
                    {
                        quantite += el.StockQuantity;
                    }
                    ProdVM.QuantiteStock = quantite;
                }

                ProdVM.PrixVente = Produit.PrixVente;
                ProdVM.PrixAchat = Produit.PrixAchat;
                ProdVM.ReferenceExterne = Produit.ReferenceExterne;

                return ProdVM;
            }

            return null;
        }        
        public ProduitVM2 ConvertirProduitProduitVM2(PRODUIT Produit)
        {
            if (Produit != null)
            {
                ProduitVM2 ProdVM2 = new ProduitVM2();

                ProdVM2.ProduitID = Produit.ProduitID;
                STOCK stock = ObtenirStockParId(Produit.Stock.StockID);
                if (stock != null)
                {
                    ProdVM2.NomStock = CRYPTAGE.StringHelpers.Decrypt(stock.Nom);
                }

                RAYON rayon = ObtenirRayonParId(Produit.Rayon.RayonID);
                if (rayon != null)
                {
                    ProdVM2.NomRayon = CRYPTAGE.StringHelpers.Decrypt(rayon.Nom);
                }


                FABRICANT fabricant = ObtenirFabricantParId(Produit.Fabricant.FabricantID);
                if (fabricant != null)
                {
                    ProdVM2.NomFabricant = CRYPTAGE.StringHelpers.Decrypt(fabricant.Nom);
                }

                ProdVM2.NomProduit = Produit.Nom;
                ProdVM2.ReferenceProduit = Produit.Reference;
                ProdVM2.Description = Produit.Description;
                ProdVM2.PrixVente = Produit.PrixVente;
                ProdVM2.PrixAchat = Produit.PrixAchat;
                ProdVM2.ReferenceExterne = Produit.ReferenceExterne;
                ProdVM2.SeuilAlert = 0;

                List<STOCKDETAILS> ListeStkd = ObtenirStockDetailsParProduitEtParStock(Produit.ProduitID, Produit.Stock.StockID);
                if (ListeStkd != null)
                {
                    int quantite = 0;
                    foreach (var el in ListeStkd)
                    {
                        quantite += el.StockQuantity;
                    }
                    ProdVM2.QuantiteStock = quantite;
                }


                return ProdVM2;
            }

            return null;
        }        
        public ProduitVM2 ConvertirProduitProduitVM20(PRODUIT Produit)
        {
            if (Produit != null)
            {
                ProduitVM2 ProdVM2 = new ProduitVM2();

                ProdVM2.ProduitID = Produit.ProduitID;
                STOCK stock = ObtenirStockParId(Produit.Stock.StockID);
                if (stock != null)
                {
                    ProdVM2.NomStock = CRYPTAGE.StringHelpers.Decrypt(stock.Nom);
                }

                RAYON rayon = ObtenirRayonParId(Produit.Rayon.RayonID);
                if (rayon != null)
                {
                    ProdVM2.NomRayon = CRYPTAGE.StringHelpers.Decrypt(rayon.Nom);
                }


                FABRICANT fabricant = ObtenirFabricantParId(Produit.Fabricant.FabricantID);
                if (fabricant != null)
                {
                    ProdVM2.NomFabricant = CRYPTAGE.StringHelpers.Decrypt(fabricant.Nom);
                }

                ProdVM2.NomProduit = Produit.Nom;
                ProdVM2.ReferenceProduit = Produit.Reference;
                ProdVM2.Description = Produit.Description;
                ProdVM2.PrixVente = Produit.PrixVente;
                ProdVM2.PrixAchat = Produit.PrixAchat;
                ProdVM2.ReferenceExterne = Produit.ReferenceExterne;

                List<STOCKDETAILS> ListeStkd = ObtenirStockDetailsParProduitEtParStock(Produit.ProduitID, Produit.Stock.StockID);
                if (ListeStkd != null)
                {
                    List<ListePeremptionVM> list = new List<ListePeremptionVM>();
                    ListePeremptionVM perem;
                    int quantiteEnStock = 0;

                    foreach (var el in ListeStkd)
                    {
                        perem = new ListePeremptionVM();

                        perem.Quantite = el.StockQuantity.ToString();
                        perem.DateExpiration = el.DateExpiration.ToString();
                        list.Add(perem);

                        quantiteEnStock += el.StockQuantity;
                    }
                    ProdVM2.QuantiteStock = quantiteEnStock;

                    ProdVM2.Liste = list;
                }
                return ProdVM2;
            }

            return null;
        }        
        public StockVM ConvertirStockStockVM(STOCK Stock)
        {
            if (Stock != null)
            {
                StockVM StockVM = new StockVM()
                {
                    Id = Stock.StockID,
                    Nom = Stock.Nom,
                };
                return StockVM;
            }

            return null;
        }
        public StockVM2 ConvertirStockStockVM2(STOCK Stock)
        {
            if (Stock != null)
            {
                StockVM2 StockVM = new StockVM2()
                {
                    Id = Stock.StockID,
                    Nom = CRYPTAGE.StringHelpers.Decrypt(Stock.Nom),
                    IsStocktCentral = Stock.IsStocktCentral,
                    IsStocktCentralString = (Stock.IsStocktCentral) ? "OUI" : "NON",
                    ResponsableStock = CRYPTAGE.StringHelpers.Decrypt(Stock.Utilisateur.Personne.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(Stock.Utilisateur.Personne.Prenom),
                    DateCreation = Stock.DateCreation
                };
                return StockVM;
            }

            return null;
        }
        public RayonVM ConvertirRayonRayonVM(RAYON Rayon)
        {
            if (Rayon != null)
            {
                RayonVM RayonVM = new RayonVM()
                {
                    Id = Rayon.RayonID,
                    Nom = Rayon.RayonID,
                    Code = Rayon.Code,
                    NomStock = ObtenirStockParId(Rayon.Stock.StockID).Nom
                };
                return RayonVM;
            }

            return null;
        }
        public FabricantVM ConvertirFabricantFabricantVM(FABRICANT Fabricant)
        {
            if (Fabricant != null)
            {
                FabricantVM FabricantVM = new FabricantVM()
                {
                    Id = Fabricant.FabricantID,
                    Nom = Fabricant.FabricantID,
                    Adresse = Fabricant.Adresse,
                    Description = Fabricant.Description,
                    Contact = Fabricant.Contact
                };
                return FabricantVM;
            }

            return null;
        }
        public CaisseVM2 ConvertirCaisseCaisseVM2(CAISSE Caisse)
        {
            if (Caisse != null)
            {
                CaisseVM2 caisseVM2 = new CaisseVM2();

                caisseVM2.Id = CRYPTAGE.StringHelpers.Decrypt(Caisse.CaisseID);
                caisseVM2.NomCaisse = Caisse.Nom;
                caisseVM2.IsOpen = Caisse.IsOpen;

                if (Caisse.IsOpen)
                {
                    CAISSEOUVERTUREFERMETURE COF = ObtenirDernierEtatCaisseParHn(Caisse.hn);

                    if (COF != null)
                    {
                        caisseVM2.NomCaissier = CRYPTAGE.StringHelpers.Decrypt(COF.Utilisateur.Personne.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(COF.Utilisateur.Personne.Prenom);
                        caisseVM2.DateOuverture = COF.DateOuverture;
                    }
                    else
                    {
                        Caisse.IsOpen = false;
                        EnregistrerCaisse(Caisse);
                    }
                }

                return caisseVM2;
            }

            return null;
        }
        public CaisseVM3 ConvertirCaisseCaisseVM3(CAISSE Caisse)
        {
            if (Caisse != null)
            {
                CaisseVM3 caisseVM3 = new CaisseVM3();

                caisseVM3.Id = Caisse.CaisseID;
                caisseVM3.NomCaisse = CRYPTAGE.StringHelpers.Decrypt(Caisse.Nom);
                caisseVM3.IsOpen = Caisse.IsOpen;
                caisseVM3.hn = Caisse.hn;

                CAISSEOUVERTUREFERMETURE cof = ObtenirDernierEtatCaisseParHn(Caisse.hn);

                if (cof != null)
                {
                    caisseVM3.DateOuverture = cof.DateOuverture;
                    caisseVM3.SoldeOuverture = cof.SoldeOuverture;
                    caisseVM3.CommentaireOuverture = cof.CommentaireOuverture;

                    caisseVM3.DateFermeture = cof.DateFermeture;
                    caisseVM3.SoldeFermeture = cof.SoldeFermeture;
                    caisseVM3.SoldeAttendu = cof.SoldeAttendu;
                    caisseVM3.SoldeManquant = cof.SoldeManquant;
                    caisseVM3.TypeManquant = cof.TypeManquant;
                    caisseVM3.CommentaireFermeture = cof.CommentaireFermeture;

                    caisseVM3.NomCaissier = CRYPTAGE.StringHelpers.Decrypt(cof.Utilisateur.Personne.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(cof.Utilisateur.Personne.Prenom);
                    caisseVM3.CaissierId = cof.Utilisateur.UtilisateurID;

                }
                return caisseVM3;
            }
            return null;
        }
        public CAISSEOUVERTUREFERMETURE ObtenirDernierEtatCaisseParHn(String hn)
        {
            return bdd.CaisseOuvertureFermetures.Where(cof => cof.CaisseOuvertureFermetureID == hn).FirstOrDefault();
        }
        public Boolean OuvrirCaisse(CaisseVM3 caisseVM)
        {
            CAISSE caisse = ObtenirCaisseParId(caisseVM.Id);
            if (caisse != null)
            {
                if (!caisse.IsOpen)
                {
                    CAISSEOUVERTUREFERMETURE cof = new CAISSEOUVERTUREFERMETURE()
                    {
                        DateOuverture = DateTime.Now,
                        SoldeOuverture = caisseVM.SoldeOuverture,
                        CommentaireOuverture = caisseVM.CommentaireOuverture,
                        Utilisateur = ObtenirUtilisateurParId(caisseVM.CaissierId),
                        Caisse = caisse,

                        DateCreation = DateTime.Now
                    };

                    cof.CaisseOuvertureFermetureID = EnregistrerCaisseOuvertureFermetures(cof);

                    caisse.IsOpen = true;
                    caisse.hn = cof.CaisseOuvertureFermetureID;
                    caisse.DateModification = DateTime.Now;
                    EnregistrerCaisse(caisse);
                    return true;
                }
                return false;
            }
            return false;
        }
        public Boolean FermerCaisse(CaisseVM3 caisseVM)
        {
            CAISSE caisse = ObtenirCaisseParId(caisseVM.Id);
            if (caisse != null)
            {
                if (caisse.IsOpen)
                {
                    CAISSEOUVERTUREFERMETURE cof = ObtenirDernierEtatCaisseParHn(caisse.hn);
                    if (cof != null)
                    {
                        cof.SoldeFermeture = caisseVM.SoldeFermeture;
                        cof.DateFermeture = DateTime.Now;
                        cof.CommentaireFermeture = caisseVM.CommentaireFermeture;
                        cof.DateModification = DateTime.Now;
                        cof.SoldeAttendu = caisseVM.SoldeAttendu;
                        cof.SoldeManquant = caisseVM.SoldeManquant;
                        cof.TypeManquant = caisseVM.TypeManquant;

                        cof.IsDeleted = false;
                        cof.IsModified = true;

                        cof.CaisseOuvertureFermetureID = EnregistrerCaisseOuvertureFermetures(cof);

                        caisse.IsOpen = false;
                        caisse.hn = null;
                        caisse.DateModification = DateTime.Now;
                        EnregistrerCaisse(caisse);

                        return true;
                    }
                    return false;
                }
                return false;
            }
            return false;
        }
        public FactureVM ConvertirFactureFactureVM(FACTURE Facture)
        {
            if (Facture != null)
            {
                FactureVM factureVM = new FactureVM();

                factureVM.DossierID = Facture.Dossier.DossierID;
                factureVM.CaissierID = Facture.Utilisateur.UtilisateurID;
                factureVM.Patient = CRYPTAGE.StringHelpers.Decrypt(Facture.Dossier.Patient.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(Facture.Dossier.Patient.Prenom);

                return factureVM;
            }
            return null;
        }
        public FactureVM2 ConvertirFactureFactureVM2(FACTURE Facture)
        {
            if (Facture != null)
            {
                FactureVM2 factureVM2 = new FactureVM2();

                factureVM2.Id = Facture.FactureID;
                factureVM2.DossierID = Facture.Dossier.DossierID;
                factureVM2.CodeDossier = CRYPTAGE.StringHelpers.Decrypt(Facture.Dossier.Code);
                factureVM2.Patient = CRYPTAGE.StringHelpers.Decrypt(Facture.Dossier.Patient.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(Facture.Dossier.Patient.Prenom);
                factureVM2.CaissierID = Facture.Utilisateur.UtilisateurID;
                factureVM2.Caissier = CRYPTAGE.StringHelpers.Decrypt(Facture.Utilisateur.Personne.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(Facture.Utilisateur.Personne.Prenom);

                factureVM2.Reference = CRYPTAGE.StringHelpers.Decrypt(Facture.Reference);

                factureVM2.DateCreation = ConvertirDateChaine(Facture.DateCreation);
                factureVM2.EstPaye = Facture.EstPaye;


                List<FACTUREDETAILS> factureDetails = ObtenirTousLesFactureDetailsParFactureId(Facture.FactureID);

                if (factureDetails.Count > 0)
                {
                    List<ProduitVM3> ListeProduitVM = new List<ProduitVM3>();
                    decimal MontantFacture = 0;
                    ProduitVM3 produitVM;

                    foreach (var fd in factureDetails)
                    {
                        produitVM = new ProduitVM3();

                        produitVM.NomProduit = fd.Produit.Nom;
                        produitVM.Quantite = fd.Quantite;
                        produitVM.PrixUnitaire = fd.PrixUnitaire;
                        produitVM.ReferenceProduit = fd.Produit.Reference;
                        produitVM.PrixTotal = fd.PrixUnitaire * fd.Quantite;

                        MontantFacture += fd.PrixUnitaire * fd.Quantite;

                        ListeProduitVM.Add(produitVM);
                    }

                    factureVM2.Montant = MontantFacture;

                    factureVM2.ListeProduits = ListeProduitVM;
                }

                List<REGLEMENT> ListeReglements = ObtenirReglementParFactureId(Facture.FactureID);
                decimal MontantGlobalRecu = 0; 


                foreach(var reg in ListeReglements)
                {
                    if (reg != null)
                    {
                        MontantGlobalRecu += reg.MontantRecu; 
                    }
                }
                
                factureVM2.Reste = factureVM2.Montant - MontantGlobalRecu;

                return factureVM2;
            }

            return null;
        }
        public ReglementVM3 ConvertirReglementReglementVM3(REGLEMENT Reglement)
        {
            if (Reglement != null)
            {
                ReglementVM3 reglementVM = new ReglementVM3();

                reglementVM.Id = Reglement.ReglementID;

                FACTURE Fact = ObtenirFactureParId(Reglement.Facture.FactureID);
                if (Fact != null)
                {
                    reglementVM.Facture = CRYPTAGE.StringHelpers.Decrypt(Fact.Reference);
                }

                CAISSE Caisse = ObtenirCaisseParId(Reglement.Caisse.CaisseID);
                if (Caisse != null)
                {
                    reglementVM.Caisse = CRYPTAGE.StringHelpers.Decrypt(Caisse.Nom);
                }

                MODEPAIEMENT ModePaiement = ObtenirModePaiementParId(Reglement.ModePaiement.ModePaiementID);
                if (ModePaiement != null)
                {
                    reglementVM.ModePaiement = ModePaiement.Nom;
                }

                if (Reglement.MontantRecu != Reglement.MontantNet)
                {
                    reglementVM.Reste = (Reglement.MontantRecu - Reglement.MontantNet - Reglement.MontantRembourse).ToString();
                }
                else
                {
                    reglementVM.Reste = "0";
                }
                reglementVM.Reference = CRYPTAGE.StringHelpers.Decrypt(Reglement.Reference);
                reglementVM.Montant = Reglement.MontantNet;
                reglementVM.EstLivre = Reglement.EstLivre;



                reglementVM.DateCreation = ConvertirDateChaine(Reglement.DateCreation);

                return reglementVM;
            }

            return null;
        }
        public ReglementVM4 ConvertirReglementReglementVM4(REGLEMENT Reglement)
        {
            if (Reglement != null)
            {
                ReglementVM4 reglementVM = new ReglementVM4();

                reglementVM.Id = Reglement.ReglementID;

                REGLEMENT Reg = ObtenirReglementParId(Reglement.ReglementID);
                if (Reg != null)
                {
                    reglementVM.Reglement = CRYPTAGE.StringHelpers.Decrypt(Reg.Reference);
                    reglementVM.DateCreation = ConvertirDateChaine(Reg.DateCreation);
                    reglementVM.EstLivre = Reg.EstLivre;
                    reglementVM.Montant = Reg.MontantNet;
                    reglementVM.Reste = (Reglement.MontantRecu - Reglement.MontantNet - Reglement.MontantRembourse);

                    FACTURE Fact = ObtenirFactureParId(Reg.Facture.FactureID);
                    if (Fact != null)
                    {
                        reglementVM.Facture = CRYPTAGE.StringHelpers.Decrypt(Fact.Reference);
                        reglementVM.FactureId = Fact.FactureID;

                        DOSSIER Dossier = ObtenirDossierParId(Fact.Dossier.DossierID);
                        if (Dossier != null)
                        {
                            reglementVM.PatientId = Dossier.DossierID;
                            reglementVM.Patient = CRYPTAGE.StringHelpers.Decrypt(Dossier.Patient.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(Dossier.Patient.Nom);
                            return reglementVM;
                        }
                        return null;
                    }
                    return null;
                }
                return null;
            }
            return null;
        }
        public ExamenMedicalVM ConvertirExamenMedicalExamenMedicalVM(EXAMENMEDICAL ExamenMedical)
        {
            if (ExamenMedical != null)
            {
                ExamenMedicalVM examenMedicalVM = new ExamenMedicalVM();

                examenMedicalVM.Id = ExamenMedical.ExamenMedicalId;
                examenMedicalVM.Code = ExamenMedical.Code;
                examenMedicalVM.Libele = ExamenMedical.Libelle;
                examenMedicalVM.Description = ExamenMedical.Description;
                examenMedicalVM.Prix = ExamenMedical.Prix;
                examenMedicalVM.DateCreation = ExamenMedical.DateCreation;
                examenMedicalVM.ExamenType = ObtenirExamenTypeParId(ExamenMedical.ExamenType.ExamenTypeID).Libelle;

                return examenMedicalVM;
            }
            return null;
        }
        public ExamenVM ConvertirExamenExamenVM(EXAMEN Examen)
        {
            if (Examen != null)
            {
                ExamenVM examenVM = new ExamenVM();

                examenVM.Id = CRYPTAGE.StringHelpers.Decrypt(Examen.ExamenID);
                examenVM.Reference = CRYPTAGE.StringHelpers.Decrypt(Examen.Reference);
                examenVM.DateExamen = Examen.DateExamen;
                examenVM.Description = Examen.Description;
                examenVM.EstRealise = Examen.EstRealise;


                UTILISATEUR Dr = ObtenirUtilisateurParId(Examen.Utilisateur.UtilisateurID); 
                if(Dr != null)
                {
                    examenVM.Medecin = CRYPTAGE.StringHelpers.Decrypt(Dr.Personne.Nom)+ " " + CRYPTAGE.StringHelpers.Decrypt(Dr.Personne.Prenom);
                    examenVM.MedecinId = Dr.UtilisateurID; 
                }

                DOSSIER DossierMedical = ObtenirDossierParId(Examen.Dossier.DossierID);
                if (DossierMedical != null)
                {
                    examenVM.Patient = CRYPTAGE.StringHelpers.Decrypt(DossierMedical.Patient.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(DossierMedical.Patient.Prenom);
                }

                EXAMENTYPE TypeExamen = ObtenirExamenTypeParId(Examen.ExamenType.ExamenTypeID);

                if (TypeExamen != null)
                {
                    examenVM.ExamenType = TypeExamen.Libelle;
                    examenVM.PrixExamen = TypeExamen.Prix;
                    examenVM.ExamenTypeId = TypeExamen.ExamenTypeID;
                }

                SERVICE Service = ObtenirServiceParId(Examen.Service.ServiceID);
                if (Service != null)
                {
                    examenVM.Service = Service.Nom;
                    examenVM.ServiceId = Service.ServiceID;
                }

                List<EXAMENMEDICAL> listeExamenMedical = ObtenirTousLesExamenMedicaux();

                if(listeExamenMedical != null)
                {
                    ExamenMedicalVM examenMedicalVM;
                    List<ExamenMedicalVM> ListeExamenMedicauxVM = new List<ExamenMedicalVM>();  
                    foreach(var examenMedical in listeExamenMedical) 
                    {
                        examenMedicalVM = new ExamenMedicalVM();
                        examenMedicalVM = ConvertirExamenMedicalExamenMedicalVM(examenMedical);
                        ListeExamenMedicauxVM.Add(examenMedicalVM); 
                    }
                    examenVM.Examens = ListeExamenMedicauxVM;
                }

                return examenVM;
            }
            return null;
        }
        public ExamenVM2 ConvertirExamenExamenVM2(EXAMEN Examen)
        {
            if (Examen != null)
            {
                ExamenVM2 examenVM = new ExamenVM2();

                examenVM.Id = CRYPTAGE.StringHelpers.Decrypt(Examen.ExamenID);
                examenVM.Reference = CRYPTAGE.StringHelpers.Decrypt(Examen.Reference);
                examenVM.DateExamen = Examen.DateExamen;
                examenVM.Description = Examen.Description;
                examenVM.EstRealise = Examen.EstRealise;


                UTILISATEUR Dr = ObtenirUtilisateurParId(Examen.Utilisateur.UtilisateurID); 
                if(Dr != null)
                {
                    examenVM.Medecin = CRYPTAGE.StringHelpers.Decrypt(Dr.Personne.Nom)+ " " + CRYPTAGE.StringHelpers.Decrypt(Dr.Personne.Prenom);
                    examenVM.MedecinId = Dr.UtilisateurID; 
                }

                DOSSIER DossierMedical = ObtenirDossierParId(Examen.Dossier.DossierID);
                if (DossierMedical != null)
                {
                    examenVM.Patient = CRYPTAGE.StringHelpers.Decrypt(DossierMedical.Patient.Nom) + " " + CRYPTAGE.StringHelpers.Decrypt(DossierMedical.Patient.Prenom);
                }

                EXAMENTYPE TypeExamen = ObtenirExamenTypeParId(Examen.ExamenType.ExamenTypeID);

                if (TypeExamen != null)
                {
                    examenVM.ExamenType = TypeExamen.Libelle;
                    examenVM.PrixExamen = TypeExamen.Prix;
                    examenVM.ExamenTypeId = TypeExamen.ExamenTypeID;
                }

                SERVICE Service = ObtenirServiceParId(Examen.Service.ServiceID);
                if (Service != null)
                {
                    examenVM.Service = Service.Nom;
                    examenVM.ServiceId = Service.ServiceID;
                }

                List<EXAMENDETAILS> listeDetails = ObtenirExamenDetailsParExamenId(Examen.ExamenID);

                if(listeDetails != null)
                {
                    ExamenDetailsVM examDetVM;
                    List<ExamenDetailsVM> ListeExamDetVM = new List<ExamenDetailsVM>(); 
                    foreach(var examDet in listeDetails)
                    {
                        examDetVM = new ExamenDetailsVM();
                        examDetVM = ConvertirExamenDetailsExamenDetailsVM(examDet);
                        ListeExamDetVM.Add(examDetVM); 
                    }
                    examenVM.Examens = ListeExamDetVM;
                }

                return examenVM;
            }
            return null;
        }
        public ExamenDetailsVM ConvertirExamenDetailsExamenDetailsVM(EXAMENDETAILS ExamenDetails)
        {
            ExamenDetailsVM examDet = new ExamenDetailsVM();

            EXAMEN exam = ObtenirExamenParId(ExamenDetails.Examen.ExamenID);

            if(exam != null)
                examDet.ExamId = exam.ExamenID;
            
            examDet.Code = ExamenDetails.ExamenMedical.Code;
            examDet.Libele = ExamenDetails.ExamenMedical.Libelle;            
            examDet.Description = ExamenDetails.Description;            
            examDet.EstNegatif = ExamenDetails.EstNegatif;            

            return examDet; 
        }
        public ResultatVM3 ConvertirResultatResultatVM(RESULTAT Resultat)
        {
            if (Resultat != null)
            {
                ResultatVM3 ResultVM = new ResultatVM3();

                ResultVM.Id = CRYPTAGE.StringHelpers.Decrypt(Resultat.ResultatID);
                ResultVM.ExamenId = Resultat.Examen.ExamenID;
                ResultVM.ExamenType = Resultat.Examen.ExamenType.Libelle;
                ResultVM.Patient = CRYPTAGE.StringHelpers.Decrypt(Resultat.Examen.Dossier.Patient.Nom) +" "+ CRYPTAGE.StringHelpers.Decrypt(Resultat.Examen.Dossier.Patient.Prenom);
                ResultVM.Description = Resultat.Description;
                ResultVM.ReferenceExam = CRYPTAGE.StringHelpers.Decrypt(Resultat.Examen.Reference);
                ResultVM.Reference = CRYPTAGE.StringHelpers.Decrypt(Resultat.Reference);
                ResultVM.Medecin = CRYPTAGE.StringHelpers.Decrypt(Resultat.Examen.Utilisateur.Personne.Nom) +" " + CRYPTAGE.StringHelpers.Decrypt(Resultat.Examen.Utilisateur.Personne.Prenom);
                ResultVM.DateCreation = Resultat.DateCreation;


                List<EXAMENDETAILS> examDetails = ObtenirExamenDetailsParExamenId(Resultat.Examen.ExamenID);
                List<ExamenDetailsVM> examDetailsVM = new List<ExamenDetailsVM>();
                ExamenDetailsVM examDetailVM;

                foreach (var examDetail in examDetails)
                {
                    examDetailVM = new ExamenDetailsVM();
                    examDetailVM = ConvertirExamenDetailsExamenDetailsVM(examDetail);

                    examDetailsVM.Add(examDetailVM);
                }
                ResultVM.Examens = examDetailsVM;

                return ResultVM;
            }
            return null;
        }

        #endregion










        #region  To remove 
        public int EnregistrerPrivilege(PRIVILEGE Privilege)
        {
            if (Privilege.PrivilegeID == 0)
            {
                PRIVILEGE privilege = new PRIVILEGE
                {
                    ActionName = CRYPTAGE.StringHelpers.Encrypt(Privilege.ActionName),
                    Controller = CRYPTAGE.StringHelpers.Encrypt(Privilege.Controller),
                    Peut = CRYPTAGE.StringHelpers.Encrypt(Privilege.Peut),
                    Libelle = CRYPTAGE.StringHelpers.Encrypt(Privilege.Libelle),
                    DateCreation = DateTime.Now
                };

                bdd.Privileges.Add(privilege);
                bdd.SaveChanges();
                return privilege.PrivilegeID;
            }
            else
            {
                PRIVILEGE privilege = ObtenirPrivilegeParId(Privilege.PrivilegeID);
                if (privilege != null)
                {
                    privilege.ActionName = CRYPTAGE.StringHelpers.Encrypt(Privilege.ActionName);
                    privilege.Controller = CRYPTAGE.StringHelpers.Encrypt(Privilege.Controller);
                    privilege.Peut = CRYPTAGE.StringHelpers.Encrypt(Privilege.Peut);
                    privilege.Libelle = CRYPTAGE.StringHelpers.Encrypt(Privilege.Libelle);

                    privilege.IsDeleted = false;
                    privilege.IsModified = true;
                    privilege.DateModification = DateTime.Now;

                    bdd.SaveChanges();
                    return privilege.PrivilegeID;
                }

                return -1;
            }
        }
        #endregion

    }

    #endregion  //Hn : Implementation des Methodes
}
