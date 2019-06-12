using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Odbc;
using System.Linq;
using System.Web;

namespace SoftCare.ViewModels
{
    public class BDConnexion
    {

        /// <summary>
        /// Retourne le nom ou l'adresse du serveur sur laquelle est installée la base de données
        /// </summary>
        public static string DataBase
        {
            get
            {
                try
                {
                    return ConfigurationManager.AppSettings["Dsn"];
                }
                catch (Exception )
                {
                    throw new Exception("Le paramètre <DataBase> est introuvable.");
                }
            }
        }

        /// <summary>
        /// Retourne la chaîne de connexion à la base de données.
        /// </summary>
        public static string ConnectionString
        {
            get
            {
                OdbcConnectionStringBuilder oleDbConnectionStringBuilder = new OdbcConnectionStringBuilder();
                oleDbConnectionStringBuilder.Dsn = DataBase;

                return oleDbConnectionStringBuilder.ToString();
            }
        }

    }
}