USE [master]
GO
/****** Object:  Database [Sobajo]    Script Date: 6/9/2019 11:12:01 PM ******/
CREATE DATABASE [Sobajo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Sobajo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Sobajo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Sobajo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Sobajo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Sobajo] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Sobajo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Sobajo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Sobajo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Sobajo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Sobajo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Sobajo] SET ARITHABORT OFF 
GO
ALTER DATABASE [Sobajo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Sobajo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Sobajo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Sobajo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Sobajo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Sobajo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Sobajo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Sobajo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Sobajo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Sobajo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Sobajo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Sobajo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Sobajo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Sobajo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Sobajo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Sobajo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Sobajo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Sobajo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Sobajo] SET  MULTI_USER 
GO
ALTER DATABASE [Sobajo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Sobajo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Sobajo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Sobajo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Sobajo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Sobajo] SET QUERY_STORE = OFF
GO
USE [Sobajo]
GO
/****** Object:  Table [dbo].[ACCES]    Script Date: 6/9/2019 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCES](
	[AccesID] [nchar](44) NOT NULL,
	[Role_RoleID] [nchar](44) NOT NULL,
	[Privilege_PrivilegeID] [int] NOT NULL,
	[IsRemoved] [bit] NULL,
	[DateRemoved] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_ACCES] PRIMARY KEY CLUSTERED 
(
	[AccesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ATTENTE]    Script Date: 6/9/2019 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ATTENTE](
	[AttenteID] [nchar](44) NOT NULL,
	[Specialiste_UtilisateurID] [nchar](44) NOT NULL,
	[Patient_DossierID] [nchar](44) NOT NULL,
	[DateAttente] [datetime2](7) NOT NULL,
	[Etat] [bit] NOT NULL,
	[Statut] [bit] NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_ATTENTE_1] PRIMARY KEY CLUSTERED 
(
	[AttenteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CAISSE]    Script Date: 6/9/2019 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAISSE](
	[CaisseID] [nchar](44) NOT NULL,
	[IsOpen] [bit] NULL,
	[Nom] [nchar](44) NOT NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
	[hn] [nchar](44) NULL,
 CONSTRAINT [PK_CAISSE] PRIMARY KEY CLUSTERED 
(
	[CaisseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CAISSEMOUVEMENT]    Script Date: 6/9/2019 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAISSEMOUVEMENT](
	[CaisseMouvementID] [nchar](44) NOT NULL,
	[Caisse_CaisseID] [nchar](44) NOT NULL,
	[Direction] [varchar](10) NOT NULL,
	[Reference] [varchar](50) NOT NULL,
	[Montant] [decimal](15, 0) NOT NULL,
	[Raison] [varchar](255) NOT NULL,
	[Commentaire] [varchar](4000) NULL,
	[EstValide] [bit] NOT NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_CashRegisterInOut] PRIMARY KEY CLUSTERED 
(
	[CaisseMouvementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CAISSEOUVERTUREFERMETURE]    Script Date: 6/9/2019 11:12:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAISSEOUVERTUREFERMETURE](
	[CaisseOuvertureFermetureID] [nchar](44) NOT NULL,
	[Caisse_CaisseID] [nchar](44) NOT NULL,
	[Utilisateur_UtilisateurID] [nchar](44) NOT NULL,
	[DateOuverture] [datetime2](7) NOT NULL,
	[SoldeOuverture] [decimal](15, 0) NOT NULL,
	[DateFermeture] [datetime2](7) NULL,
	[SoldeFermeture] [decimal](15, 0) NULL,
	[SoldeAttendu] [decimal](15, 0) NULL,
	[SoldeManquant] [decimal](15, 0) NULL,
	[TypeManquant] [varchar](255) NULL,
	[CommentaireOuverture] [varchar](max) NULL,
	[CommentaireFermeture] [varchar](max) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_CashRegisterOpeningClosingHistory] PRIMARY KEY CLUSTERED 
(
	[CaisseOuvertureFermetureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLETABLE]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLETABLE](
	[CleTableID] [int] NOT NULL,
	[NomTable] [nvarchar](200) NOT NULL,
	[DesignationTable] [nvarchar](200) NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_CLETABLE] PRIMARY KEY CLUSTERED 
(
	[CleTableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIAGNOSTIC]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIAGNOSTIC](
	[DiagnosticID] [nchar](44) NOT NULL,
	[Dossier_DossierID] [nchar](44) NOT NULL,
	[Auteur_UtilisateurID] [nchar](44) NOT NULL,
	[Maladie_MaladieID] [nchar](44) NULL,
	[Avis] [nvarchar](max) NOT NULL,
	[DateDiagnostic] [datetime2](7) NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_Diagnostic] PRIMARY KEY CLUSTERED 
(
	[DiagnosticID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DOSSIER]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOSSIER](
	[DossierID] [nchar](44) NOT NULL,
	[Createur_UtilisateurID] [nchar](44) NOT NULL,
	[Patient_PersonneID] [nchar](44) NOT NULL,
	[Code] [nvarchar](max) NULL,
	[DateCreation] [datetime2](7) NOT NULL,
	[Locked] [bit] NULL,
	[PenseBete] [nvarchar](max) NULL,
	[DateArchivage] [datetime2](7) NULL,
	[Archived] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_Dossier] PRIMARY KEY CLUSTERED 
(
	[DossierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EXAMEN]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXAMEN](
	[ExamenID] [nchar](44) NOT NULL,
	[Dossier_DossierID] [nchar](44) NOT NULL,
	[Utilisateur_UtilisateurID] [nchar](44) NOT NULL,
	[Service_ServiceID] [nchar](44) NULL,
	[ExamenType_ExamenTypeID] [nchar](44) NULL,
	[Diagnostic_DiagnosticID] [nchar](44) NULL,
	[Reference] [nchar](44) NULL,
	[DateExamen] [datetime2](7) NULL,
	[Description] [varchar](max) NULL,
	[EstRealise] [bit] NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_EXAMEN] PRIMARY KEY CLUSTERED 
(
	[ExamenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EXAMENDETAILS]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXAMENDETAILS](
	[ExamenDetailsID] [nchar](44) NOT NULL,
	[Examen_ExamenID] [nchar](44) NOT NULL,
	[ExamenMedical_ExamenMedicalID] [nchar](44) NOT NULL,
	[DateCreation] [datetime] NULL,
	[Description] [nchar](10) NULL,
	[EstNegatif] [bit] NULL,
 CONSTRAINT [PK_EXAMENDETAILS] PRIMARY KEY CLUSTERED 
(
	[ExamenDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EXAMENMEDICAL]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXAMENMEDICAL](
	[ExamenMedicalID] [nchar](44) NOT NULL,
	[ExamenType_ExamenTypeID] [nchar](44) NOT NULL,
	[Code] [varchar](255) NULL,
	[Libelle] [varchar](255) NULL,
	[Description] [varchar](max) NULL,
	[Prix] [decimal](18, 0) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_EXAMENMEDICAL] PRIMARY KEY CLUSTERED 
(
	[ExamenMedicalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EXAMENRESULTAT]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXAMENRESULTAT](
	[ExamenResultatID] [nchar](44) NOT NULL,
	[Examen_ExamenID] [nchar](44) NOT NULL,
	[Description] [varchar](max) NULL,
	[DateResultat] [datetime2](7) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_EXAMENRESULTAT] PRIMARY KEY CLUSTERED 
(
	[ExamenResultatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EXAMENTYPE]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EXAMENTYPE](
	[ExamenTypeID] [nchar](44) NOT NULL,
	[Libelle] [varchar](50) NOT NULL,
	[Description] [varchar](max) NULL,
	[Prix] [decimal](15, 0) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_EXAMENTYPE] PRIMARY KEY CLUSTERED 
(
	[ExamenTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FABRICANT]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FABRICANT](
	[FabricantID] [nchar](44) NOT NULL,
	[Nom] [varchar](255) NOT NULL,
	[Description] [varchar](max) NULL,
	[Adresse] [varchar](255) NULL,
	[Contact] [varchar](255) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_ProductManufacturer] PRIMARY KEY CLUSTERED 
(
	[FabricantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACTURE]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACTURE](
	[FactureID] [nchar](44) NOT NULL,
	[Dossier_DossierID] [nchar](44) NOT NULL,
	[Utilisateur_UtilisateurID] [nchar](44) NOT NULL,
	[Reference] [nchar](44) NULL,
	[Montant] [decimal](15, 0) NULL,
	[EstValide] [bit] NULL,
	[EstPaye] [bit] NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_PurchaseInvoice] PRIMARY KEY CLUSTERED 
(
	[FactureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACTUREDETAILS]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACTUREDETAILS](
	[FactureDetailsID] [nchar](44) NOT NULL,
	[Facture_FactureID] [nchar](44) NOT NULL,
	[Produit_ProduitID] [nchar](44) NULL,
	[Quantite] [int] NULL,
	[PrixUnitaire] [decimal](15, 0) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_SalesInvoiceDetail] PRIMARY KEY CLUSTERED 
(
	[FactureDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FOURNISSEUR]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FOURNISSEUR](
	[FournisseurID] [nchar](44) NOT NULL,
	[Nom] [varchar](255) NULL,
	[Adresse] [varchar](50) NULL,
	[Telephone] [varchar](15) NULL,
	[Fax] [varchar](15) NULL,
	[Email] [varchar](50) NULL,
	[EstActif] [bit] NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_Vendor_VendorID] PRIMARY KEY CLUSTERED 
(
	[FournisseurID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GROSSESSE]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GROSSESSE](
	[GrossesseID] [nchar](44) NOT NULL,
	[Maternite_LiaisonDossierGroupeCibleID] [nchar](44) NOT NULL,
	[MedecinTraitant_UtilisateurID] [nchar](44) NOT NULL,
	[DateEnregistrement] [datetime2](7) NOT NULL,
	[DateResultat] [datetime2](7) NULL,
	[Resultat] [int] NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_GROSSESSE] PRIMARY KEY CLUSTERED 
(
	[GrossesseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GROUPECIBLE]    Script Date: 6/9/2019 11:12:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GROUPECIBLE](
	[GroupeCibleID] [nchar](44) NOT NULL,
	[Administrateur_UtilisateurID] [nchar](44) NOT NULL,
	[Type_TypeGroupeID] [nchar](44) NOT NULL,
	[Intitule] [nchar](255) NULL,
	[Objet] [nvarchar](max) NULL,
	[Archived] [bit] NOT NULL,
	[Closed] [bit] NOT NULL,
	[DateCreationGroupe] [datetime2](7) NOT NULL,
	[DateClotureGroupe] [datetime2](7) NULL,
	[DateArchivageGroupe] [datetime2](7) NULL,
	[Createur_UtilisateurID] [nchar](44) NULL,
	[Code] [nchar](44) NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_GROUPECIBLE] PRIMARY KEY CLUSTERED 
(
	[GroupeCibleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GROUPEMALADIE]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GROUPEMALADIE](
	[GroupeMaladieID] [nchar](44) NOT NULL,
	[IntituleGroupe] [nvarchar](max) NOT NULL,
	[DateCreation] [datetime2](7) NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_GROUPEMALADIE] PRIMARY KEY CLUSTERED 
(
	[GroupeMaladieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[INVENTAIRE]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INVENTAIRE](
	[InventaireID] [nchar](44) NOT NULL,
	[Stock_StockID] [nchar](44) NOT NULL,
	[Reference] [varchar](20) NULL,
	[DateDebut] [datetime2](7) NOT NULL,
	[DateFin] [datetime2](7) NULL,
	[Commentaire] [varchar](4000) NULL,
	[EstFini] [bit] NOT NULL,
	[EstValide] [bit] NOT NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED 
(
	[InventaireID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[INVENTAIREDETAILS]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INVENTAIREDETAILS](
	[InventaireDetailID] [nchar](44) NOT NULL,
	[Inventaire_InventaireID] [nchar](44) NOT NULL,
	[Produit_ProduitID] [nchar](44) NOT NULL,
	[QuantiteLogic] [smallint] NULL,
	[QuantiteReelle] [smallint] NULL,
	[PrixAchat] [decimal](15, 0) NULL,
	[PrixVente] [decimal](15, 0) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_InventoryDetail] PRIMARY KEY CLUSTERED 
(
	[InventaireDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LABORATOIRE]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LABORATOIRE](
	[LaboratoireID] [varchar](50) NOT NULL,
	[Libelle] [varchar](50) NULL,
	[Adresse] [varchar](50) NULL,
	[Telephone] [int] NULL,
	[Email] [varchar](50) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_LABORATOIRE] PRIMARY KEY CLUSTERED 
(
	[LaboratoireID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LABORATOIREOUTILS]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LABORATOIREOUTILS](
	[LaboratoireOutilsID] [varchar](50) NOT NULL,
	[Laboratoire_LaboratoireID] [varchar](50) NOT NULL,
	[RayonID] [nchar](44) NOT NULL,
	[Libelle] [varchar](50) NOT NULL,
	[Description] [varchar](max) NOT NULL,
	[EstCompte] [bit] NOT NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_LABORATOIREOUTILS] PRIMARY KEY CLUSTERED 
(
	[LaboratoireOutilsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LIAISONDOSSIERGROUPECIBLE]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIAISONDOSSIERGROUPECIBLE](
	[LiaisonDossierGroupeCibleID] [nchar](44) NOT NULL,
	[Dossier_DossierID] [nchar](44) NOT NULL,
	[GC_GroupeCibleID] [nchar](44) NOT NULL,
	[DateIntegration] [datetime2](7) NOT NULL,
	[DateDepart] [datetime2](7) NOT NULL,
	[Actif] [bit] NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_LIAISONDOSSIERGROUPECIBLE] PRIMARY KEY CLUSTERED 
(
	[LiaisonDossierGroupeCibleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LIVRAISON]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIVRAISON](
	[LivraisonID] [nchar](44) NOT NULL,
	[Fournisseur_FournisseurID] [nchar](44) NOT NULL,
	[Dossier_DossierD] [nchar](44) NOT NULL,
	[Stock_StockID] [nchar](44) NOT NULL,
	[Facture_FactureID] [nchar](44) NOT NULL,
	[Utilisateur_UtilisateurID] [nchar](44) NOT NULL,
	[Reference] [varchar](20) NULL,
	[EstValide] [bit] NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_SalesDelivery] PRIMARY KEY CLUSTERED 
(
	[LivraisonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOGBASE]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOGBASE](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[LogPlace] [nvarchar](50) NOT NULL,
	[LogLastDateUpdate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_LOGBASE] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOGTABLE]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOGTABLE](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[LogTableName] [nvarchar](50) NOT NULL,
	[LogTableLastDateUpdate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_LOGTABLE] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MALADIE]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MALADIE](
	[MaladieID] [nchar](44) NOT NULL,
	[TypeMaladie_GroupeMaladieID] [nchar](44) NOT NULL,
	[Intitule] [nvarchar](max) NOT NULL,
	[DateCreation] [datetime2](7) NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_MALADIE] PRIMARY KEY CLUSTERED 
(
	[MaladieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MODEPAIEMENT]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MODEPAIEMENT](
	[ModePaiementID] [nchar](44) NOT NULL,
	[Nom] [varchar](50) NOT NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_PaymentMode] PRIMARY KEY CLUSTERED 
(
	[ModePaiementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MODIFICATION]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MODIFICATION](
	[ModificationID] [nchar](44) NOT NULL,
	[Dossier_DossierID] [nchar](44) NOT NULL,
	[Auteur_UtilisateurID] [nchar](44) NOT NULL,
	[DateModification] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Modification] PRIMARY KEY CLUSTERED 
(
	[ModificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MODIFICATIONATTENTE]    Script Date: 6/9/2019 11:12:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MODIFICATIONATTENTE](
	[ModificationAttenteID] [nchar](44) NOT NULL,
	[Attente_AttenteID] [nchar](44) NOT NULL,
	[AncienSpecialiste_UtilisateurID] [nchar](44) NOT NULL,
	[NouveauSpecialiste_UtilisateurID] [nchar](44) NOT NULL,
	[DateModification] [datetime2](7) NOT NULL,
	[Motif] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
 CONSTRAINT [PK_ModificationAttente] PRIMARY KEY CLUSTERED 
(
	[ModificationAttenteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PARAMETRE]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PARAMETRE](
	[ParametreID] [nchar](44) NOT NULL,
	[Dossier_DossierID] [nchar](44) NOT NULL,
	[Tension] [nvarchar](max) NULL,
	[Pouls] [float] NULL,
	[Temperature] [float] NULL,
	[Avis] [nvarchar](max) NULL,
	[DatePrise] [datetime2](7) NOT NULL,
	[Poids] [float] NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_Parametre] PRIMARY KEY CLUSTERED 
(
	[ParametreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PERSONNE]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERSONNE](
	[PersonneID] [nchar](44) NOT NULL,
	[Nom] [nvarchar](max) NOT NULL,
	[Prenom] [nvarchar](max) NULL,
	[TelephonePrincipal] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Adresse] [nvarchar](max) NULL,
	[Sexe] [int] NOT NULL,
	[TelephoneSecondaire] [nvarchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateNaissance] [date] NULL,
	[LieuNaissance] [nvarchar](max) NULL,
 CONSTRAINT [PK_Personne] PRIMARY KEY CLUSTERED 
(
	[PersonneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRIVILEGE]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRIVILEGE](
	[PrivilegeID] [int] IDENTITY(1,1) NOT NULL,
	[ActionName] [nvarchar](max) NOT NULL,
	[Controller] [nvarchar](max) NOT NULL,
	[Peut] [nvarchar](max) NOT NULL,
	[Libelle] [nvarchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateCreation] [datetime2](7) NULL,
 CONSTRAINT [PK_PRIVILEGE2] PRIMARY KEY CLUSTERED 
(
	[PrivilegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUIT]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUIT](
	[ProduitID] [nchar](44) NOT NULL,
	[Stock_StockID] [nchar](44) NULL,
	[Rayon_RayonID] [nchar](44) NULL,
	[Fabricant_FabricantID] [nchar](44) NULL,
	[Fournisseur_FournisseurID] [nchar](44) NULL,
	[Reference] [varchar](50) NULL,
	[Nom] [varchar](255) NULL,
	[PrixVente] [decimal](15, 0) NULL,
	[PrixAchat] [decimal](15, 0) NULL,
	[ReferenceExterne] [varchar](50) NULL,
	[StockAlert] [int] NULL,
	[EstCompte] [bit] NULL,
	[Description] [varchar](max) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProduitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RAPPELRDV]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RAPPELRDV](
	[RappelRdvID] [nchar](44) NOT NULL,
	[Rdv_RendezVousID] [nchar](44) NOT NULL,
	[DateRappel] [datetime2](7) NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_RappelRDV] PRIMARY KEY CLUSTERED 
(
	[RappelRdvID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RAYON]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RAYON](
	[RayonID] [nchar](44) NOT NULL,
	[Stock_StockId] [nchar](44) NULL,
	[Code] [varchar](50) NULL,
	[Nom] [varchar](255) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_RayShop] PRIMARY KEY CLUSTERED 
(
	[RayonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REGLEMENT]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REGLEMENT](
	[ReglementID] [nchar](44) NOT NULL,
	[Caisse_CaisseID] [nchar](44) NOT NULL,
	[Facture_FactureID] [nchar](44) NOT NULL,
	[ModePaiement_ModePaiementID] [nchar](44) NOT NULL,
	[Motif] [varchar](255) NULL,
	[Reference] [nchar](44) NULL,
	[MontantNet] [decimal](15, 0) NULL,
	[MontantRecu] [decimal](15, 0) NULL,
	[MontantRembourse] [decimal](15, 0) NULL,
	[MontantARembourse] [decimal](15, 0) NULL,
	[MontantRestant] [decimal](15, 0) NULL,
	[EstLivre] [bit] NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_SalesPayment] PRIMARY KEY CLUSTERED 
(
	[ReglementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RENDEZVOUS]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RENDEZVOUS](
	[RendezVousID] [nchar](44) NOT NULL,
	[Recepteur_DossierID] [nchar](44) NOT NULL,
	[Emetteur_UtilisateurID] [nchar](44) NOT NULL,
	[Horaire] [datetime2](7) NOT NULL,
	[Commentaire] [nvarchar](max) NULL,
	[Recu] [bit] NOT NULL,
	[Actif] [bit] NOT NULL,
	[Manque] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_RendezVous] PRIMARY KEY CLUSTERED 
(
	[RendezVousID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RESULTAT]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESULTAT](
	[ResultatID] [nchar](44) NOT NULL,
	[Examen_ExamenID] [nchar](44) NOT NULL,
	[Reference] [nchar](44) NULL,
	[Description] [varchar](max) NULL,
	[DateCreation] [datetime] NULL,
 CONSTRAINT [PK_RESULTAT] PRIMARY KEY CLUSTERED 
(
	[ResultatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLE](
	[RoleID] [nchar](44) NOT NULL,
	[Intitule] [nvarchar](max) NOT NULL,
	[DateCreation] [datetime2](7) NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_ROLE] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SERVICE]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SERVICE](
	[ServiceID] [nchar](44) NOT NULL,
	[Nom] [varchar](max) NULL,
	[DateCreation] [datetime] NULL,
 CONSTRAINT [PK_SERVICE] PRIMARY KEY CLUSTERED 
(
	[ServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STOCK]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STOCK](
	[StockID] [nchar](44) NOT NULL,
	[Utilisateur_UtilisateurID] [nchar](44) NOT NULL,
	[StockType_StockTypeID] [nchar](44) NULL,
	[Nom] [nchar](44) NULL,
	[IsStocktCentral] [bit] NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STOCKDETAILS]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STOCKDETAILS](
	[StockDetailsID] [nchar](44) NOT NULL,
	[Stock_StockID] [nchar](44) NOT NULL,
	[Produit_ProduitID] [nchar](44) NOT NULL,
	[StockQuantity] [int] NULL,
	[StockAlert] [int] NULL,
	[DateExpiration] [datetime2](7) NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_StoreProduct_1] PRIMARY KEY CLUSTERED 
(
	[StockDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STOCKMOUVEMENT]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STOCKMOUVEMENT](
	[StockMouvementID] [nchar](44) NOT NULL,
	[Stock_StockID] [nchar](44) NOT NULL,
	[Reference] [varchar](20) NOT NULL,
	[Date] [date] NOT NULL,
	[Direction] [varchar](10) NOT NULL,
	[Raison] [varchar](255) NULL,
	[IsValidated] [bit] NOT NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_StockInOut] PRIMARY KEY CLUSTERED 
(
	[StockMouvementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STOCKMOUVEMENTDETAILS]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STOCKMOUVEMENTDETAILS](
	[StockMouvementDetailsID] [nchar](44) NOT NULL,
	[StockMouvement_StockMouvementID] [nchar](44) NOT NULL,
	[Produit_ProduitID] [nchar](44) NOT NULL,
	[Quantite] [smallint] NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_STOCKMOUVEMENTDETAILS] PRIMARY KEY CLUSTERED 
(
	[StockMouvementDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STOCKTRANSFERT]    Script Date: 6/9/2019 11:12:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STOCKTRANSFERT](
	[StockTransfertID] [nchar](44) NOT NULL,
	[Stock_StockTransfertFromID] [nchar](44) NOT NULL,
	[Stock_StockTransfertToID] [nchar](44) NOT NULL,
	[Reference] [varchar](20) NULL,
	[Raison] [varchar](255) NULL,
	[EstValide] [bit] NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_StockTransfer] PRIMARY KEY CLUSTERED 
(
	[StockTransfertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STOCKTRANSFERTDETAILS]    Script Date: 6/9/2019 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STOCKTRANSFERTDETAILS](
	[StockTransfertDetailsID] [nchar](44) NOT NULL,
	[StockTransfert_StockTransfertID] [nchar](44) NOT NULL,
	[Produit_ProduitID] [nchar](44) NOT NULL,
	[Quantite] [smallint] NULL,
	[DateCreation] [datetime2](7) NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_StockTransferDetail] PRIMARY KEY CLUSTERED 
(
	[StockTransfertDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STOCKTYPE]    Script Date: 6/9/2019 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STOCKTYPE](
	[StockTypeId] [nchar](44) NOT NULL,
	[Nom] [nchar](44) NOT NULL,
	[IsActif] [bit] NULL,
	[DateCreation] [datetime] NULL,
	[IsDeleted] [bit] NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[DateSuppression] [datetime2](7) NULL,
 CONSTRAINT [PK_STOCKTYPE] PRIMARY KEY CLUSTERED 
(
	[StockTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TRAITEMENT]    Script Date: 6/9/2019 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TRAITEMENT](
	[TraitementID] [nchar](44) NOT NULL,
	[Diagnostic_DiagnosticID] [nchar](44) NOT NULL,
	[Specialiste_UtilisateurID] [nchar](44) NOT NULL,
	[Recommandation] [nvarchar](max) NOT NULL,
	[DateTraitement] [datetime2](7) NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_Traitement] PRIMARY KEY CLUSTERED 
(
	[TraitementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TYPEGROUPE]    Script Date: 6/9/2019 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TYPEGROUPE](
	[TypeGroupeID] [nchar](44) NOT NULL,
	[Objet] [nchar](80) NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_TYPECGROUPE] PRIMARY KEY CLUSTERED 
(
	[TypeGroupeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UTILISATEUR]    Script Date: 6/9/2019 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UTILISATEUR](
	[UtilisateurID] [nchar](44) NOT NULL,
	[Personne_PersonneID] [nchar](44) NOT NULL,
	[DateCreation] [datetime2](7) NOT NULL,
	[Login] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Fonction] [nvarchar](max) NULL,
	[Actif] [bit] NOT NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
	[Role_RoleID] [nchar](44) NULL,
 CONSTRAINT [PK_Utilisateur] PRIMARY KEY CLUSTERED 
(
	[UtilisateurID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VISITEPRENATALE]    Script Date: 6/9/2019 11:12:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VISITEPRENATALE](
	[VisitePrenataleID] [nchar](44) NOT NULL,
	[Grossesse_GrossesseID] [nchar](44) NOT NULL,
	[Rdv_RendezVousID] [nchar](44) NOT NULL,
	[Observation] [nvarchar](max) NULL,
	[IsDeleted] [bit] NULL,
	[DateSuppression] [datetime2](7) NULL,
	[IsModified] [bit] NULL,
	[DateModification] [datetime2](7) NULL,
 CONSTRAINT [PK_VISITEPRENATALE] PRIMARY KEY CLUSTERED 
(
	[VisitePrenataleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'/c9Ha9ZiMcOhr0AInHkH9dSX/WTmQfTUO/mOKYtGg3s=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 4, 0, CAST(N'2018-06-20T14:49:10.5134754' AS DateTime2), 0, CAST(N'2018-06-20T14:49:10.5134754' AS DateTime2), 0, CAST(N'2018-06-20T14:49:10.5134754' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'/c9Ha9ZiMcOhr0AInHkH9Y8VZjivgfd6tDTksQ6WSy4=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 3, 0, CAST(N'2018-06-20T14:49:10.2634649' AS DateTime2), 0, CAST(N'2018-06-20T14:49:10.2634649' AS DateTime2), 0, CAST(N'2018-06-20T14:49:10.2634649' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'/XUF/ryscbW2JIcLe1UaMgEbJ+TKhRY4EoUkgiPSyuM=', N'MSggRC3TRLhzIWI2ptqLmx5tuQokKwbNOnWnu9866hM=', 1, 0, CAST(N'2019-04-26T17:04:48.6496929' AS DateTime2), 0, CAST(N'2019-04-26T17:04:48.6496929' AS DateTime2), 0, CAST(N'2019-04-26T17:04:48.6496929' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'/XUF/ryscbW2JIcLe1UaMkBT4sx9EWyNzVh73gLRgsw=', N'MSggRC3TRLhzIWI2ptqLmx5tuQokKwbNOnWnu9866hM=', 2, 0, CAST(N'2019-04-26T17:04:48.7515677' AS DateTime2), 0, CAST(N'2019-04-26T17:04:48.7515677' AS DateTime2), 0, CAST(N'2019-04-26T17:04:48.7515677' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'/XUF/ryscbW2JIcLe1UaMo5iPOAjp6gUZSGSse8t1tw=', N'MSggRC3TRLhzIWI2ptqLmx5tuQokKwbNOnWnu9866hM=', 6, 0, CAST(N'2019-04-26T17:04:48.8575039' AS DateTime2), 0, CAST(N'2019-04-26T17:04:48.8575039' AS DateTime2), 0, CAST(N'2019-04-26T17:04:48.8575039' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'+JaVpNlOVoFE56k/infW+396xbwv+1U9hP+JXXzMnyE=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 2, 0, CAST(N'2018-06-21T09:14:52.4961790' AS DateTime2), 0, CAST(N'2018-06-21T09:14:52.4961790' AS DateTime2), 0, CAST(N'2018-06-21T09:14:52.4961790' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'+JaVpNlOVoFE56k/infW+5dqkqSjjEAmca8se53bTtk=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 10, 0, CAST(N'2018-06-21T09:14:03.1355735' AS DateTime2), 0, CAST(N'2018-06-21T09:14:03.1355735' AS DateTime2), 0, CAST(N'2018-06-21T09:14:03.1355735' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'+JaVpNlOVoFE56k/infW+78eQpOzFUlIsw6KqZR7nNA=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 12, 0, CAST(N'2018-06-21T09:14:46.9647875' AS DateTime2), 0, CAST(N'2018-06-21T09:14:46.9647875' AS DateTime2), 0, CAST(N'2018-06-21T09:14:46.9647875' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'+V5TFGDme8+2ee8j/3dK+7BvqAebm0M4oUgC9HwdwmY=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 39, 0, CAST(N'2018-06-21T09:12:05.7576798' AS DateTime2), 0, CAST(N'2018-06-21T09:12:05.7576798' AS DateTime2), 0, CAST(N'2018-06-21T09:12:05.7576798' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'+V5TFGDme8+2ee8j/3dK+w+X9WWhag+2x6py9PcFpYI=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 5, 0, CAST(N'2018-06-21T09:12:11.7109345' AS DateTime2), 0, CAST(N'2018-06-21T09:12:11.7109345' AS DateTime2), 0, CAST(N'2018-06-21T09:12:11.7109345' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'+V5TFGDme8+2ee8j/3dK+woQXvPj9zL20yYpvNGOgoU=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 6, 0, CAST(N'2018-06-21T09:12:44.2586214' AS DateTime2), 0, CAST(N'2018-06-21T09:12:44.2586214' AS DateTime2), 0, CAST(N'2018-06-21T09:12:44.2586214' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'+V5TFGDme8+2ee8j/3dK+zZpQErTrPNqlF8iVHArTsE=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 41, 0, CAST(N'2018-06-21T09:12:51.9775580' AS DateTime2), 0, CAST(N'2018-06-21T09:12:51.9775580' AS DateTime2), 0, CAST(N'2018-06-21T09:12:51.9775580' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'0SN18oOVwdvMDU1n1m3myyy05tDxB+jVbRBcaBpI9N0=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 2, 0, CAST(N'2018-06-20T14:48:38.1689201' AS DateTime2), 0, CAST(N'2018-06-20T14:48:38.1689201' AS DateTime2), 0, CAST(N'2018-06-20T14:48:38.1689201' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'3LkfFISkkiC6UBx2jbrQQ2YQCV49+O/DB42I4VnGyzA=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 35, 0, CAST(N'2018-06-21T09:10:06.5047156' AS DateTime2), 0, CAST(N'2018-06-21T09:10:06.5047156' AS DateTime2), 0, CAST(N'2018-06-21T09:10:06.5047156' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'3LkfFISkkiC6UBx2jbrQQ7LJ/O83qywOFzlHG1igK/g=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 36, 0, CAST(N'2018-06-21T09:10:30.1771749' AS DateTime2), 0, CAST(N'2018-06-21T09:10:30.1771749' AS DateTime2), 0, CAST(N'2018-06-21T09:10:30.1771749' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'3LkfFISkkiC6UBx2jbrQQwY4so3Za7YXOu/sxLFKv8c=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 36, 0, CAST(N'2018-06-21T09:10:23.2395050' AS DateTime2), 0, CAST(N'2018-06-21T09:10:23.2395050' AS DateTime2), 0, CAST(N'2018-06-21T09:10:23.2395050' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'4g0u47bXNM5l+Sj6lf9fV1C6aMnJGHh9JrTmhZmQGLE=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 9, 0, CAST(N'2018-06-21T09:13:29.1503618' AS DateTime2), 0, CAST(N'2018-06-21T09:13:29.1503618' AS DateTime2), 0, CAST(N'2018-06-21T09:13:29.1503618' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'4g0u47bXNM5l+Sj6lf9fV4N83jXmTnQbOYybUCxCb1k=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 43, 0, CAST(N'2018-06-21T09:13:50.9477790' AS DateTime2), 0, CAST(N'2018-06-21T09:13:50.9477790' AS DateTime2), 0, CAST(N'2018-06-21T09:13:50.9477790' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'4g0u47bXNM5l+Sj6lf9fV8oi7OqnrHt0FuXqRQos4Mc=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 42, 0, CAST(N'2018-06-21T09:13:41.9944240' AS DateTime2), 0, CAST(N'2018-06-21T09:13:41.9944240' AS DateTime2), 0, CAST(N'2018-06-21T09:13:41.9944240' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'5KhX2Fi4UjiMNMAnyEpnabapkuAAUzDANagbg6YIamA=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 29, 0, CAST(N'2018-06-21T09:07:50.7044756' AS DateTime2), 0, CAST(N'2018-06-21T09:07:50.7044756' AS DateTime2), 0, CAST(N'2018-06-21T09:07:50.7044756' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'5KhX2Fi4UjiMNMAnyEpnadmrMp8WwAQWZiDGMsbTmnQ=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 28, 0, CAST(N'2018-06-21T09:07:36.7822576' AS DateTime2), 0, CAST(N'2018-06-21T09:07:36.7822576' AS DateTime2), 0, CAST(N'2018-06-21T09:07:36.7822576' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'5KhX2Fi4UjiMNMAnyEpnaSSFDX7W9a8xwS+iqix0Qxk=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 27, 0, CAST(N'2018-06-21T09:07:18.0317910' AS DateTime2), 0, CAST(N'2018-06-21T09:07:18.0317910' AS DateTime2), 0, CAST(N'2018-06-21T09:07:18.0317910' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'5KhX2Fi4UjiMNMAnyEpnaWopOhxQrs/dW7DhLhf5Q9I=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 22, 0, CAST(N'2018-06-21T09:07:45.9699857' AS DateTime2), 0, CAST(N'2018-06-21T09:07:45.9699857' AS DateTime2), 0, CAST(N'2018-06-21T09:07:45.9699857' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'5KhX2Fi4UjiMNMAnyEpnaXmwqcOXYuAHNp6R+I1/z9k=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 21, 0, CAST(N'2018-06-21T09:07:27.1726464' AS DateTime2), 0, CAST(N'2018-06-21T09:07:27.1726464' AS DateTime2), 0, CAST(N'2018-06-21T09:07:27.1726464' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'7KA86sKbFQO4WEBLKVWNngeLIUExoTVI6Ag6ye3J8E8=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 4, 1, CAST(N'2019-04-26T17:31:54.8121684' AS DateTime2), 0, CAST(N'2018-06-21T09:26:10.9826607' AS DateTime2), 1, CAST(N'2019-04-26T17:31:54.8121684' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'7KA86sKbFQO4WEBLKVWNnmpb7Byg79N3euxkBsPDqAk=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 13, 0, CAST(N'2018-06-21T09:26:19.0453682' AS DateTime2), 0, CAST(N'2018-06-21T09:26:19.0453682' AS DateTime2), 0, CAST(N'2018-06-21T09:26:19.0453682' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8M9/F/y4kg6Q4/jsYBfnD0DxodFypKk47HRSz6LeNF8=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 8, 0, CAST(N'2018-06-21T08:59:38.7375218' AS DateTime2), 0, CAST(N'2018-06-21T08:59:38.7375218' AS DateTime2), 0, CAST(N'2018-06-21T08:59:38.7375218' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8M9/F/y4kg6Q4/jsYBfnD2Wpfs9BzO4GzluzWZ8xPxY=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 9, 0, CAST(N'2018-06-21T08:59:54.2066593' AS DateTime2), 0, CAST(N'2018-06-21T08:59:54.2066593' AS DateTime2), 0, CAST(N'2018-06-21T08:59:54.2066593' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8M9/F/y4kg6Q4/jsYBfnDyN1swN+hzTmfc6nqksp99o=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 7, 0, CAST(N'2018-06-21T08:59:16.4713500' AS DateTime2), 0, CAST(N'2018-06-21T08:59:16.4713500' AS DateTime2), 0, CAST(N'2018-06-21T08:59:16.4713500' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZena3Ot44wTbqh9nyrdKjAUno=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 66, 0, CAST(N'2019-06-09T09:29:06.4004768' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.4004768' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.4004768' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenaB+QJSYdipC4D99O3yZcWs=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 86, 0, CAST(N'2019-06-09T09:29:08.8209708' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.8209708' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.8209708' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenahlInmCVViJX2wssn1CIRk=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 84, 0, CAST(N'2019-06-09T09:29:08.5831204' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.5831204' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.5831204' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenb+6FicR2pyie2d1I+tilUc=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 83, 0, CAST(N'2019-06-09T09:29:08.4551986' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.4551986' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.4551986' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenb4y+MTeDkJCQtqnvG8XN+U=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 58, 0, CAST(N'2019-06-09T09:29:05.4450683' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.4450683' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.4450683' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenc75GN1Yp0aYAtI0nfVsWxI=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 63, 0, CAST(N'2019-06-09T09:29:06.0357018' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.0357018' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.0357018' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZencEKw1jA0oXj8YqUZipKQMM=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 82, 0, CAST(N'2019-06-09T09:29:08.3162861' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.3162861' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.3162861' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZencnJlb+7Gv8IusS385mA6yQ=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 68, 0, CAST(N'2019-06-09T09:29:06.6293337' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.6293337' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.6293337' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZencWUKFBUGC3vI4CLR4qdja0=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 67, 0, CAST(N'2019-06-09T09:29:06.5114069' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.5114069' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.5114069' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenczYUdC+RGPYVeTh2Wv7Khc=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 94, 0, CAST(N'2019-06-09T09:29:09.7923679' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.7923679' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.7923679' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZendd9P7QHKnlxI3fUO0eOrLs=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 78, 0, CAST(N'2019-06-09T09:29:07.8205934' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.8205934' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.8205934' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZendnmmVi9NAYLfGjR6Aq0u3Y=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 85, 0, CAST(N'2019-06-09T09:29:08.6970495' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.6970495' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.6970495' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenel8qV4lYhUCY6rhoU8P9Wo=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 61, 0, CAST(N'2019-06-09T09:29:05.7958514' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.7958514' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.7958514' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenfa306Fui3LHrsDliURdS4Y=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 77, 0, CAST(N'2019-06-09T09:29:07.6996683' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.6996683' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.6996683' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenfgTyKcWIazatKFXItSAsR8=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 47, 0, CAST(N'2019-06-09T09:29:04.4646775' AS DateTime2), 0, CAST(N'2019-06-09T09:29:04.4646775' AS DateTime2), 0, CAST(N'2019-06-09T09:29:04.4646775' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenfIGV0o0xewBzxdQ7ow4INI=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 88, 0, CAST(N'2019-06-09T09:29:09.0608224' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.0608224' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.0608224' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenfZKOWFxa+Ohle7M74uN0CU=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 89, 0, CAST(N'2019-06-09T09:29:09.1927417' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.1927417' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.1927417' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenQ+ZKgU3c2Uwy46iDM8/F5U=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 62, 0, CAST(N'2019-06-09T09:29:05.9157766' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.9157766' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.9157766' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenQEBa4m+ZJEBi960NKqg4fA=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 96, 0, CAST(N'2019-06-09T09:29:10.0302203' AS DateTime2), 0, CAST(N'2019-06-09T09:29:10.0302203' AS DateTime2), 0, CAST(N'2019-06-09T09:29:10.0302203' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenQeh8fEQ7suACuwqVcHjNJE=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 73, 0, CAST(N'2019-06-09T09:29:07.2289610' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.2289610' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.2289610' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenR7x0ay26Z/30XI7o1X1J7s=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 72, 0, CAST(N'2019-06-09T09:29:07.1230268' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.1230268' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.1230268' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenSjTWNuGL5KDEMp9bCXeTt8=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 53, 0, CAST(N'2019-06-09T09:29:04.8554351' AS DateTime2), 0, CAST(N'2019-06-09T09:29:04.8554351' AS DateTime2), 0, CAST(N'2019-06-09T09:29:04.8554351' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenSvGxQHcHKXdt8ol3iUGAOU=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 52, 0, CAST(N'2019-06-09T09:29:04.7195197' AS DateTime2), 0, CAST(N'2019-06-09T09:29:04.7195197' AS DateTime2), 0, CAST(N'2019-06-09T09:29:04.7195197' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenT+0Y2eH9uy3o/vNAq+hYTU=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 80, 0, CAST(N'2019-06-09T09:29:08.0524499' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.0524499' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.0524499' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenTXtaGy2gobuv3ILOMa+unA=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 56, 0, CAST(N'2019-06-09T09:29:05.2062187' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.2062187' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.2062187' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenTyIf26Uz4OmCiZx5KCYhzs=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 91, 0, CAST(N'2019-06-09T09:29:09.4505802' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.4505802' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.4505802' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenUEqxh0zM5wKLW9uUHJvAeM=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 97, 0, CAST(N'2019-06-09T09:29:10.1871233' AS DateTime2), 0, CAST(N'2019-06-09T09:29:10.1871233' AS DateTime2), 0, CAST(N'2019-06-09T09:29:10.1871233' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenUfNgc/Q4whC4vBmveEDZuA=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 65, 0, CAST(N'2019-06-09T09:29:06.2815506' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.2815506' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.2815506' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenUidR898VyIMYZ6HrOtI0BE=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 74, 0, CAST(N'2019-06-09T09:29:07.3528840' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.3528840' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.3528840' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenUw6+GmI/oZOjaxJk57lkCU=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 99, 0, CAST(N'2019-06-09T09:29:10.5239132' AS DateTime2), 0, CAST(N'2019-06-09T09:29:10.5239132' AS DateTime2), 0, CAST(N'2019-06-09T09:29:10.5239132' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenUXdLGU6eaRyMlEbaM/Os5o=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 100, 0, CAST(N'2019-06-09T09:29:10.6578308' AS DateTime2), 0, CAST(N'2019-06-09T09:29:10.6578308' AS DateTime2), 0, CAST(N'2019-06-09T09:29:10.6578308' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenVGYHfMfPPiyghal70uCMQU=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 98, 0, CAST(N'2019-06-09T09:29:10.3770057' AS DateTime2), 0, CAST(N'2019-06-09T09:29:10.3770057' AS DateTime2), 0, CAST(N'2019-06-09T09:29:10.3770057' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenVHHTlyGYmJZd2oa33n9juA=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 87, 0, CAST(N'2019-06-09T09:29:08.9468947' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.9468947' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.9468947' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenVJeR9yuQPfJ/+Ny7li6efs=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 59, 0, CAST(N'2019-06-09T09:29:05.5609968' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.5609968' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.5609968' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenVqvcOVXzOxkE0SvNNFga9U=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 75, 0, CAST(N'2019-06-09T09:29:07.4578177' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.4578177' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.4578177' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenVyPfB3TA5djJHXRLiQBRLs=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 60, 0, CAST(N'2019-06-09T09:29:05.6799230' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.6799230' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.6799230' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenWECv877L8X5ECoxyYn6Iws=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 70, 0, CAST(N'2019-06-09T09:29:06.8641861' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.8641861' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.8641861' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenWYCF3haKPyiAZViioZxypA=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 55, 0, CAST(N'2019-06-09T09:29:05.0912891' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.0912891' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.0912891' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenX51R0QnpzKFvwsrur2wamM=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 64, 0, CAST(N'2019-06-09T09:29:06.1626230' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.1626230' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.1626230' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenXducoH01bV65ESeOSZsky0=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 69, 0, CAST(N'2019-06-09T09:29:06.7492591' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.7492591' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.7492591' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenXLgDv2gmLaa+44owUTL6Cg=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 79, 0, CAST(N'2019-06-09T09:29:07.9305264' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.9305264' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.9305264' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenY2zmagQkadwgZ4nKqG2FrA=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 92, 0, CAST(N'2019-06-09T09:29:09.5595143' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.5595143' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.5595143' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenY6qTB+++YVjKaAoGjsWfwQ=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 76, 0, CAST(N'2019-06-09T09:29:07.5797428' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.5797428' AS DateTime2), 0, CAST(N'2019-06-09T09:29:07.5797428' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenYaOIZzm23CLEcPqm8JdATs=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 57, 0, CAST(N'2019-06-09T09:29:05.3231448' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.3231448' AS DateTime2), 0, CAST(N'2019-06-09T09:29:05.3231448' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenYLAr5IbIrn+ga3iAK7cHb4=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 54, 0, CAST(N'2019-06-09T09:29:04.9833555' AS DateTime2), 0, CAST(N'2019-06-09T09:29:04.9833555' AS DateTime2), 0, CAST(N'2019-06-09T09:29:04.9833555' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenYP0uEuCFL7BETZKuYe/AuY=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 90, 0, CAST(N'2019-06-09T09:29:09.3206606' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.3206606' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.3206606' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenYpHeVaZQgeSgyDBQMVW9es=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 71, 0, CAST(N'2019-06-09T09:29:06.9851119' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.9851119' AS DateTime2), 0, CAST(N'2019-06-09T09:29:06.9851119' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenYqUTOuW4fC2fHkBHChVN8o=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 81, 0, CAST(N'2019-06-09T09:29:08.1823689' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.1823689' AS DateTime2), 0, CAST(N'2019-06-09T09:29:08.1823689' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenZjtBpTEuVjjec4/zV3H4CU=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 95, 0, CAST(N'2019-06-09T09:29:09.9142916' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.9142916' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.9142916' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8t5MfZhuLE/Swb+yOiZenZo8L2Sf9tFz+Acu3KbbqsU=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 93, 0, CAST(N'2019-06-09T09:29:09.6744409' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.6744409' AS DateTime2), 0, CAST(N'2019-06-09T09:29:09.6744409' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'A1v3NJhS7Rkh1ptbjLT3zB1dozGfwHGXhm06GVKk3Us=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 14, 0, CAST(N'2018-06-21T09:05:20.8257683' AS DateTime2), 0, CAST(N'2018-06-21T09:05:20.8257683' AS DateTime2), 0, CAST(N'2018-06-21T09:05:20.8257683' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'A1v3NJhS7Rkh1ptbjLT3zHqYieu3Lr4k37oOj6q6Kpk=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 21, 0, CAST(N'2018-06-21T09:05:00.0127537' AS DateTime2), 0, CAST(N'2018-06-21T09:05:00.0127537' AS DateTime2), 0, CAST(N'2018-06-21T09:05:00.0127537' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'A1v3NJhS7Rkh1ptbjLT3zKJnvksnhyVO7Vz4+vG01BM=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 23, 0, CAST(N'2018-06-21T09:05:48.2952095' AS DateTime2), 0, CAST(N'2018-06-21T09:05:48.2952095' AS DateTime2), 0, CAST(N'2018-06-21T09:05:48.2952095' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'A1v3NJhS7Rkh1ptbjLT3zLCrFZf8COD/hWXsh36haAA=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 15, 0, CAST(N'2018-06-21T09:05:39.7637317' AS DateTime2), 0, CAST(N'2018-06-21T09:05:39.7637317' AS DateTime2), 0, CAST(N'2018-06-21T09:05:39.7637317' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'A1v3NJhS7Rkh1ptbjLT3zP/RibkYx5nYPqif1hqm15I=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 22, 0, CAST(N'2018-06-21T09:05:31.3729076' AS DateTime2), 0, CAST(N'2018-06-21T09:05:31.3729076' AS DateTime2), 0, CAST(N'2018-06-21T09:05:31.3729076' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Bc/MrnAieHi3dkTsGKXMw0xvWXiH03QHkMLrqTDXc4M=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 9, 1, CAST(N'2019-04-26T17:31:54.9420886' AS DateTime2), 0, CAST(N'2018-06-21T09:33:02.7116005' AS DateTime2), 1, CAST(N'2019-04-26T17:31:54.9420886' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Bc/MrnAieHi3dkTsGKXMw3HnVm8P+ce3pz1Hmava++w=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 20, 0, CAST(N'2018-06-21T09:33:50.5096583' AS DateTime2), 0, CAST(N'2018-06-21T09:33:50.5096583' AS DateTime2), 0, CAST(N'2018-06-21T09:33:50.5096583' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Bc/MrnAieHi3dkTsGKXMw4svh9WTk7HB0KzOBe2K8DE=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 10, 1, CAST(N'2019-04-26T17:31:55.0280344' AS DateTime2), 0, CAST(N'2018-06-21T09:33:40.4625350' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.0280344' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Bc/MrnAieHi3dkTsGKXMw6QC3xyzi3J6Ww1JvJnCf4g=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 17, 0, CAST(N'2018-06-21T09:33:13.7118825' AS DateTime2), 0, CAST(N'2018-06-21T09:33:13.7118825' AS DateTime2), 0, CAST(N'2018-06-21T09:33:13.7118825' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Bc/MrnAieHi3dkTsGKXMw6wuuYCVIvGT/oLTRgxKmug=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 18, 0, CAST(N'2018-06-21T09:33:31.2435571' AS DateTime2), 0, CAST(N'2018-06-21T09:33:31.2435571' AS DateTime2), 0, CAST(N'2018-06-21T09:33:31.2435571' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'd8QdoXCysA17PSMsVIMaGATAQyzRkIDjonQi7R+rAks=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 1, 0, CAST(N'2018-06-20T13:12:19.9517277' AS DateTime2), 0, CAST(N'2018-06-20T13:12:19.9517277' AS DateTime2), 0, CAST(N'2018-06-20T13:12:19.9517277' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'd8QdoXCysA17PSMsVIMaGF70EufrdPjtPwn01I1Owzw=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 3, 0, CAST(N'2018-06-20T13:12:20.0923560' AS DateTime2), 0, CAST(N'2018-06-20T13:12:20.0923560' AS DateTime2), 0, CAST(N'2018-06-20T13:12:20.0923560' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'dOXYJ0rJjst1NRQOLwlrijYx6W+qsAamwbVemi2zEpI=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 20, 1, CAST(N'2019-04-26T17:31:55.1039893' AS DateTime2), 0, CAST(N'2018-06-21T09:37:03.8738251' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.1039893' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'dRe8VZxChaOqrO1epqBP02T5JzWXCbR7nYDKE0dnibE=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 15, 1, CAST(N'2019-04-26T17:31:55.1729446' AS DateTime2), 0, CAST(N'2018-06-21T09:35:15.6836426' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.1729446' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'dRe8VZxChaOqrO1epqBP09ZSeGRPiOKp+mzKlpGP7bY=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 25, 0, CAST(N'2018-06-21T09:35:37.2623010' AS DateTime2), 0, CAST(N'2018-06-21T09:35:37.2623010' AS DateTime2), 0, CAST(N'2018-06-21T09:35:37.2623010' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'dRe8VZxChaOqrO1epqBP0zoBI5aF4Ue+HEF743bbvTU=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 24, 0, CAST(N'2018-06-21T09:35:09.2616175' AS DateTime2), 0, CAST(N'2018-06-21T09:35:09.2616175' AS DateTime2), 0, CAST(N'2018-06-21T09:35:09.2616175' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'gDHl/bQNzIBMdvqZL8aqhg1J5fp9HXjVb0G6xlzDOMg=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 31, 0, CAST(N'2018-06-21T09:08:41.9401191' AS DateTime2), 0, CAST(N'2018-06-21T09:08:41.9401191' AS DateTime2), 0, CAST(N'2018-06-21T09:08:41.9401191' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'gDHl/bQNzIBMdvqZL8aqhhktGFH9OrpNLXgDBmG+OVY=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 30, 0, CAST(N'2018-06-21T09:08:18.0332806' AS DateTime2), 0, CAST(N'2018-06-21T09:08:18.0332806' AS DateTime2), 0, CAST(N'2018-06-21T09:08:18.0332806' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'gDHl/bQNzIBMdvqZL8aqhnlm0/K3E+jAxVh/Tku4iwo=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 23, 0, CAST(N'2018-06-21T09:08:12.0331261' AS DateTime2), 0, CAST(N'2018-06-21T09:08:12.0331261' AS DateTime2), 0, CAST(N'2018-06-21T09:08:12.0331261' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'gDHl/bQNzIBMdvqZL8aqhs8kapFkCorGV7WvP+FEp6w=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 24, 0, CAST(N'2018-06-21T09:08:27.0178848' AS DateTime2), 0, CAST(N'2018-06-21T09:08:27.0178848' AS DateTime2), 0, CAST(N'2018-06-21T09:08:27.0178848' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'gDHl/bQNzIBMdvqZL8aqhsbUoXasrQ+RlMmLHWRAUVI=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 25, 0, CAST(N'2018-06-21T09:08:48.9715501' AS DateTime2), 0, CAST(N'2018-06-21T09:08:48.9715501' AS DateTime2), 0, CAST(N'2018-06-21T09:08:48.9715501' AS DateTime2))
GO
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'gkvCJmnjAalgJUoGo9IXTh1Z+k27ir+NNfEIzlb7QMc=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 17, 1, CAST(N'2019-04-26T17:31:55.2458994' AS DateTime2), 0, CAST(N'2018-06-21T09:36:05.7942576' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.2458994' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'gkvCJmnjAalgJUoGo9IXTpk1vwYckhVEP3oUkc8WYQM=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 27, 0, CAST(N'2018-06-21T09:36:51.7797687' AS DateTime2), 0, CAST(N'2018-06-21T09:36:51.7797687' AS DateTime2), 0, CAST(N'2018-06-21T09:36:51.7797687' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'gkvCJmnjAalgJUoGo9IXTr/iV+NkKM3k9Ov7ySP+Ds8=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 26, 0, CAST(N'2018-06-21T09:36:37.9513118' AS DateTime2), 0, CAST(N'2018-06-21T09:36:37.9513118' AS DateTime2), 0, CAST(N'2018-06-21T09:36:37.9513118' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'gkvCJmnjAalgJUoGo9IXTtnwN3+7OEPIndQsSLVpfZ4=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 18, 1, CAST(N'2019-04-26T17:31:55.3208528' AS DateTime2), 0, CAST(N'2018-06-21T09:36:42.9201767' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.3208528' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Gw6BIGfF+9KcvfNcm1ow2T/XGslh/Dslh6/ixCZ34i4=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 2, 0, CAST(N'2018-06-20T15:14:17.2584878' AS DateTime2), 0, CAST(N'2018-06-20T15:14:17.2584878' AS DateTime2), 0, CAST(N'2018-06-20T15:14:17.2584878' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'HhmSPhSz54zwS7NLzltBxp+yYEKoaq3Q/qQQT2773ps=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 7, 1, CAST(N'2019-04-26T17:31:55.3908100' AS DateTime2), 0, CAST(N'2018-08-28T13:51:50.4230686' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.3908100' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'HhmSPhSz54zwS7NLzltBxuL0Or/wALcMxsGNDYECf6Q=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 6, 1, CAST(N'2019-04-26T17:31:55.4607661' AS DateTime2), 0, CAST(N'2018-08-28T13:51:49.3682226' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.4607661' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IR/opzJtIbhmPnAYRPSm3Q2mkWMsv+8P4zIlPuODmBg=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 6, 0, CAST(N'2018-06-21T08:58:55.8458364' AS DateTime2), 0, CAST(N'2018-06-21T08:58:55.8458364' AS DateTime2), 0, CAST(N'2018-06-21T08:58:55.8458364' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IR/opzJtIbhmPnAYRPSm3SA5XgCwgWaioOdUMiPbOj8=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 3, 0, CAST(N'2018-06-21T08:58:05.9227356' AS DateTime2), 0, CAST(N'2018-06-21T08:58:05.9227356' AS DateTime2), 0, CAST(N'2018-06-21T08:58:05.9227356' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IR/opzJtIbhmPnAYRPSm3VRO3F55KeC78/jIgqfpT8Y=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 4, 0, CAST(N'2018-06-21T08:58:25.2357016' AS DateTime2), 0, CAST(N'2018-06-21T08:58:25.2357016' AS DateTime2), 0, CAST(N'2018-06-21T08:58:25.2357016' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IR/opzJtIbhmPnAYRPSm3WzDpTM+jBJceDtpDuYQ5+A=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 5, 0, CAST(N'2018-06-21T08:58:44.2674412' AS DateTime2), 0, CAST(N'2018-06-21T08:58:44.2674412' AS DateTime2), 0, CAST(N'2018-06-21T08:58:44.2674412' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IR/opzJtIbhmPnAYRPSm3ZXG1aW9ElPnZ5l9k3ill/s=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 2, 0, CAST(N'2018-06-21T08:58:04.6102134' AS DateTime2), 0, CAST(N'2018-06-21T08:58:04.6102134' AS DateTime2), 0, CAST(N'2018-06-21T08:58:04.6102134' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IVRj9Ln0znE5anMELwxyd+aRiY2atUwm0nsS8/XNmZE=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 21, 0, CAST(N'2018-06-21T09:34:22.9948358' AS DateTime2), 0, CAST(N'2018-06-21T09:34:22.9948358' AS DateTime2), 0, CAST(N'2018-06-21T09:34:22.9948358' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IVRj9Ln0znE5anMELwxyd+CGZRMFGAZz5E5hd8IfHU4=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 13, 0, CAST(N'2018-06-21T09:34:29.1824872' AS DateTime2), 0, CAST(N'2018-06-21T09:34:29.1824872' AS DateTime2), 0, CAST(N'2018-06-21T09:34:29.1824872' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IVRj9Ln0znE5anMELwxyd481KnuPUPN4W7fJDvNyyMY=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 11, 1, CAST(N'2019-04-26T17:31:55.5327210' AS DateTime2), 0, CAST(N'2018-06-21T09:34:03.4943627' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.5327210' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IVRj9Ln0znE5anMELwxyd6OnUopao1AVzAGqWC86rvw=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 22, 0, CAST(N'2018-06-21T09:34:40.1983902' AS DateTime2), 0, CAST(N'2018-06-21T09:34:40.1983902' AS DateTime2), 0, CAST(N'2018-06-21T09:34:40.1983902' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IVRj9Ln0znE5anMELwxydxUVZ5q07NA9GNJHMHJRcMI=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 14, 1, CAST(N'2019-04-26T17:31:55.6086747' AS DateTime2), 0, CAST(N'2018-06-21T09:34:59.7457704' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.6086747' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IVRj9Ln0znE5anMELwxydy0lfxJwJkdLzsefl9hTGb4=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 23, 0, CAST(N'2018-06-21T09:34:50.6986489' AS DateTime2), 0, CAST(N'2018-06-21T09:34:50.6986489' AS DateTime2), 0, CAST(N'2018-06-21T09:34:50.6986489' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'J5BSXGu9jQMPDW5qHTnyeGY4nOTNA3p9AQ4WylGHdqA=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 41, 0, CAST(N'2018-06-21T09:11:30.2724135' AS DateTime2), 0, CAST(N'2018-06-21T09:11:30.2724135' AS DateTime2), 0, CAST(N'2018-06-21T09:11:30.2724135' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'J5BSXGu9jQMPDW5qHTnyeHXHQuNnLaMUHtMN4LFqJGk=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 42, 0, CAST(N'2018-06-21T09:11:38.3819918' AS DateTime2), 0, CAST(N'2018-06-21T09:11:38.3819918' AS DateTime2), 0, CAST(N'2018-06-21T09:11:38.3819918' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'J5BSXGu9jQMPDW5qHTnyeM5+x2FA+46irBfWtBDICpo=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 38, 0, CAST(N'2018-06-21T09:11:24.8347795' AS DateTime2), 0, CAST(N'2018-06-21T09:11:24.8347795' AS DateTime2), 0, CAST(N'2018-06-21T09:11:24.8347795' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'J5BSXGu9jQMPDW5qHTnyeMDCWBmuA/+CeyLfJsCklWY=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 38, 0, CAST(N'2018-06-21T09:11:06.4905733' AS DateTime2), 0, CAST(N'2018-06-21T09:11:06.4905733' AS DateTime2), 0, CAST(N'2018-06-21T09:11:06.4905733' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'J5BSXGu9jQMPDW5qHTnyePiQoZI1CJLoleX6OPEIYdA=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 39, 0, CAST(N'2018-06-21T09:11:20.9440626' AS DateTime2), 0, CAST(N'2018-06-21T09:11:20.9440626' AS DateTime2), 0, CAST(N'2018-06-21T09:11:20.9440626' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'JL0prpGrVm00DCfPdY+omb/+Bs+h37hH3Ln46J1ZzGA=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 32, 0, CAST(N'2018-06-21T09:09:01.7687367' AS DateTime2), 0, CAST(N'2018-06-21T09:09:01.7687367' AS DateTime2), 0, CAST(N'2018-06-21T09:09:01.7687367' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'JL0prpGrVm00DCfPdY+omeWY8hwp/1lnWM6aTUiRox8=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 33, 0, CAST(N'2018-06-21T09:09:32.7070037' AS DateTime2), 0, CAST(N'2018-06-21T09:09:32.7070037' AS DateTime2), 0, CAST(N'2018-06-21T09:09:32.7070037' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'JL0prpGrVm00DCfPdY+omVKvaBfmy8yeIQ9lF+jNpSw=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 26, 0, CAST(N'2018-06-21T09:09:21.5661013' AS DateTime2), 0, CAST(N'2018-06-21T09:09:21.5661013' AS DateTime2), 0, CAST(N'2018-06-21T09:09:21.5661013' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'JL0prpGrVm00DCfPdY+omWoaMcZpr2N21ku3E+J2x9k=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 27, 0, CAST(N'2018-06-21T09:09:51.8793499' AS DateTime2), 0, CAST(N'2018-06-21T09:09:51.8793499' AS DateTime2), 0, CAST(N'2018-06-21T09:09:51.8793499' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'JL0prpGrVm00DCfPdY+omYoboIWu3xxaBvpyDg+5WFs=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 34, 0, CAST(N'2018-06-21T09:09:44.3322885' AS DateTime2), 0, CAST(N'2018-06-21T09:09:44.3322885' AS DateTime2), 0, CAST(N'2018-06-21T09:09:44.3322885' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'K1NouBWy5JP0e9hyIOvkeaUs+vw8oOtY6saUUwpOab4=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 5, 0, CAST(N'2018-06-21T09:01:30.6778020' AS DateTime2), 0, CAST(N'2018-06-21T09:01:30.6778020' AS DateTime2), 0, CAST(N'2018-06-21T09:01:30.6778020' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'K1NouBWy5JP0e9hyIOvkeawRh9VfTM4EKAoZCWHYL7E=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 13, 0, CAST(N'2018-06-21T09:01:41.7874503' AS DateTime2), 0, CAST(N'2018-06-21T09:01:41.7874503' AS DateTime2), 0, CAST(N'2018-06-21T09:01:41.7874503' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'K1NouBWy5JP0e9hyIOvkeeTyPOhmqbW7KfVP8RXuxr4=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 12, 0, CAST(N'2018-06-21T09:01:24.4276358' AS DateTime2), 0, CAST(N'2018-06-21T09:01:24.4276358' AS DateTime2), 0, CAST(N'2018-06-21T09:01:24.4276358' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'K1NouBWy5JP0e9hyIOvkeRZcP8LZnVdx2m7FpLUm7UY=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 4, 0, CAST(N'2018-06-21T09:01:14.2711377' AS DateTime2), 0, CAST(N'2018-06-21T09:01:14.2711377' AS DateTime2), 0, CAST(N'2018-06-21T09:01:14.2711377' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'K1NouBWy5JP0e9hyIOvkeXGvEu6Pi65u4MuLQLUfrpU=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 6, 0, CAST(N'2018-06-21T09:01:47.2719528' AS DateTime2), 0, CAST(N'2018-06-21T09:01:47.2719528' AS DateTime2), 0, CAST(N'2018-06-21T09:01:47.2719528' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'kIC0hSKs1Nv4c2rx7XYwPCRD0DTqMHyFyqCbT/y1VFY=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 24, 0, CAST(N'2018-06-21T09:06:15.1083624' AS DateTime2), 0, CAST(N'2018-06-21T09:06:15.1083624' AS DateTime2), 0, CAST(N'2018-06-21T09:06:15.1083624' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'kIC0hSKs1Nv4c2rx7XYwPDdRRcJh4ADcEXtxEYe7yHY=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 18, 0, CAST(N'2018-06-21T09:06:43.3434329' AS DateTime2), 0, CAST(N'2018-06-21T09:06:43.3434329' AS DateTime2), 0, CAST(N'2018-06-21T09:06:43.3434329' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'kIC0hSKs1Nv4c2rx7XYwPGIXRL6sqAt5cRLlITHzM6Q=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 20, 0, CAST(N'2018-06-21T09:06:58.3438079' AS DateTime2), 0, CAST(N'2018-06-21T09:06:58.3438079' AS DateTime2), 0, CAST(N'2018-06-21T09:06:58.3438079' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'kIC0hSKs1Nv4c2rx7XYwPJz6MMQefulrbWJXgw1ljKQ=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 25, 0, CAST(N'2018-06-21T09:06:30.5462422' AS DateTime2), 0, CAST(N'2018-06-21T09:06:30.5462422' AS DateTime2), 0, CAST(N'2018-06-21T09:06:30.5462422' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'kIC0hSKs1Nv4c2rx7XYwPNQYpDAXqVycGExjRefP504=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 26, 0, CAST(N'2018-06-21T09:06:48.1716797' AS DateTime2), 0, CAST(N'2018-06-21T09:06:48.1716797' AS DateTime2), 0, CAST(N'2018-06-21T09:06:48.1716797' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'kIC0hSKs1Nv4c2rx7XYwPNs1K+5OJOO7XuDonv8fUCc=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 17, 0, CAST(N'2018-06-21T09:06:23.8429538' AS DateTime2), 0, CAST(N'2018-06-21T09:06:23.8429538' AS DateTime2), 0, CAST(N'2018-06-21T09:06:23.8429538' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'kIC0hSKs1Nv4c2rx7XYwPNXZeP4GfHuoODlwREr/3Ug=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 16, 0, CAST(N'2018-06-21T09:06:06.9050345' AS DateTime2), 0, CAST(N'2018-06-21T09:06:06.9050345' AS DateTime2), 0, CAST(N'2018-06-21T09:06:06.9050345' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'KKzoB7qdhjtaDWYPZ87EuiV996mm8NwU/Nn6CJ6MeBI=', N'LlUxN+GQnDhnXdh5mCUMzjy2erqNfOIWC0BlANc1cwY=', 2, 0, CAST(N'2019-04-26T17:03:46.3955773' AS DateTime2), 0, CAST(N'2019-04-26T17:03:46.3955773' AS DateTime2), 0, CAST(N'2019-04-26T17:03:46.3955773' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'KKzoB7qdhjtaDWYPZ87Eujmv9D8WHG2Qid/cIleDtec=', N'LlUxN+GQnDhnXdh5mCUMzjy2erqNfOIWC0BlANc1cwY=', 21, 0, CAST(N'2019-04-26T17:03:46.6374275' AS DateTime2), 0, CAST(N'2019-04-26T17:03:46.6374275' AS DateTime2), 0, CAST(N'2019-04-26T17:03:46.6374275' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'KKzoB7qdhjtaDWYPZ87EunpSlYuLVb27xQF03D9Ezcw=', N'LlUxN+GQnDhnXdh5mCUMzjy2erqNfOIWC0BlANc1cwY=', 1, 0, CAST(N'2019-04-26T17:03:46.2476694' AS DateTime2), 0, CAST(N'2019-04-26T17:03:46.2476694' AS DateTime2), 0, CAST(N'2019-04-26T17:03:46.2476694' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'KKzoB7qdhjtaDWYPZ87EuvPXelToPqzoEQxMh4CRIDc=', N'LlUxN+GQnDhnXdh5mCUMzjy2erqNfOIWC0BlANc1cwY=', 6, 0, CAST(N'2019-04-26T17:03:46.5125059' AS DateTime2), 0, CAST(N'2019-04-26T17:03:46.5125059' AS DateTime2), 0, CAST(N'2019-04-26T17:03:46.5125059' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Kzym9LDH8kxnWWf3hJ5WldrDzmUkUKkttybx2dFldfY=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 11, 0, CAST(N'2018-06-21T09:03:45.1046605' AS DateTime2), 0, CAST(N'2018-06-21T09:03:45.1046605' AS DateTime2), 0, CAST(N'2018-06-21T09:03:45.1046605' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Kzym9LDH8kxnWWf3hJ5WlQBiWQhanajE1pvraqI0nsM=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 9, 0, CAST(N'2018-06-21T09:03:18.6977565' AS DateTime2), 0, CAST(N'2018-06-21T09:03:18.6977565' AS DateTime2), 0, CAST(N'2018-06-21T09:03:18.6977565' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Kzym9LDH8kxnWWf3hJ5WlSeV3gMK2/08celdIyk+LJU=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 17, 0, CAST(N'2018-06-21T09:03:35.3544046' AS DateTime2), 0, CAST(N'2018-06-21T09:03:35.3544046' AS DateTime2), 0, CAST(N'2018-06-21T09:03:35.3544046' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Kzym9LDH8kxnWWf3hJ5WlW4c6y5e4xtg5M1xLM0rb+I=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 16, 0, CAST(N'2018-06-21T09:03:13.2601092' AS DateTime2), 0, CAST(N'2018-06-21T09:03:13.2601092' AS DateTime2), 0, CAST(N'2018-06-21T09:03:13.2601092' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Kzym9LDH8kxnWWf3hJ5WlZvi5ZD0E68w+BXs5PKO6mw=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 10, 0, CAST(N'2018-06-21T09:03:30.8074175' AS DateTime2), 0, CAST(N'2018-06-21T09:03:30.8074175' AS DateTime2), 0, CAST(N'2018-06-21T09:03:30.8074175' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgaMmeK3HqPiercnhLwaZhfk=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 33, 0, CAST(N'2018-02-22T08:57:40.1470000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:40.1470000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:40.1470000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgaxb+G6hzMTfDyW4Pj7vd+M=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 22, 0, CAST(N'2018-02-22T08:57:38.6000000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.6000000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.6000000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgbaYXHvJlv2gIosjWbNpKAc=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 13, 0, CAST(N'2018-02-22T08:57:37.5170000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.5170000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.5170000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgbxoy8JIvm/1sFePH9W6jI0=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 4, 0, CAST(N'2018-02-22T10:44:31.0400000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.6830000' AS DateTime2), 1, CAST(N'2018-02-22T10:44:41.8130000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgch0nJ9GRgN2u3BCZtM5lNM=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 10, 0, CAST(N'2018-02-22T08:57:37.2270000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.2270000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.2270000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgcy81/nTD19OKh8ZIwnhmbE=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 12, 0, CAST(N'2018-02-22T08:57:37.4170000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.4170000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.4170000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgdAmXRtokmVTDuekJcW/qQA=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 26, 0, CAST(N'2018-02-22T08:57:39.1630000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.1630000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.1630000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgdkxvlUzYEHW7WbNSMe0v3k=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 20, 0, CAST(N'2018-02-22T08:57:38.3170000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.3170000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.3170000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgdufX6TAW5DrvHj7KPQ4lQs=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 16, 0, CAST(N'2018-02-22T08:57:37.8230000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.8230000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.8230000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgdx2cRhLiVyG+02HIvUWurA=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 3, 0, CAST(N'2018-02-22T12:49:14.8700000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.5930000' AS DateTime2), 1, CAST(N'2018-02-22T12:50:41.5100000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWge2EbJlKLvp1r8h7ZUBW6Yw=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 21, 0, CAST(N'2018-02-22T08:57:38.4570000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.4570000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.4570000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgeGa/GCxfksk1agIY1BU7nM=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 9, 0, CAST(N'2018-02-22T08:57:37.1370000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.1370000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.1370000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgehSte/pDUfsOnLnDRlzsrw=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 11, 0, CAST(N'2018-02-22T08:57:37.3200000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.3200000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.3200000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgfqosS6aJbC5cTYPddsM8vM=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 31, 0, CAST(N'2018-02-22T08:57:39.8630000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.8630000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.8630000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgQCc7ZXG/2Bs4rQidLkYETA=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 35, 0, CAST(N'2018-02-22T08:57:40.4300000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:40.4300000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:40.4300000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgQNBsVtI7l7T44VlGPQXjYo=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 25, 0, CAST(N'2018-02-22T08:57:39.0230000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.0230000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.0230000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgQOuGooFRSawqAqVRXgmR4s=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 6, 0, CAST(N'2018-02-22T08:57:36.8600000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.8600000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.8600000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgRAIxqrJFJYo9ykn5JZoRPg=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 24, 0, CAST(N'2018-02-22T08:57:38.8830000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.8830000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.8830000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgRFEMRJTbJwsR1nCphBo0gA=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 23, 0, CAST(N'2018-02-22T08:57:38.7370000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.7370000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.7370000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgRLQ0YjZ3jf2YC9evrdPxyQ=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 8, 0, CAST(N'2018-02-22T08:57:37.0430000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.0430000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.0430000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgSYFUw6znZIpczFVOu5xggI=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 18, 0, CAST(N'2018-02-22T08:57:38.0370000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.0370000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.0370000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgTiCUL3janrKbzBIGoQWY1E=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 29, 0, CAST(N'2018-02-27T08:53:54.3500000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.5830000' AS DateTime2), 1, CAST(N'2018-02-27T08:55:24.7600000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgTOiINwN+BZTtbkBoMg6iMg=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 34, 0, CAST(N'2018-02-22T08:57:40.2900000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:40.2900000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:40.2900000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgV96QlNbQipEtj6FusIupHI=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 15, 0, CAST(N'2018-02-22T08:57:37.7000000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.7000000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.7000000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgVdSmAwHvIK0/ml0B1G1GqI=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 7, 0, CAST(N'2018-02-22T08:57:36.9500000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.9500000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.9500000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgVKSe4OdC67vaHalL1JKiR4=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 17, 0, CAST(N'2018-02-22T08:57:37.9170000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.9170000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.9170000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgVpAsgAazuk6glebHboZSss=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 19, 0, CAST(N'2018-02-22T08:57:38.1770000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.1770000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:38.1770000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgWdE/3aHzpirJMsU79hJhBM=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 32, 0, CAST(N'2018-02-22T08:57:40.0070000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:40.0070000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:40.0070000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgWuKPMrfh91KDIO0pqmL9m8=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 30, 0, CAST(N'2018-02-22T08:57:39.7230000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.7230000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.7230000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgX4bKkzHE2OsGO8HRXVTHVE=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 5, 0, CAST(N'2018-02-22T08:57:36.7730000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.7730000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.7730000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgX7idADGVmlRb4C6gWfrKvg=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 14, 0, CAST(N'2018-02-22T08:57:37.6100000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.6100000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:37.6100000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgXRQeoqairrrw0bFavlnmyw=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 1, 0, CAST(N'2018-06-07T15:53:23.4406097' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.4030000' AS DateTime2), 1, CAST(N'2018-06-07T15:54:17.0799162' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgYJpodj4IkhIVMvDfwddk34=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 27, 0, CAST(N'2018-02-22T08:57:39.3030000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.3030000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.3030000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgYv3LwK91+I+G14HaX8RF0o=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 28, 0, CAST(N'2018-02-22T08:57:39.4430000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.4430000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:39.4430000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'lTlmYWOC6zL6ax69uYRWgZfXcv4oH6XKM2hBNd+r0hc=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 2, 0, CAST(N'2018-02-22T08:57:36.5000000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.5000000' AS DateTime2), 0, CAST(N'2018-02-22T08:57:36.5000000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'M+54HFZPMmfIwf1hQJmMyVtg8rjyOfBFE8v/YfX5+Vc=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 11, 0, CAST(N'2018-06-21T09:00:47.2704675' AS DateTime2), 0, CAST(N'2018-06-21T09:00:47.2704675' AS DateTime2), 0, CAST(N'2018-06-21T09:00:47.2704675' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'M+54HFZPMmfIwf1hQJmMyZRmMEmTcQQ505AhEMgLDBM=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 10, 0, CAST(N'2018-06-21T09:00:10.1914205' AS DateTime2), 0, CAST(N'2018-06-21T09:00:10.1914205' AS DateTime2), 0, CAST(N'2018-06-21T09:00:10.1914205' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'M26TWDi2nSL4K6jBM1ikx6Ofl6nzrCFAM6ubzeBaldw=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 37, 1, CAST(N'2018-06-21T09:58:52.0702823' AS DateTime2), 0, CAST(N'2018-06-21T09:58:35.1479774' AS DateTime2), 1, CAST(N'2018-06-21T09:58:52.0702823' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'mKpO+borpW9vXRfUaTSAPdc6gfs1E4ldfhrHcXVgaSk=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 43, 0, CAST(N'2018-04-23T16:53:41.8230000' AS DateTime2), 0, CAST(N'2018-04-23T16:53:41.8230000' AS DateTime2), 0, CAST(N'2018-04-23T16:53:41.8230000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'oUe4C3Zhmfha/eC60IMj8aqYk0epxLFSk4UmPo2i5FM=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 13, 0, CAST(N'2018-06-21T09:04:45.6686441' AS DateTime2), 0, CAST(N'2018-06-21T09:04:45.6686441' AS DateTime2), 0, CAST(N'2018-06-21T09:04:45.6686441' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'oUe4C3Zhmfha/eC60IMj8ckJbU43En5Kf6dYM0R7xGA=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 19, 0, CAST(N'2018-06-21T09:04:38.9653557' AS DateTime2), 0, CAST(N'2018-06-21T09:04:38.9653557' AS DateTime2), 0, CAST(N'2018-06-21T09:04:38.9653557' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'oUe4C3Zhmfha/eC60IMj8dGa+oQEDu970b174KrJnrY=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 20, 0, CAST(N'2018-06-21T09:04:32.2620655' AS DateTime2), 0, CAST(N'2018-06-21T09:04:32.2620655' AS DateTime2), 0, CAST(N'2018-06-21T09:04:32.2620655' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'oUe4C3Zhmfha/eC60IMj8RYvsS6u6V+wGEFDfBo+3Cc=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 12, 0, CAST(N'2018-06-21T09:04:11.4959236' AS DateTime2), 0, CAST(N'2018-06-21T09:04:11.4959236' AS DateTime2), 0, CAST(N'2018-06-21T09:04:11.4959236' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'oUe4C3Zhmfha/eC60IMj8S7Ku8FocOJeqlsDjKIez6Y=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 18, 0, CAST(N'2018-06-21T09:04:02.0269395' AS DateTime2), 0, CAST(N'2018-06-21T09:04:02.0269395' AS DateTime2), 0, CAST(N'2018-06-21T09:04:02.0269395' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'p4MV00cAMt7vsBOcQAcun4y2ibRohvzRzNBGsPEdetY=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 1, 0, CAST(N'2018-06-20T13:21:16.0753155' AS DateTime2), 0, CAST(N'2018-06-20T13:21:16.0753155' AS DateTime2), 0, CAST(N'2018-06-20T13:21:16.0753155' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'R/B02kQ2BpFK3Cw6GsZ3L+HlA3cHS1IAtil7xdECf3o=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 42, 0, CAST(N'2018-02-26T12:39:11.4930000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:11.4930000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:11.4930000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'R/B02kQ2BpFK3Cw6GsZ3L+JkQceTEaMiTDN5wxskQHI=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 37, 0, CAST(N'2018-02-26T12:39:10.9370000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:10.9370000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:10.9370000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'R/B02kQ2BpFK3Cw6GsZ3L3G2VijhMKfbVDU9WkQ2OyU=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 36, 0, CAST(N'2018-02-26T12:39:10.7130000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:10.7130000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:10.7130000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'R/B02kQ2BpFK3Cw6GsZ3L6kV65rCgq+5q/XJX2D/HvI=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 40, 0, CAST(N'2018-02-26T12:39:11.3070000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:11.3070000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:11.3070000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'R/B02kQ2BpFK3Cw6GsZ3L6UKL5Y7WCj4HfEvMiu7QZU=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 39, 0, CAST(N'2018-02-26T12:39:11.2030000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:11.2030000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:11.2030000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'R/B02kQ2BpFK3Cw6GsZ3L7jT/UgsGiQTrMV5WeK27c4=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 38, 0, CAST(N'2018-02-26T12:39:11.0370000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:11.0370000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:11.0370000' AS DateTime2))
GO
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'R/B02kQ2BpFK3Cw6GsZ3L9EkZ/k/dP6kwwltFgXVATI=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 41, 0, CAST(N'2018-02-26T12:39:11.3930000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:11.3930000' AS DateTime2), 0, CAST(N'2018-02-26T12:39:11.3930000' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'UYH2EuGOQv2sCQ43wAKH3izyqbC5pvO5nKIegfmHanc=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 1, 0, CAST(N'2018-06-20T13:24:14.3609666' AS DateTime2), 0, CAST(N'2018-06-20T13:24:14.3609666' AS DateTime2), 0, CAST(N'2018-06-20T13:24:14.3609666' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'V8Vcz10pgne6wXVEzSAO1OwTOTQIIsbMANpDFkf1btg=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 5, 0, CAST(N'2018-06-21T09:28:15.0638603' AS DateTime2), 0, CAST(N'2018-06-21T09:28:15.0638603' AS DateTime2), 0, CAST(N'2018-06-21T09:28:15.0638603' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'VfRx7Uv/TASV0mLi+PyhHLfSXLmKXgqr2EswNnqHzUw=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 16, 0, CAST(N'2018-06-21T09:32:41.6016991' AS DateTime2), 0, CAST(N'2018-06-21T09:32:41.6016991' AS DateTime2), 0, CAST(N'2018-06-21T09:32:41.6016991' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'VfRx7Uv/TASV0mLi+PyhHOEG9Dsbhfyskf5vUJsvRjY=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 14, 0, CAST(N'2018-06-21T09:32:26.9450890' AS DateTime2), 0, CAST(N'2018-06-21T09:32:26.9450890' AS DateTime2), 0, CAST(N'2018-06-21T09:32:26.9450890' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'w9egO3OXLwLI/5cEyNi9i6huw9Lx3r/R14gRpnps28U=', N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', 1, 0, CAST(N'2018-06-20T14:07:05.6034017' AS DateTime2), 0, CAST(N'2018-06-20T14:07:05.6034017' AS DateTime2), 0, CAST(N'2018-06-20T14:07:05.6034017' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'x7s87mdyJL1moMk881F010e347GQ8KV1ip+7bP385UA=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 15, 0, CAST(N'2018-06-21T09:02:51.9939555' AS DateTime2), 0, CAST(N'2018-06-21T09:02:51.9939555' AS DateTime2), 0, CAST(N'2018-06-21T09:02:51.9939555' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'x7s87mdyJL1moMk881F014MNJU7BJ5L5b8WuauRlkPU=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 8, 0, CAST(N'2018-06-21T09:02:46.9313338' AS DateTime2), 0, CAST(N'2018-06-21T09:02:46.9313338' AS DateTime2), 0, CAST(N'2018-06-21T09:02:46.9313338' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'x7s87mdyJL1moMk881F016ZRGrNXwRGVLCCv9Zzi4RE=', N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', 14, 0, CAST(N'2018-06-21T09:02:32.0247145' AS DateTime2), 0, CAST(N'2018-06-21T09:02:32.0247145' AS DateTime2), 0, CAST(N'2018-06-21T09:02:32.0247145' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'x7s87mdyJL1moMk881F017BtcJ7/nHitP/JeOj7huNM=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 7, 0, CAST(N'2018-06-21T09:02:37.3217207' AS DateTime2), 0, CAST(N'2018-06-21T09:02:37.3217207' AS DateTime2), 0, CAST(N'2018-06-21T09:02:37.3217207' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'YOuYA23AgyzkvADRPMMWARA/1ZsPAbTw8+V1lUCU+Tc=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 21, 0, CAST(N'2018-06-21T09:41:00.6768389' AS DateTime2), 0, CAST(N'2018-06-21T09:41:00.6768389' AS DateTime2), 0, CAST(N'2018-06-21T09:41:00.6768389' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'YOuYA23AgyzkvADRPMMWAUAzQF5bfi2ovKPwfdrfC24=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 23, 1, CAST(N'2019-04-26T17:31:55.6886255' AS DateTime2), 0, CAST(N'2018-06-21T09:41:19.1147953' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.6886255' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'YOuYA23AgyzkvADRPMMWAWKLmPG/urHvYJVvIAdMl38=', N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', 25, 1, CAST(N'2019-04-26T17:31:55.7648538' AS DateTime2), 0, CAST(N'2018-06-21T09:41:29.6463027' AS DateTime2), 1, CAST(N'2019-04-26T17:31:55.7648538' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'ZeCKdwboXwdNDqnV1E+lLAgqZ9SkBkgy0VnkNZxIPv8=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 46, 0, CAST(N'2018-11-05T10:07:49.4551785' AS DateTime2), 0, CAST(N'2018-11-05T10:07:49.4551785' AS DateTime2), 0, CAST(N'2018-11-05T10:07:49.4551785' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'ZeCKdwboXwdNDqnV1E+lLAPDWiM5eJfdibzG/h4N+SQ=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 45, 0, CAST(N'2018-11-05T10:07:49.4421720' AS DateTime2), 0, CAST(N'2018-11-05T10:07:49.4421720' AS DateTime2), 0, CAST(N'2018-11-05T10:07:49.4421720' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'ZeCKdwboXwdNDqnV1E+lLB5413Z7MCJu3r++yoTIijk=', N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', 44, 0, CAST(N'2018-11-05T10:07:48.2391949' AS DateTime2), 0, CAST(N'2018-11-05T10:07:48.2391949' AS DateTime2), 0, CAST(N'2018-11-05T10:07:48.2391949' AS DateTime2))
INSERT [dbo].[ACCES] ([AccesID], [Role_RoleID], [Privilege_PrivilegeID], [IsRemoved], [DateRemoved], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'zVxfmaBpg14E2YR6Uvg30MowacTffeYIYn51NtJNgkM=', N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', 3, 0, CAST(N'2018-06-20T15:38:29.5537080' AS DateTime2), 0, CAST(N'2018-06-20T15:38:29.5537080' AS DateTime2), 0, CAST(N'2018-06-20T15:38:29.5537080' AS DateTime2))
INSERT [dbo].[ATTENTE] ([AttenteID], [Specialiste_UtilisateurID], [Patient_DossierID], [DateAttente], [Etat], [Statut], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'8OIy/SLIZODWDbDee2E2N5sdH5LWXevkFSMJ+kZjmZQ=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'S/mOQHRjA7/wvxaJsFRYlBluK2fT815XLVSc3llfgKU=', CAST(N'2019-05-08T09:41:48.0742983' AS DateTime2), 0, 1, 0, CAST(N'2019-05-08T09:41:48.0752971' AS DateTime2), 1, CAST(N'2019-05-08T09:50:55.5853531' AS DateTime2))
INSERT [dbo].[ATTENTE] ([AttenteID], [Specialiste_UtilisateurID], [Patient_DossierID], [DateAttente], [Etat], [Statut], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Bt//pzADUSPUmIugDmnKcfFxYcqybCCBj2HRWUcWlbg=', N'kEijK6KJkzxSJvPyiD5xVSYjMuhixElq9rZ1w2/4qcg=', N'mgVPBxHUN71xBAJi1VktYMV7HwatQmphO9oP0zxQAAY=', CAST(N'2019-06-09T21:35:44.8573434' AS DateTime2), 1, 1, 0, CAST(N'2019-06-09T21:35:44.8593397' AS DateTime2), 0, CAST(N'2019-06-09T21:35:44.8593397' AS DateTime2))
INSERT [dbo].[ATTENTE] ([AttenteID], [Specialiste_UtilisateurID], [Patient_DossierID], [DateAttente], [Etat], [Statut], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'JPv84NkkUDwuxzdc89iBFFE9diL5pt+KGgcyZfaXsFA=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'5hE20GJ8pddGm0GH0mQ4Y+zbMHEbRaH7wcrxPiRRkos=', CAST(N'2019-04-23T15:34:14.5994429' AS DateTime2), 1, 1, 0, CAST(N'2019-04-23T15:34:14.6004422' AS DateTime2), 0, CAST(N'2019-04-23T15:34:14.6014417' AS DateTime2))
INSERT [dbo].[ATTENTE] ([AttenteID], [Specialiste_UtilisateurID], [Patient_DossierID], [DateAttente], [Etat], [Statut], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'JPv84NkkUDwuxzdc89iBFONZwKzjBWymCOfIbTDtYiY=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'5hE20GJ8pddGm0GH0mQ4Y+zbMHEbRaH7wcrxPiRRkos=', CAST(N'2019-04-23T15:34:57.1830625' AS DateTime2), 1, 1, 0, CAST(N'2019-04-23T15:34:57.1830625' AS DateTime2), 0, CAST(N'2019-04-23T15:34:57.1830625' AS DateTime2))
INSERT [dbo].[ATTENTE] ([AttenteID], [Specialiste_UtilisateurID], [Patient_DossierID], [DateAttente], [Etat], [Statut], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'LQ4Y60QrqsqKJf9cifM4OAgnjlTq+rul19VTWKA/aj4=', N'Wh18JZShQpu6vEsqQVNxth+F5ZkDpHCB+SrcfrTeLi4=', N'mgVPBxHUN71xBAJi1VktYMV7HwatQmphO9oP0zxQAAY=', CAST(N'2019-05-03T14:47:30.5467922' AS DateTime2), 1, 1, 0, CAST(N'2019-05-03T14:47:30.5467922' AS DateTime2), 0, CAST(N'2019-05-03T14:47:30.5467922' AS DateTime2))
INSERT [dbo].[ATTENTE] ([AttenteID], [Specialiste_UtilisateurID], [Patient_DossierID], [DateAttente], [Etat], [Statut], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'SukrFbnKLIyrWWjE+N8oys0saFjy1Bl0BUfZ9wHCfxc=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'S/mOQHRjA7/wvxaJsFRYlBluK2fT815XLVSc3llfgKU=', CAST(N'2019-05-08T09:50:05.4636437' AS DateTime2), 1, 1, 0, CAST(N'2019-05-08T09:50:05.4636437' AS DateTime2), 0, CAST(N'2019-05-08T09:50:05.4636437' AS DateTime2))
INSERT [dbo].[ATTENTE] ([AttenteID], [Specialiste_UtilisateurID], [Patient_DossierID], [DateAttente], [Etat], [Statut], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Xjuqq7cIEIp0J8jP/31t8jzz7JsoK+wNZnnpTkLbgW8=', N'Wh28JZShQpu6vEsqQVNxth+F5ZkDpHCB+SrcfrTeLi4=', N'mgVPBxHUN71xBAJi1VktYMV7HwatQmphO9oP0zxQAAY=', CAST(N'2019-05-03T14:41:14.9540500' AS DateTime2), 1, 1, 0, CAST(N'2019-05-03T14:41:14.9560495' AS DateTime2), 0, CAST(N'2019-05-03T14:41:14.9560495' AS DateTime2))
INSERT [dbo].[ATTENTE] ([AttenteID], [Specialiste_UtilisateurID], [Patient_DossierID], [DateAttente], [Etat], [Statut], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'zWAM/1KYqwg6fdeaiEDzT3pE+cwUZ68m1me6X4l9+5w=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'SbmgZJ8F2wTsU+HVBpRP2TvcdNbCXNh3zENPDwN9/+o=', CAST(N'2019-04-16T14:32:09.9185833' AS DateTime2), 1, 1, 0, CAST(N'2019-04-16T14:32:09.9185833' AS DateTime2), 0, CAST(N'2019-04-16T14:32:09.9185833' AS DateTime2))
INSERT [dbo].[CAISSE] ([CaisseID], [IsOpen], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression], [hn]) VALUES (N'CYDhNnn+MLHNwYPe3LOoq1GY4gqMdTtJUFtQUNhnI/w=', 0, N'bIxACNS72iRp7SOOIWmypQ==                    ', CAST(N'2019-05-08T07:49:53.5529795' AS DateTime2), 0, 1, CAST(N'2019-05-15T09:41:18.2736265' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[CAISSE] ([CaisseID], [IsOpen], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression], [hn]) VALUES (N'IQ0dre4xQ60gOGYdcS7qrN5sbSmf7IWy19G3sisDwuE=', 1, N'1XIq0mZKDUYRgpQUjqU9qiuUhRs9vxz89H7gR9ZYUE8=', CAST(N'2019-05-15T09:41:44.5263278' AS DateTime2), 0, 1, CAST(N'2019-05-15T09:42:45.3663112' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'EjqaJEbqgA2ets2miatVSER9t2kE4wJvdIMz6abg7yA=')
INSERT [dbo].[CAISSEMOUVEMENT] ([CaisseMouvementID], [Caisse_CaisseID], [Direction], [Reference], [Montant], [Raison], [Commentaire], [EstValide], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'CaisseMouvement1                            ', N'Caisse1                      Caisse1        ', N'IN', N'001', CAST(100000 AS Decimal(15, 0)), N'entree', N'RAS', 1, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[CAISSEMOUVEMENT] ([CaisseMouvementID], [Caisse_CaisseID], [Direction], [Reference], [Montant], [Raison], [Commentaire], [EstValide], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'CaisseMouvement2                            ', N'Caisse2                                     ', N'IN', N'002', CAST(150000 AS Decimal(15, 0)), N'entree', N'RAS', 1, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[CAISSEMOUVEMENT] ([CaisseMouvementID], [Caisse_CaisseID], [Direction], [Reference], [Montant], [Raison], [Commentaire], [EstValide], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'CaisseMouvement3                            ', N'Caisse3                                     ', N'IN', N'003', CAST(20000 AS Decimal(15, 0)), N'entree', N'RAS', 1, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[CAISSEMOUVEMENT] ([CaisseMouvementID], [Caisse_CaisseID], [Direction], [Reference], [Montant], [Raison], [Commentaire], [EstValide], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'caisseMouvement4                            ', N'Caisse4                                     ', N'OUT', N'004', CAST(250000 AS Decimal(15, 0)), N'sortie', N'RAS', 1, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[CAISSEMOUVEMENT] ([CaisseMouvementID], [Caisse_CaisseID], [Direction], [Reference], [Montant], [Raison], [Commentaire], [EstValide], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'caisseMouvement5                            ', N'Caisse5                                     ', N'OUT', N'005', CAST(35000 AS Decimal(15, 0)), N'sortie', N'RAS', 1, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[CAISSEOUVERTUREFERMETURE] ([CaisseOuvertureFermetureID], [Caisse_CaisseID], [Utilisateur_UtilisateurID], [DateOuverture], [SoldeOuverture], [DateFermeture], [SoldeFermeture], [SoldeAttendu], [SoldeManquant], [TypeManquant], [CommentaireOuverture], [CommentaireFermeture], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'EjqaJEbqgA2ets2miatVSER9t2kE4wJvdIMz6abg7yA=', N'IQ0dre4xQ60gOGYdcS7qrN5sbSmf7IWy19G3sisDwuE=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'2019-05-15T09:42:45.2553804' AS DateTime2), CAST(200000 AS Decimal(15, 0)), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(0 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), NULL, N'Il y avait un manquant de 12500
J''ai trouvé la caisse n''est pas fermée ce matin.', NULL, CAST(N'2019-05-15T09:42:45.2553804' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[CAISSEOUVERTUREFERMETURE] ([CaisseOuvertureFermetureID], [Caisse_CaisseID], [Utilisateur_UtilisateurID], [DateOuverture], [SoldeOuverture], [DateFermeture], [SoldeFermeture], [SoldeAttendu], [SoldeManquant], [TypeManquant], [CommentaireOuverture], [CommentaireFermeture], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'karOzlAeG86E6hARW8UXSgFOmEecdu8eTDn3PVePXJc=', N'CYDhNnn+MLHNwYPe3LOoq1GY4gqMdTtJUFtQUNhnI/w=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'2019-05-13T11:31:27.4591192' AS DateTime2), CAST(0 AS Decimal(15, 0)), CAST(N'2019-05-15T09:41:17.7245921' AS DateTime2), CAST(450 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), NULL, NULL, NULL, CAST(N'2019-05-13T11:31:27.4591192' AS DateTime2), 0, 1, CAST(N'2019-05-15T09:41:17.7245921' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[CAISSEOUVERTUREFERMETURE] ([CaisseOuvertureFermetureID], [Caisse_CaisseID], [Utilisateur_UtilisateurID], [DateOuverture], [SoldeOuverture], [DateFermeture], [SoldeFermeture], [SoldeAttendu], [SoldeManquant], [TypeManquant], [CommentaireOuverture], [CommentaireFermeture], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'YTvnirQrpzSqZEnXY2HZnWHFIzuoHIYpR/hYb+/SeLo=', N'CYDhNnn+MLHNwYPe3LOoq1GY4gqMdTtJUFtQUNhnI/w=', N'Wh28JZShQpu6vEsqQVNxth+F5ZkDpHCB+SrcfrTeLi4=', CAST(N'2019-05-09T21:14:18.6453795' AS DateTime2), CAST(120000 AS Decimal(15, 0)), CAST(N'2019-05-09T21:16:35.7280293' AS DateTime2), CAST(300000 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(2300 AS Decimal(15, 0)), N'Frais Transport', N'J''ouvre la caisse principale avec 120000', N'Je ferme la caisse avec 300000 - 2300 = ', CAST(N'2019-05-09T21:14:18.6453795' AS DateTime2), 0, 1, CAST(N'2019-05-09T21:16:35.7280293' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (1, N'ATTENTE', N'ATT', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (2, N'DIAGNOSTIC', N'DIA', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (3, N'DOSSIER', N'DOS', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (4, N'GROSSESSE', N'GRO', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (5, N'GROUPECIBLE', N'GCE', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (6, N'GROUPEMALADIE', N'GME', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (7, N'LIAISONDOSSIERGROUPECIBLE', N'LDG', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (8, N'MALADIE', N'MAL', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (9, N'MODIFICATION', N'MOD', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (10, N'MODIFICATIONATTENTE', N'MAE', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (11, N'PARAMETRE', N'PAR', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (12, N'PERSONNE', N'PER', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (13, N'RAPPELRDV', N'RRV', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (14, N'RENDEZVOUS', N'REN', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (15, N'TRAITEMENT', N'TRA', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (16, N'TYPEGROUPE', N'TGE', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (17, N'UTILISATEUR', N'UTI', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (18, N'VISITEPRENATALE', N'VPE', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (19, N'ACCES', N'ACC', 0, NULL, 0, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (20, N'PRIVILEGE', N'PRI', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (21, N'ROLE', N'ROL', 0, NULL, 0, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (22, N'PRODUIT', N'PRO', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (23, N'STOCKDETAILS', N'STD', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (24, N'STOCKMOUVEMENT', N'STM', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (25, N'STOCKMOUVEMENTDETAILS', N'SMD', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (26, N'STOCKTRANSFERT', N'STR', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (27, N'STOCKTRANSFERTDETAILS', N'TSD', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (28, N'STOCK', N'STK', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (29, N'CAISSE', N'CAI', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (30, N'CAISSEMOUVEMENT', N'CMT', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (31, N'CAISSEOUVERTUREFERMETURE', N'COF', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (32, N'EXAMEN', N'EXA', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (33, N'EXAMENRESULTAT', N'EXR', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (34, N'EXAMENTYPE', N'EXT', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (35, N'FABRICANT', N'FAB', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (36, N'FACTURE', N'FAC', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (37, N'FACTUREDETAILS', N'FDS', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (38, N'INVENTAIRE', N'INV', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (39, N'INVENTAIREDETAILS', N'IND', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (40, N'LABORATOIRE', N'LAB', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (41, N'LABORATOIREOUTILS', N'LAO', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (42, N'LIVRAISON', N'LIV', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (43, N'MODEPAIEMENT', N'MDT', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (44, N'RAYON', N'RAY', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (45, N'REGLEMENT', N'REG', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (46, N'STOCKTYPE', N'STY', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (47, N'EXAMENMEDICAL', N'EXM', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (48, N'SERVICE', N'SER', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (49, N'EXAMENDETAILS', N'EDL', NULL, NULL, NULL, NULL)
INSERT [dbo].[CLETABLE] ([CleTableID], [NomTable], [DesignationTable], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (50, N'RESULTAT', N'RST', NULL, NULL, NULL, NULL)
INSERT [dbo].[DIAGNOSTIC] ([DiagnosticID], [Dossier_DossierID], [Auteur_UtilisateurID], [Maladie_MaladieID], [Avis], [DateDiagnostic], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'LpzmVwXzqxgfozfsTILOfjZhwfYYL1+9X3TANj/OaNE=', N'q9jvxB7YwT1jkz1bx7hd0+ib724tQkOCOLdlw+PmJ7w=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', NULL, N'nAZUEfct++UoPL18RIn9bw==', CAST(N'2019-06-09T21:37:58.5347634' AS DateTime2), 0, CAST(N'2019-06-09T21:37:58.5927254' AS DateTime2), 0, CAST(N'2019-06-09T21:37:58.5927254' AS DateTime2))
INSERT [dbo].[DIAGNOSTIC] ([DiagnosticID], [Dossier_DossierID], [Auteur_UtilisateurID], [Maladie_MaladieID], [Avis], [DateDiagnostic], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'tR+/BD4cao4z4ejKAfYHutUIRIPxQUX1vhxoX0dLqgw=', N'S/mOQHRjA7/wvxaJsFRYlBluK2fT815XLVSc3llfgKU=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', NULL, N'eB4TwZ4uFBpxJkgWzZVPgg==', CAST(N'2019-05-08T09:43:17.5001515' AS DateTime2), 0, CAST(N'2019-05-08T09:43:17.6515645' AS DateTime2), 0, CAST(N'2019-05-08T09:43:17.6515645' AS DateTime2))
INSERT [dbo].[DIAGNOSTIC] ([DiagnosticID], [Dossier_DossierID], [Auteur_UtilisateurID], [Maladie_MaladieID], [Avis], [DateDiagnostic], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Vgo9vuHhkC9O1I9RWiaoH8xzl06XsBC6K1WRgoI/CCw=', N'mgVPBxHUN71xBAJi1VktYMV7HwatQmphO9oP0zxQAAY=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', NULL, N'YRy9MbcIXPL6LBmutMDPK03Z90aGCgTD9fBxG/2mv33UmPi+Sqn7Fz6FEBlUOSv/WRKw/9znCXdwUrUS3C3EMQ==', CAST(N'2019-05-03T14:42:42.0240837' AS DateTime2), 0, CAST(N'2019-05-03T14:42:42.1460058' AS DateTime2), 0, CAST(N'2019-05-03T14:42:42.1460058' AS DateTime2))
INSERT [dbo].[DOSSIER] ([DossierID], [Createur_UtilisateurID], [Patient_PersonneID], [Code], [DateCreation], [Locked], [PenseBete], [DateArchivage], [Archived], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'0+GlYNbnL7qp6+8xBLFPB/DGWtWc6O/XPeCBeo0Ot6c=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'ynq2OT625S6PvAi+02NVYUdvjv7BGH/TFWWLAdIzU3k=', N'qlHuxzaGVEoBOtzECLyekIlMzKMHTca3oecAFwXbcqE=', CAST(N'2019-04-26T08:51:40.3477242' AS DateTime2), 0, N'Grippe chronique', CAST(N'2019-04-26T08:51:40.3477242' AS DateTime2), 0, 0, CAST(N'2019-04-26T08:51:40.3817026' AS DateTime2), 0, CAST(N'2019-04-26T08:51:40.3817026' AS DateTime2))
INSERT [dbo].[DOSSIER] ([DossierID], [Createur_UtilisateurID], [Patient_PersonneID], [Code], [DateCreation], [Locked], [PenseBete], [DateArchivage], [Archived], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'14xk+Qf8NXAQ4WB0RuQWreGcHTyzNbkAZEtnpiKM5xk=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'hStgtpMF+Sz81fl9ibjEjZdbIzxea+Y23O9z2URcZRI=', N'MSonOE6+8UZsLC7Hit4ra/xEZqNWFZOidMljwJSdVOo=', CAST(N'2019-04-23T19:30:30.6186821' AS DateTime2), 0, NULL, CAST(N'2019-04-23T19:30:30.6186821' AS DateTime2), 0, 0, CAST(N'2019-04-23T19:30:30.6606564' AS DateTime2), 0, CAST(N'2019-04-23T19:30:30.6606564' AS DateTime2))
INSERT [dbo].[DOSSIER] ([DossierID], [Createur_UtilisateurID], [Patient_PersonneID], [Code], [DateCreation], [Locked], [PenseBete], [DateArchivage], [Archived], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'5hE20GJ8pddGm0GH0mQ4Y+zbMHEbRaH7wcrxPiRRkos=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'oihHbviouqtXoJg2/AmDw1bSdFhtYaqFHxcDk9YSkJ0=', N'iIyVKzDr/2LdPE6Uuj2mJd6uW9Y4efLRhnPbvWaCasg=', CAST(N'2019-04-23T15:33:06.3094530' AS DateTime2), 0, N'Allergique au jus', CAST(N'2019-04-23T15:33:06.3094530' AS DateTime2), 0, 0, CAST(N'2019-04-23T15:33:06.3484289' AS DateTime2), 1, CAST(N'2019-05-12T11:35:02.2065605' AS DateTime2))
INSERT [dbo].[DOSSIER] ([DossierID], [Createur_UtilisateurID], [Patient_PersonneID], [Code], [DateCreation], [Locked], [PenseBete], [DateArchivage], [Archived], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'6FCMUeNSM0np3UB6i+PZs04DkuuLmp7b6LTEr8Om2Xs=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'33qYwCtyXyEz7CIynzuxVICF+TIQrXhGGoSj/n2GYM8=', N'ZElBi7blijiFXiMKs1nBGehj5Zrnnw57CHB2Nmwwx9w=', CAST(N'2019-04-26T08:42:26.3695084' AS DateTime2), 0, N'dfdf', CAST(N'2019-04-26T08:42:26.3695084' AS DateTime2), 0, 0, CAST(N'2019-04-26T08:42:26.3904950' AS DateTime2), 1, CAST(N'2019-04-26T08:43:47.7358822' AS DateTime2))
INSERT [dbo].[DOSSIER] ([DossierID], [Createur_UtilisateurID], [Patient_PersonneID], [Code], [DateCreation], [Locked], [PenseBete], [DateArchivage], [Archived], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'6hR5Klp3qDB0xpmWTtP70OFQADs3/XsTB0PN5WN+BeA=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'DsWOJPKG/jNWLIrUCCsI8zTQUxQlmSm0AfqM9kCljW8=', N'/7p3GV15vtIuAG2beloKkPF+LT1SRZjfXKDI8HhnhBA=', CAST(N'2019-04-26T09:04:45.1484941' AS DateTime2), 0, N'Vieux', CAST(N'2019-04-26T09:04:45.1484941' AS DateTime2), 0, 0, CAST(N'2019-04-26T09:04:45.2084561' AS DateTime2), 0, CAST(N'2019-04-26T09:04:45.2084561' AS DateTime2))
INSERT [dbo].[DOSSIER] ([DossierID], [Createur_UtilisateurID], [Patient_PersonneID], [Code], [DateCreation], [Locked], [PenseBete], [DateArchivage], [Archived], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'gVQ17e3MzCVD1Dd02PQNHIUAPAxCDNeZbP0CsGke6cA=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'Bw2s/BnNoq+RrEfvqBgMW4PtIg/oc/8d+F444Sr4crk=', N'uAIc5ogNZugPwNTjiMJNOLjL0yrTpzHGKLw7C2PulBQ=', CAST(N'2019-04-26T08:44:51.7626201' AS DateTime2), 0, N'etc', CAST(N'2019-04-26T08:44:51.7626201' AS DateTime2), 0, 0, CAST(N'2019-04-26T08:44:51.7656218' AS DateTime2), 0, CAST(N'2019-04-26T08:44:51.7656218' AS DateTime2))
INSERT [dbo].[DOSSIER] ([DossierID], [Createur_UtilisateurID], [Patient_PersonneID], [Code], [DateCreation], [Locked], [PenseBete], [DateArchivage], [Archived], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'mgVPBxHUN71xBAJi1VktYMV7HwatQmphO9oP0zxQAAY=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'/sMiNj0yf+dTHuEm/L3kdwRPBpvalL2d3jmMP3HZ+rs=', N'nWFGN9VQgGirB0QdwagNjjpYnkcr9zT+3gXKhhW2lqw=', CAST(N'2019-05-03T14:39:15.8397001' AS DateTime2), 0, N'Alergique au chat', CAST(N'2019-05-03T14:39:15.8397001' AS DateTime2), 0, 0, CAST(N'2019-05-03T14:39:15.9406379' AS DateTime2), 1, CAST(N'2019-05-03T14:40:18.6032002' AS DateTime2))
INSERT [dbo].[DOSSIER] ([DossierID], [Createur_UtilisateurID], [Patient_PersonneID], [Code], [DateCreation], [Locked], [PenseBete], [DateArchivage], [Archived], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'q9jvxB7YwT1jkz1bx7hd0+ib724tQkOCOLdlw+PmJ7w=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'K7FIX+BRuQiU0FKiNyqyNk55LSHjbKA8kYWLDVuv89U=', N'Q4GzUV6i2+AXqJgByhOQLAF2/FovaSnF9z813GpJ/HE=', CAST(N'2019-06-08T10:01:10.2461028' AS DateTime2), 0, NULL, CAST(N'2019-06-08T10:01:10.2461028' AS DateTime2), 0, 0, CAST(N'2019-06-08T10:01:10.3260519' AS DateTime2), 0, CAST(N'2019-06-08T10:01:10.3260519' AS DateTime2))
INSERT [dbo].[DOSSIER] ([DossierID], [Createur_UtilisateurID], [Patient_PersonneID], [Code], [DateCreation], [Locked], [PenseBete], [DateArchivage], [Archived], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'S/mOQHRjA7/wvxaJsFRYlBluK2fT815XLVSc3llfgKU=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'ElZ33/SDK4ZcQ+3W18kSBYRgtIJHb6m2R49dFgo/M0A=', N'NcCHKOeHwTFToOmZ+Cac79wHSh8J7IQndkVFVJlYZiM=', CAST(N'2019-05-08T09:40:17.0306049' AS DateTime2), 0, N'Allergiques à la bière', CAST(N'2019-05-08T09:40:17.0306049' AS DateTime2), 0, 0, CAST(N'2019-05-08T09:40:17.0715799' AS DateTime2), 0, CAST(N'2019-05-08T09:40:17.0715799' AS DateTime2))
INSERT [dbo].[DOSSIER] ([DossierID], [Createur_UtilisateurID], [Patient_PersonneID], [Code], [DateCreation], [Locked], [PenseBete], [DateArchivage], [Archived], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'SbmgZJ8F2wTsU+HVBpRP2TvcdNbCXNh3zENPDwN9/+o=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'/HG80d2RCAX9Aldj2cUtxnXOCeGj0EDAEJFyyw3+E5M=', N'+BkChdNT7sDqtjphEmuYPZgA7jLlQTW5s9tr/mxochs=', CAST(N'2019-04-16T14:31:08.5724254' AS DateTime2), 0, NULL, CAST(N'2019-04-16T14:31:08.5724254' AS DateTime2), 0, 0, CAST(N'2019-04-16T14:31:08.6402863' AS DateTime2), 0, CAST(N'2019-04-16T14:31:08.6402863' AS DateTime2))
INSERT [dbo].[EXAMEN] ([ExamenID], [Dossier_DossierID], [Utilisateur_UtilisateurID], [Service_ServiceID], [ExamenType_ExamenTypeID], [Diagnostic_DiagnosticID], [Reference], [DateExamen], [Description], [EstRealise], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'evdvfKgw8GCXOp7etUr8jNce/D9KppGAy3Q5NO/OXNY=', N'S/mOQHRjA7/wvxaJsFRYlBluK2fT815XLVSc3llfgKU=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'Service2                                    ', N'ExUXfDBKA33QmSuIaTqPHCC2q4cyL+jjFvfAxp8FLm4=', NULL, N'lsepsFK7Aqq0f5RT3vqKKFARiyrrPx05Va/onD/axgo=', CAST(N'2019-06-13T00:00:00.0000000' AS DateTime2), N'L''examen de Josue ciii, j''ai peur moi', 0, CAST(N'2019-06-04T14:04:56.0551390' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMEN] ([ExamenID], [Dossier_DossierID], [Utilisateur_UtilisateurID], [Service_ServiceID], [ExamenType_ExamenTypeID], [Diagnostic_DiagnosticID], [Reference], [DateExamen], [Description], [EstRealise], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'5hE20GJ8pddGm0GH0mQ4Y+zbMHEbRaH7wcrxPiRRkos=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'Service2                                    ', N'nRdRAvtNBamDPqhmuys/2vuK7MS1pCTkqBq3BGAMwy4=', N'tR+/BD4cao4z4ejKAfYHutUIRIPxQUX1vhxoX0dLqgw=', N'm6XOy/+qdR+u4871fQdr/dzVeghbQg1NK7kwQipJFx4=', CAST(N'2019-05-30T00:00:00.0000000' AS DateTime2), N'Hummmm', 0, CAST(N'2019-05-25T15:32:54.7151780' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMEN] ([ExamenID], [Dossier_DossierID], [Utilisateur_UtilisateurID], [Service_ServiceID], [ExamenType_ExamenTypeID], [Diagnostic_DiagnosticID], [Reference], [DateExamen], [Description], [EstRealise], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'uwI/lNmykKly+jC5xQI5G9uQvW3/uery6DzzVFar1kw=', N'q9jvxB7YwT1jkz1bx7hd0+ib724tQkOCOLdlw+PmJ7w=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'Service1                                    ', N'ExUXfDBKA33QmSuIaTqPHCC2q4cyL+jjFvfAxp8FLm4=', NULL, N'MOv3adBGDmA4CNbLHnhPCzzjxghi7N1cxUZyaVBhYI4=', CAST(N'2019-06-29T00:00:00.0000000' AS DateTime2), NULL, 0, CAST(N'2019-06-09T21:38:26.3807986' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMEN] ([ExamenID], [Dossier_DossierID], [Utilisateur_UtilisateurID], [Service_ServiceID], [ExamenType_ExamenTypeID], [Diagnostic_DiagnosticID], [Reference], [DateExamen], [Description], [EstRealise], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ZGyemCHpA+j/YbscjrcH+OSbepk0OjOjOMzhm3DKiSs=', N'S/mOQHRjA7/wvxaJsFRYlBluK2fT815XLVSc3llfgKU=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'Service1                                    ', N'ExUXfDBKA33QmSuIaTqPHCC2q4cyL+jjFvfAxp8FLm4=', N'Vgo9vuHhkC9O1I9RWiaoH8xzl06XsBC6K1WRgoI/CCw=', N'OG+lf//mqLCzCfkPw/aQ0RTpqujnUA8YAqXgf04BlUg=', CAST(N'2019-05-31T00:00:00.0000000' AS DateTime2), N'NJHG', 0, CAST(N'2019-05-25T15:30:30.0487529' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMENDETAILS] ([ExamenDetailsID], [Examen_ExamenID], [ExamenMedical_ExamenMedicalID], [DateCreation], [Description], [EstNegatif]) VALUES (N'1HxtVJs9EZ+oePaOHw+5AZT2IAVobCYPsa+PC9WCNeM=', N'evdvfKgw8GCXOp7etUr8jNce/D9KppGAy3Q5NO/OXNY=', N'UqwZzcO7OLA8OLPLQpxZcnp4anKVVtCvb40YkAyaHmQ=', CAST(N'2019-06-04T14:04:57.773' AS DateTime), NULL, 0)
INSERT [dbo].[EXAMENDETAILS] ([ExamenDetailsID], [Examen_ExamenID], [ExamenMedical_ExamenMedicalID], [DateCreation], [Description], [EstNegatif]) VALUES (N'BYkX8OyE17ybAWm0FPpvthfgTqQ4FGx/INKeMnJ7pOo=', N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'muS8529/esj8WO+nX0WxnQkw7ipc4h5ZXD8OB0Y7tO0=', CAST(N'2019-05-25T15:32:54.817' AS DateTime), NULL, 0)
INSERT [dbo].[EXAMENDETAILS] ([ExamenDetailsID], [Examen_ExamenID], [ExamenMedical_ExamenMedicalID], [DateCreation], [Description], [EstNegatif]) VALUES (N'y/OnVNa6VnpxO8pgXx1Rtmzd6VWC8P35+I8uAXjdavA=', N'uwI/lNmykKly+jC5xQI5G9uQvW3/uery6DzzVFar1kw=', N'muS8529/esj8WO+nX0WxnQkw7ipc4h5ZXD8OB0Y7tO0=', CAST(N'2019-06-09T21:38:26.473' AS DateTime), NULL, 0)
INSERT [dbo].[EXAMENDETAILS] ([ExamenDetailsID], [Examen_ExamenID], [ExamenMedical_ExamenMedicalID], [DateCreation], [Description], [EstNegatif]) VALUES (N'y/OnVNa6VnpxO8pgXx1RtnZJaUvDi87qPny3HbzsH9s=', N'uwI/lNmykKly+jC5xQI5G9uQvW3/uery6DzzVFar1kw=', N'UqwZzcO7OLA8OLPLQpxZcnp4anKVVtCvb40YkAyaHmQ=', CAST(N'2019-06-09T21:38:26.587' AS DateTime), NULL, 0)
INSERT [dbo].[EXAMENDETAILS] ([ExamenDetailsID], [Examen_ExamenID], [ExamenMedical_ExamenMedicalID], [DateCreation], [Description], [EstNegatif]) VALUES (N'yE5O11RJ+f0Byr6gIy12EQnWxxgRgELc7xEXsFyyBVY=', N'ZGyemCHpA+j/YbscjrcH+OSbepk0OjOjOMzhm3DKiSs=', N'UqwZzcO7OLA8OLPLQpxZcnp4anKVVtCvb40YkAyaHmQ=', CAST(N'2019-05-25T15:30:47.890' AS DateTime), NULL, 0)
INSERT [dbo].[EXAMENMEDICAL] ([ExamenMedicalID], [ExamenType_ExamenTypeID], [Code], [Libelle], [Description], [Prix], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'muS8529/esj8WO+nX0WxnQkw7ipc4h5ZXD8OB0Y7tO0=', N'ExUXfDBKA33QmSuIaTqPHCC2q4cyL+jjFvfAxp8FLm4=', N'Ameba', N'Ameba manni', N'Decription Ameba', CAST(5000 AS Decimal(18, 0)), CAST(N'2019-05-25T11:45:02.3220609' AS DateTime2), 0, 1, CAST(N'2019-05-25T14:52:12.6694116' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMENMEDICAL] ([ExamenMedicalID], [ExamenType_ExamenTypeID], [Code], [Libelle], [Description], [Prix], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'UqwZzcO7OLA8OLPLQpxZcnp4anKVVtCvb40YkAyaHmQ=', N'ExUXfDBKA33QmSuIaTqPHCC2q4cyL+jjFvfAxp8FLm4=', N'VIH', N'VIH SIDA', N'Infection au Virus VIH', CAST(1500 AS Decimal(18, 0)), CAST(N'2019-05-22T17:25:54.2509306' AS DateTime2), 0, 1, CAST(N'2019-05-25T15:10:52.1596984' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMENMEDICAL] ([ExamenMedicalID], [ExamenType_ExamenTypeID], [Code], [Libelle], [Description], [Prix], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'yO0sJTxtPE8rKsq7veyknKqV1+Xekwl1ATKlDrWJUF4=', N'ExUXfDBKA33QmSuIaTqPHCC2q4cyL+jjFvfAxp8FLm4=', N'AgHBs', N'AgHBs', N'Infection au Virus AgHBs', CAST(7500 AS Decimal(18, 0)), CAST(N'2019-05-22T22:50:37.9569704' AS DateTime2), 0, 1, CAST(N'2019-05-25T14:52:12.7473622' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMENRESULTAT] ([ExamenResultatID], [Examen_ExamenID], [Description], [DateResultat], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ExamenResultat1                             ', N'Examen1                                     ', N'Examen de sang', CAST(N'2019-04-01T08:30:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMENRESULTAT] ([ExamenResultatID], [Examen_ExamenID], [Description], [DateResultat], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ExamenResultat2                             ', N'Examen2                                     ', N'Examen VIH', CAST(N'2019-04-11T08:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMENRESULTAT] ([ExamenResultatID], [Examen_ExamenID], [Description], [DateResultat], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ExamenResultat3                             ', N'Examen3                                     ', N'Examen Typhïode', CAST(N'2019-04-21T10:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMENRESULTAT] ([ExamenResultatID], [Examen_ExamenID], [Description], [DateResultat], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ExamenResultat4                             ', N'Examen4                                     ', N'Examen des Sells', CAST(N'2019-05-01T10:30:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMENTYPE] ([ExamenTypeID], [Libelle], [Description], [Prix], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ExUXfDBKA33QmSuIaTqPHCC2q4cyL+jjFvfAxp8FLm4=', N'SEROLOGIE', N'LE TYPE 3 EST TYPE 3', CAST(2000 AS Decimal(15, 0)), CAST(N'2019-05-25T11:03:29.9787081' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EXAMENTYPE] ([ExamenTypeID], [Libelle], [Description], [Prix], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'nRdRAvtNBamDPqhmuys/2vuK7MS1pCTkqBq3BGAMwy4=', N'PARASITOLOGIE', N'LE TYPE 3 EST TYPE 3', CAST(2000 AS Decimal(15, 0)), CAST(N'2019-05-25T11:04:45.9700257' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[FABRICANT] ([FabricantID], [Nom], [Description], [Adresse], [Contact], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Fabricant1                                  ', N'eB4TwZ4uFBpxJkgWzZVPgg==', N'eB4TwZ4uFBpxJkgWzZVPgg==', N'eB4TwZ4uFBpxJkgWzZVPgg==', N'nhamadou1@gmail.com', CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[FACTURE] ([FactureID], [Dossier_DossierID], [Utilisateur_UtilisateurID], [Reference], [Montant], [EstValide], [EstPaye], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'6VmMY3rcMQMCthFjShmqNsfMwoOKj/ll3EgmeR0QrM4=', N'6hR5Klp3qDB0xpmWTtP70OFQADs3/XsTB0PN5WN+BeA=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'jRv59VlNWv8+bAhWYxbQ5D3mHfb2YYHxTwVs+QXhh40=', CAST(0 AS Decimal(15, 0)), 0, 1, CAST(N'2019-06-09T15:08:24.5173078' AS DateTime2), 0, 1, CAST(N'2019-06-09T21:18:56.2735367' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[FACTURE] ([FactureID], [Dossier_DossierID], [Utilisateur_UtilisateurID], [Reference], [Montant], [EstValide], [EstPaye], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'8nSwpWzUafWiYdEFUH0FdIQ31aa4mo9dXRPxrXWUo3Q=', N'q9jvxB7YwT1jkz1bx7hd0+ib724tQkOCOLdlw+PmJ7w=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'8W3Xh/98fq2uSrRRKcgU3B6G1mrosIfFNzn2lcotMAE=', CAST(0 AS Decimal(15, 0)), 0, 0, CAST(N'2019-06-09T14:56:57.9238918' AS DateTime2), 0, 1, CAST(N'2019-06-09T17:31:46.1947628' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[FACTURE] ([FactureID], [Dossier_DossierID], [Utilisateur_UtilisateurID], [Reference], [Montant], [EstValide], [EstPaye], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'JebAsg2iD4Wvmu5yhi5FPtG9j1NY+6mvVSDHPrN0hnw=', N'S/mOQHRjA7/wvxaJsFRYlBluK2fT815XLVSc3llfgKU=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'xzPPMXMc1utnhXf11igIZ7R3yB8gCynrVlarzobZvFs=', CAST(0 AS Decimal(15, 0)), 0, 0, CAST(N'2019-06-09T14:40:21.4823025' AS DateTime2), 0, 1, CAST(N'2019-06-09T17:34:00.4348469' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[FACTUREDETAILS] ([FactureDetailsID], [Facture_FactureID], [Produit_ProduitID], [Quantite], [PrixUnitaire], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'cf6S0/SbBLz5j1/+THizmOdcOHkTkEyaNqB0bQvqQ6o=', N'6VmMY3rcMQMCthFjShmqNsfMwoOKj/ll3EgmeR0QrM4=', N'R15H0520O0701190455P669                     ', 1, CAST(500 AS Decimal(15, 0)), CAST(N'2019-06-09T15:08:24.8600940' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[FACTUREDETAILS] ([FactureDetailsID], [Facture_FactureID], [Produit_ProduitID], [Quantite], [PrixUnitaire], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'fEtHJ3H8v2CBNjJ91K3v/SxhWqwqSgYdUTPXW/KTM7s=', N'JebAsg2iD4Wvmu5yhi5FPtG9j1NY+6mvVSDHPrN0hnw=', N'R15H0520O0701190455P669                     ', 1, CAST(200 AS Decimal(15, 0)), CAST(N'2019-06-09T14:42:19.3491277' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[FACTUREDETAILS] ([FactureDetailsID], [Facture_FactureID], [Produit_ProduitID], [Quantite], [PrixUnitaire], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'wVrqEdBZqwuPsLYMZwFWUlwsHgRoGlnW+TSEKWba92s=', N'8nSwpWzUafWiYdEFUH0FdIQ31aa4mo9dXRPxrXWUo3Q=', N'R15H0520O0701190455P669                     ', 1, CAST(700 AS Decimal(15, 0)), CAST(N'2019-06-09T14:56:58.2636817' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[FOURNISSEUR] ([FournisseurID], [Nom], [Adresse], [Telephone], [Fax], [Email], [EstActif], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Fournisseur1                                ', N'SANOFI', N'Douala, Cameroun', N'23722232565', N'23722232566', N'info@sanofi.com', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[FOURNISSEUR] ([FournisseurID], [Nom], [Adresse], [Telephone], [Fax], [Email], [EstActif], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Fournisseur2                                ', N'BIOPHARMA', N'Douala, Cameroun', N'23722586859', N'23722586852', N'info@biopharma', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[FOURNISSEUR] ([FournisseurID], [Nom], [Adresse], [Telephone], [Fax], [Email], [EstActif], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Fournisseur3                                ', N'HN', N'Dubai, Dubai', N'10123568564', N'10123568564', N'info@hn.net', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[FOURNISSEUR] ([FournisseurID], [Nom], [Adresse], [Telephone], [Fax], [Email], [EstActif], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Fournisseur4                                ', N'EPF', N'Qatar, Qatar', N'651364631631', N'54643214666', N'info@epf.net', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[FOURNISSEUR] ([FournisseurID], [Nom], [Adresse], [Telephone], [Fax], [Email], [EstActif], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Fournisseur5                                ', N'SAM', N'Emirates, Emirates', N'98464316646', N'56666516165', N'info@sam.net', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[GROSSESSE] ([GrossesseID], [Maternite_LiaisonDossierGroupeCibleID], [MedecinTraitant_UtilisateurID], [DateEnregistrement], [DateResultat], [Resultat], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'7aN5VBK3U/gjkQnLyoVioJc6oYJeyKz4Tty0+uRlCbQ=', N'q4VdlvRGHiFoJ3OLS5MO6oDBtkJonUXMBdjpKhf3pDc=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'2019-04-26T10:20:25.0444575' AS DateTime2), CAST(N'2019-04-26T10:20:25.0444575' AS DateTime2), 0, 0, CAST(N'2019-04-26T10:20:25.2994683' AS DateTime2), 0, CAST(N'2019-04-26T10:20:25.2994683' AS DateTime2))
INSERT [dbo].[GROSSESSE] ([GrossesseID], [Maternite_LiaisonDossierGroupeCibleID], [MedecinTraitant_UtilisateurID], [DateEnregistrement], [DateResultat], [Resultat], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'LesfA9iuQeLrX8P6pVbxrBBMpxiXGULDreHHa+WIWoY=', N'dlwJC1A8R/2zgGGLFFV414Vr89m2szEyHniwfI9GMfg=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'2019-05-08T09:16:34.2574245' AS DateTime2), CAST(N'2019-05-08T09:16:34.2574245' AS DateTime2), 0, 0, CAST(N'2019-05-08T09:16:34.5354026' AS DateTime2), 0, CAST(N'2019-05-08T09:16:34.5354026' AS DateTime2))
INSERT [dbo].[GROSSESSE] ([GrossesseID], [Maternite_LiaisonDossierGroupeCibleID], [MedecinTraitant_UtilisateurID], [DateEnregistrement], [DateResultat], [Resultat], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'omrGCiWlgVSuUAVu42F+zujcFhqAEdY9SIGej5gDW24=', N'IOlREB58vVCVuZROQYYBudi08vKaG9xC+GhPkQNo2h8=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2019-04-26T09:05:01.2246387' AS DateTime2), 0, CAST(N'2019-04-26T09:05:01.2246387' AS DateTime2))
INSERT [dbo].[GROSSESSE] ([GrossesseID], [Maternite_LiaisonDossierGroupeCibleID], [MedecinTraitant_UtilisateurID], [DateEnregistrement], [DateResultat], [Resultat], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'p24sr3IeuWtgyEOnTRaw12CEXkDMAi1KA0wPkgzh49k=', N'G5YmLLzhfk8pikHDXxuF1myTyjTmI4XIyfnWqG/NCdY=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'2019-04-23T18:01:48.6843546' AS DateTime2), CAST(N'2019-04-23T18:01:48.6843546' AS DateTime2), 0, 0, CAST(N'2019-04-23T18:03:52.0383598' AS DateTime2), 0, CAST(N'2019-04-23T18:03:52.6829575' AS DateTime2))
INSERT [dbo].[GROSSESSE] ([GrossesseID], [Maternite_LiaisonDossierGroupeCibleID], [MedecinTraitant_UtilisateurID], [DateEnregistrement], [DateResultat], [Resultat], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'sQZ995oPGTSrab6txY9z7/sSVlASr7FC0nFLLGHqFL4=', N'y7b/hqtXOdzho/cW6/1jZ97Uy2b05aP5BUeN7oBAL0E=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'2019-04-25T21:15:47.0089549' AS DateTime2), CAST(N'2019-04-25T21:15:47.0089549' AS DateTime2), 0, 0, CAST(N'2019-04-25T21:15:47.2577998' AS DateTime2), 0, CAST(N'2019-04-25T21:15:47.2577998' AS DateTime2))
INSERT [dbo].[GROUPECIBLE] ([GroupeCibleID], [Administrateur_UtilisateurID], [Type_TypeGroupeID], [Intitule], [Objet], [Archived], [Closed], [DateCreationGroupe], [DateClotureGroupe], [DateArchivageGroupe], [Createur_UtilisateurID], [Code], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'DRf3T4QS6YbFvifHRXZ8sZfYZXovwHUGXnnF0WfxZhU=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'JhQsOxL9dXCGnhAzZxh5+jrYgBRof/ojVyuswUIWSnA=', N'Enfants perdus                                                                                                                                                                                                                                                 ', N'L''objet de ce programme est de retrouver et encadrer les enfants perdus', 0, 0, CAST(N'2019-04-25T20:37:19.9512020' AS DateTime2), CAST(N'2019-09-18T00:00:00.0000000' AS DateTime2), CAST(N'2019-09-18T00:00:00.0000000' AS DateTime2), N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'TVYHch8CBn227QXmtN+ryA==                    ', 0, CAST(N'2019-04-25T20:37:19.9512020' AS DateTime2), 1, CAST(N'2019-04-25T20:50:50.3717486' AS DateTime2))
INSERT [dbo].[GROUPECIBLE] ([GroupeCibleID], [Administrateur_UtilisateurID], [Type_TypeGroupeID], [Intitule], [Objet], [Archived], [Closed], [DateCreationGroupe], [DateClotureGroupe], [DateArchivageGroupe], [Createur_UtilisateurID], [Code], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'dtoMwIWPLCHt9rjcV7NZJTmShz8S7ZC3o+5My83n1bM=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'JhQsOxL9dXCGnhAzZxh5+jrYgBRof/ojVyuswUIWSnA=', N'Femmes mal traitées                                                                                                                                                                                                                                            ', N'Taux de femmes qui font le CPN', 0, 0, CAST(N'2018-11-04T00:00:00.0000000' AS DateTime2), CAST(N'2018-11-04T00:00:00.0000000' AS DateTime2), CAST(N'2018-11-04T00:00:00.0000000' AS DateTime2), N'kEijK6KJkzxSJvPyiD5xVSYjMuhixElq9rZ1w2/4qcg=', N'KtprxAApOpnGik0m4tArEg==                    ', 0, CAST(N'2018-07-04T15:43:25.7062298' AS DateTime2), 1, CAST(N'2019-04-25T17:52:59.9775027' AS DateTime2))
INSERT [dbo].[GROUPECIBLE] ([GroupeCibleID], [Administrateur_UtilisateurID], [Type_TypeGroupeID], [Intitule], [Objet], [Archived], [Closed], [DateCreationGroupe], [DateClotureGroupe], [DateArchivageGroupe], [Createur_UtilisateurID], [Code], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'ndxYJ6jBsdQjKBnpHdatltwa6LICcEO4Cv92nc+w3hs=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'JhQsOxL9dXCGnhAzZxh5+jrYgBRof/ojVyuswUIWSnB=', N'Enfants mal nourris                                                                                                                                                                                                                                            ', N'Enfants Mal Nourris par les parents', 0, 0, CAST(N'2019-04-23T17:31:36.4989151' AS DateTime2), CAST(N'2019-04-24T00:00:00.0000000' AS DateTime2), CAST(N'2019-04-24T00:00:00.0000000' AS DateTime2), N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'JtDHgZyrRzXv0k02klsTlw==                    ', 0, CAST(N'2019-04-23T17:31:36.4989151' AS DateTime2), 0, CAST(N'2019-04-23T17:31:36.4989151' AS DateTime2))
INSERT [dbo].[GROUPECIBLE] ([GroupeCibleID], [Administrateur_UtilisateurID], [Type_TypeGroupeID], [Intitule], [Objet], [Archived], [Closed], [DateCreationGroupe], [DateClotureGroupe], [DateArchivageGroupe], [Createur_UtilisateurID], [Code], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'vau3JPGyf9bBftNgkJBZ5ONcaAc1ETb78qv8pC2BoC0=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'JhQsOxL9dXCGnhAzZxh5+jrYgBRof/ojVyuswUIWSnA=', N'Enfants mal vetus                                                                                                                                                                                                                                              ', N'Enfants Mal Vetus par les parents', 0, 0, CAST(N'2019-04-24T19:10:08.1562151' AS DateTime2), CAST(N'2019-04-17T00:00:00.0000000' AS DateTime2), CAST(N'2019-04-17T00:00:00.0000000' AS DateTime2), N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'IG2NkdndeeeeRle0ywmHXw==                    ', 0, CAST(N'2019-04-24T19:10:08.1562151' AS DateTime2), 1, CAST(N'2019-04-24T19:33:31.9161244' AS DateTime2))
INSERT [dbo].[GROUPECIBLE] ([GroupeCibleID], [Administrateur_UtilisateurID], [Type_TypeGroupeID], [Intitule], [Objet], [Archived], [Closed], [DateCreationGroupe], [DateClotureGroupe], [DateArchivageGroupe], [Createur_UtilisateurID], [Code], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'X2qDrpDvrsdEVplzVTAu2vzexQWFZF/ZUKy7IE1DU0s=', N'Wh28JZShQpu6vEsqQVNxth+F5ZkDpHCB+SrcfrTeLi4=', N'JhQsOxL9dXCGnhAzZxh5+jrYgBRof/ojVyuswUIWSnA=', N'VESOS                                                                                                                                                                                                                                                          ', N'Groupe des enfants habitants dans le centre', 0, 0, CAST(N'2019-05-08T09:11:15.5705137' AS DateTime2), CAST(N'2019-05-08T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-08T00:00:00.0000000' AS DateTime2), N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'7wOE0JrvS0EFmZk0AvQMDA==                    ', 0, CAST(N'2019-05-08T09:11:15.5705137' AS DateTime2), 0, CAST(N'2019-05-08T09:11:15.5705137' AS DateTime2))
INSERT [dbo].[GROUPEMALADIE] ([GroupeMaladieID], [IntituleGroupe], [DateCreation], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'FmJwO+CW3sJosVyDXEo5vInnsSyKtMShzewDlmLxA78=', N'tYDufPU7L8LrjSPk+rxNgvsbdFDygR0/vzW+OT2QGKY=', CAST(N'2019-04-23T14:07:00.7468020' AS DateTime2), 0, CAST(N'2019-04-23T14:07:00.7478007' AS DateTime2), 0, CAST(N'2019-04-23T14:07:00.7478007' AS DateTime2))
INSERT [dbo].[GROUPEMALADIE] ([GroupeMaladieID], [IntituleGroupe], [DateCreation], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'FmJwO+CW3sJosVyDXEo5vMtOwnVKHCCurn1jkkDA9Ho=', N'5vi8V6y09WXn3EOmnrprshiJ0nccRMfDZVwXYwAyZtT/f2kNjkiGWFvh87GWAgPPWiHy5JZ4UheXCaJXi01ogQ==', CAST(N'2019-04-23T14:07:40.8078609' AS DateTime2), 0, CAST(N'2019-04-23T14:07:40.8078609' AS DateTime2), 0, CAST(N'2019-04-23T14:07:40.8078609' AS DateTime2))
INSERT [dbo].[GROUPEMALADIE] ([GroupeMaladieID], [IntituleGroupe], [DateCreation], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'X0G9o1jZ9pf2cINKbJ5AF1yBb4KgGMN10AchumOXyxA=', N'rc/KGfmfse/NccO8KsjTWnAU/kSHmqB7ncWc1OoSs56b6P7hDqfHMvH6eEUdTWu3', CAST(N'2019-04-23T17:09:36.1645554' AS DateTime2), 0, CAST(N'2019-04-23T17:09:36.1645554' AS DateTime2), 1, CAST(N'2019-04-23T17:13:49.8753446' AS DateTime2))
INSERT [dbo].[LABORATOIRE] ([LaboratoireID], [Libelle], [Adresse], [Telephone], [Email], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Laboratoire1                                ', N'Labo de soin', N'Bloc1', 62352364, N'e694672601@gmail.com', CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[LABORATOIRE] ([LaboratoireID], [Libelle], [Adresse], [Telephone], [Email], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Laboratoire2                                ', N'Labo test', N'Bloc2', 684356465, NULL, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[LABORATOIRE] ([LaboratoireID], [Libelle], [Adresse], [Telephone], [Email], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Laboratoire3                                ', N'Labo d''analyse', N'Bloc3', 684361688, NULL, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[LABORATOIRE] ([LaboratoireID], [Libelle], [Adresse], [Telephone], [Email], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Laboratoire4                                ', N'Labo de données', N'Bloc4', 568689566, NULL, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[LABORATOIREOUTILS] ([LaboratoireOutilsID], [Laboratoire_LaboratoireID], [RayonID], [Libelle], [Description], [EstCompte], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'LaboratoireOutils1', N'Laboratoire1', N'Rayon1                                      ', N'labo1', N'Pas de description', 1, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[LABORATOIREOUTILS] ([LaboratoireOutilsID], [Laboratoire_LaboratoireID], [RayonID], [Libelle], [Description], [EstCompte], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Laboratoireoutils2', N'Laboratoire2', N'Rayon2                                      ', N'labo2', N'pas de description', 1, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[LABORATOIREOUTILS] ([LaboratoireOutilsID], [Laboratoire_LaboratoireID], [RayonID], [Libelle], [Description], [EstCompte], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'LaboratoireOutils3', N'Laboratoire3', N'Rayon3                                      ', N'labo3', N'Pas de description', 1, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[LABORATOIREOUTILS] ([LaboratoireOutilsID], [Laboratoire_LaboratoireID], [RayonID], [Libelle], [Description], [EstCompte], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'LaboratoireOutils4', N'Laboratoire4', N'Rayon4                                      ', N'labo4', N'Pas de description', 1, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[LIAISONDOSSIERGROUPECIBLE] ([LiaisonDossierGroupeCibleID], [Dossier_DossierID], [GC_GroupeCibleID], [DateIntegration], [DateDepart], [Actif], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'dlwJC1A8R/2zgGGLFFV414Vr89m2szEyHniwfI9GMfg=', N'mgVPBxHUN71xBAJi1VktYMV7HwatQmphO9oP0zxQAAY=', N'DRf3T4QS6YbFvifHRXZ8sZfYZXovwHUGXnnF0WfxZhU=', CAST(N'2019-05-08T09:16:34.2574245' AS DateTime2), CAST(N'2019-05-08T09:16:34.2574245' AS DateTime2), 1, 0, CAST(N'2019-05-08T09:16:34.3663543' AS DateTime2), 0, CAST(N'2019-05-08T09:16:34.3663543' AS DateTime2))
INSERT [dbo].[LIAISONDOSSIERGROUPECIBLE] ([LiaisonDossierGroupeCibleID], [Dossier_DossierID], [GC_GroupeCibleID], [DateIntegration], [DateDepart], [Actif], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'G5YmLLzhfk8pikHDXxuF1myTyjTmI4XIyfnWqG/NCdY=', N'5hE20GJ8pddGm0GH0mQ4Y+zbMHEbRaH7wcrxPiRRkos=', N'dtoMwIWPLCHt9rjcV7NZJTmShz8S7ZC3o+5My83n1bM=', CAST(N'2019-04-23T18:01:48.6843546' AS DateTime2), CAST(N'2019-04-23T18:01:48.6843546' AS DateTime2), 1, 0, CAST(N'2019-04-23T18:02:22.1526343' AS DateTime2), 0, CAST(N'2019-04-23T18:02:23.6886788' AS DateTime2))
INSERT [dbo].[LIAISONDOSSIERGROUPECIBLE] ([LiaisonDossierGroupeCibleID], [Dossier_DossierID], [GC_GroupeCibleID], [DateIntegration], [DateDepart], [Actif], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'IOlREB58vVCVuZROQYYBudi08vKaG9xC+GhPkQNo2h8=', N'6hR5Klp3qDB0xpmWTtP70OFQADs3/XsTB0PN5WN+BeA=', N'DRf3T4QS6YbFvifHRXZ8sZfYZXovwHUGXnnF0WfxZhU=', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2019-04-26T09:05:01.1082027' AS DateTime2), 0, CAST(N'2019-04-26T09:05:01.1082027' AS DateTime2))
INSERT [dbo].[LIAISONDOSSIERGROUPECIBLE] ([LiaisonDossierGroupeCibleID], [Dossier_DossierID], [GC_GroupeCibleID], [DateIntegration], [DateDepart], [Actif], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'q4VdlvRGHiFoJ3OLS5MO6oDBtkJonUXMBdjpKhf3pDc=', N'5hE20GJ8pddGm0GH0mQ4Y+zbMHEbRaH7wcrxPiRRkos=', N'ndxYJ6jBsdQjKBnpHdatltwa6LICcEO4Cv92nc+w3hs=', CAST(N'2019-04-26T10:20:25.0444575' AS DateTime2), CAST(N'2019-04-26T10:20:25.0444575' AS DateTime2), 1, 0, CAST(N'2019-04-26T10:20:25.0794352' AS DateTime2), 0, CAST(N'2019-04-26T10:20:25.0794352' AS DateTime2))
INSERT [dbo].[LIAISONDOSSIERGROUPECIBLE] ([LiaisonDossierGroupeCibleID], [Dossier_DossierID], [GC_GroupeCibleID], [DateIntegration], [DateDepart], [Actif], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'y7b/hqtXOdzho/cW6/1jZ97Uy2b05aP5BUeN7oBAL0E=', N'5hE20GJ8pddGm0GH0mQ4Y+zbMHEbRaH7wcrxPiRRkos=', N'DRf3T4QS6YbFvifHRXZ8sZfYZXovwHUGXnnF0WfxZhU=', CAST(N'2019-04-25T21:15:47.0089549' AS DateTime2), CAST(N'2019-04-25T21:15:47.0089549' AS DateTime2), 1, 0, CAST(N'2019-04-25T21:15:47.0659195' AS DateTime2), 0, CAST(N'2019-04-25T21:15:47.0659195' AS DateTime2))
INSERT [dbo].[MODEPAIEMENT] ([ModePaiementID], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ModePaiement1                               ', N'ESPECES', CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[MODEPAIEMENT] ([ModePaiementID], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ModePaiement2                               ', N'MOBILE MONEY', CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[MODEPAIEMENT] ([ModePaiementID], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ModePaiement3                               ', N'VISA', CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[MODEPAIEMENT] ([ModePaiementID], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ModePaiement4                               ', N'MASTERCARD', CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[MODEPAIEMENT] ([ModePaiementID], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ModePaiment5                                ', N'AUTRE', CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2), CAST(N'2017-02-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[MODIFICATION] ([ModificationID], [Dossier_DossierID], [Auteur_UtilisateurID], [DateModification]) VALUES (N'7XC5FnJqx6fSwa9F7ZciQf1NhNDxdXCxtMLCQV7biv4=', N'mgVPBxHUN71xBAJi1VktYMV7HwatQmphO9oP0zxQAAY=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'2019-05-03T14:40:18.6341814' AS DateTime2))
INSERT [dbo].[MODIFICATION] ([ModificationID], [Dossier_DossierID], [Auteur_UtilisateurID], [DateModification]) VALUES (N'K/aGseooFsWP8NgWR1vih2M5UM0xtNhAvG11r6nQSeQ=', N'5hE20GJ8pddGm0GH0mQ4Y+zbMHEbRaH7wcrxPiRRkos=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'2019-05-12T11:35:02.2285452' AS DateTime2))
INSERT [dbo].[MODIFICATION] ([ModificationID], [Dossier_DossierID], [Auteur_UtilisateurID], [DateModification]) VALUES (N'yDLVEHmxZ+ZPrrtAjmyqBF9jZx3rJNSAX2Z8E2LIMGE=', N'6FCMUeNSM0np3UB6i+PZs04DkuuLmp7b6LTEr8Om2Xs=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'2019-04-26T08:43:47.7368833' AS DateTime2))
INSERT [dbo].[PARAMETRE] ([ParametreID], [Dossier_DossierID], [Tension], [Pouls], [Temperature], [Avis], [DatePrise], [Poids], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'AqP1GnWmyWbtUEWyc8O8d9MFgZK4UvUNmUMKFftCwd0=', N'SbmgZJ8F2wTsU+HVBpRP2TvcdNbCXNh3zENPDwN9/+o=', N'12', 12, 37, NULL, CAST(N'2019-04-16T14:32:09.8425787' AS DateTime2), 60, 0, CAST(N'2019-04-16T14:32:09.8435762' AS DateTime2), 0, CAST(N'2019-04-16T14:32:09.8435762' AS DateTime2))
INSERT [dbo].[PARAMETRE] ([ParametreID], [Dossier_DossierID], [Tension], [Pouls], [Temperature], [Avis], [DatePrise], [Poids], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Io4kaKhJufZm2b5Pu06Th05pELdOjGyMEa+ddkQ7Pzw=', N'5hE20GJ8pddGm0GH0mQ4Y+zbMHEbRaH7wcrxPiRRkos=', N'12', 12, 39, NULL, CAST(N'2019-04-23T15:34:57.1011148' AS DateTime2), 80, 0, CAST(N'2019-04-23T15:34:57.1011148' AS DateTime2), 0, CAST(N'2019-04-23T15:34:57.1011148' AS DateTime2))
INSERT [dbo].[PARAMETRE] ([ParametreID], [Dossier_DossierID], [Tension], [Pouls], [Temperature], [Avis], [DatePrise], [Poids], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'Io4kaKhJufZm2b5Pu06Thz6xsoWy3D4RfmXAQYX/lGw=', N'5hE20GJ8pddGm0GH0mQ4Y+zbMHEbRaH7wcrxPiRRkos=', N'12', 12, 40, NULL, CAST(N'2019-04-23T15:34:14.5104989' AS DateTime2), 84, 0, CAST(N'2019-04-23T15:34:14.5124971' AS DateTime2), 0, CAST(N'2019-04-23T15:34:14.5134958' AS DateTime2))
INSERT [dbo].[PARAMETRE] ([ParametreID], [Dossier_DossierID], [Tension], [Pouls], [Temperature], [Avis], [DatePrise], [Poids], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'm93GdI3EPigWIq6NqH6oyjM6C0pFIj1xvxcJB6pqyhU=', N'mgVPBxHUN71xBAJi1VktYMV7HwatQmphO9oP0zxQAAY=', N'12', 2, 37, N'tk425531QGpt6h/ajZCUFQ==', CAST(N'2019-05-03T14:41:14.8201330' AS DateTime2), 60, 0, CAST(N'2019-05-03T14:41:14.8221317' AS DateTime2), 0, CAST(N'2019-05-03T14:41:14.8221317' AS DateTime2))
INSERT [dbo].[PARAMETRE] ([ParametreID], [Dossier_DossierID], [Tension], [Pouls], [Temperature], [Avis], [DatePrise], [Poids], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'RYtyTclMy7RhnK6Nf0q0Im+modVBBsbAw5KPpC64xt8=', N'S/mOQHRjA7/wvxaJsFRYlBluK2fT815XLVSc3llfgKU=', N'120/80', 2, 37, N'ZUGSAYlgJXcqhmS26JNqcJ6d99m+o5LV54DxWxaTjW4=', CAST(N'2019-05-08T09:41:47.9423814' AS DateTime2), 90, 0, CAST(N'2019-05-08T09:41:47.9433808' AS DateTime2), 0, CAST(N'2019-05-08T09:41:47.9433808' AS DateTime2))
INSERT [dbo].[PARAMETRE] ([ParametreID], [Dossier_DossierID], [Tension], [Pouls], [Temperature], [Avis], [DatePrise], [Poids], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'VN8g3PzHRaLnIXWcFhEsA6q9ltwTDUXNKC1JYKH3BiY=', N'mgVPBxHUN71xBAJi1VktYMV7HwatQmphO9oP0zxQAAY=', N'13', 10, 40, N'sfFLlw7vsE9I7WRSRU36Lg==', CAST(N'2019-05-03T14:47:30.4518503' AS DateTime2), 75, 0, CAST(N'2019-05-03T14:47:30.4518503' AS DateTime2), 0, CAST(N'2019-05-03T14:47:30.4518503' AS DateTime2))
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'/HG80d2RCAX9Aldj2cUtxnXOCeGj0EDAEJFyyw3+E5M=', N'rS0f6wggF5pRNBwNcpyfPw==', NULL, N'ev8oiQhNtLoixCDAdKutWA==', NULL, NULL, 0, NULL, 0, CAST(N'2019-04-16T14:31:07.9555527' AS DateTime2), 0, CAST(N'2019-04-16T14:31:07.9555527' AS DateTime2), CAST(N'1985-01-20' AS Date), N'93IfR8DIDCH1gtwapvAdXQ==')
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'/sMiNj0yf+dTHuEm/L3kdwRPBpvalL2d3jmMP3HZ+rs=', N'jzX7eDUQz45eoIwPaEUkJw==', N'lBpfK5BuPwROW1Zsekd6/A==', N'hkcinWODAi3jkHq3FSLhEw==', NULL, N'iSDL7UmNQUxdXpN4rlVuxA==', 1, NULL, 0, CAST(N'2019-05-03T14:39:14.9767116' AS DateTime2), 1, CAST(N'2019-05-03T14:40:18.5132540' AS DateTime2), CAST(N'1985-01-01' AS Date), NULL)
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'33qYwCtyXyEz7CIynzuxVICF+TIQrXhGGoSj/n2GYM8=', N'D1jmQuByljbynnkFEiIOCg==', N'Q8oSfwhLMtpbnvUvsZ3+Zg==', N'YvEN58CZLBfXjdm+nmwslw==', NULL, NULL, 0, NULL, 0, CAST(N'2019-04-26T08:42:26.2475029' AS DateTime2), 1, CAST(N'2019-04-26T08:43:47.7278904' AS DateTime2), CAST(N'2019-04-26' AS Date), NULL)
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'52mw8TR6XZ6C3GWBxGZW/nhX8J+avHG7uU0tyvkNgjY=', N'EscasJ9qxTYwGZ3+3y0Hmw==', N'4WTJ5lVxG7NCg2ee3jZ/fA==', NULL, N'Fgs+mRt0/BnUMx4rm/tvpC+isHFGXwe310cbvkurvsg=', NULL, 0, NULL, 0, CAST(N'2019-04-16T12:07:59.2836346' AS DateTime2), 0, CAST(N'2019-04-16T12:07:59.2836346' AS DateTime2), CAST(N'1989-01-31' AS Date), NULL)
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'a5+w3MSejGMZjCTPxrFhUMdAsu859mC2W4KLMP8qgaM=', N'u09aKryCxJVxmxhzU0LqRA==', N'TaB8k8rLDgu7nNn9pGkRUw==', N'LqmrmF1xOEYJ0Gp5Hovxzg==', N'AaPruuavS6wUGFw0/IKC8Q==', N'AaPruuavS6wUGFw0/IKC8Q==', 0, N'AaPruuavS6wUGFw0/IKC8Q==', 0, CAST(N'2018-07-04T12:12:52.0000000' AS DateTime2), 1, CAST(N'2018-07-04T12:12:52.0000000' AS DateTime2), CAST(N'0001-01-01' AS Date), N'AaPruuavS6wUGFw0/IKC8Q==')
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'Bw2s/BnNoq+RrEfvqBgMW4PtIg/oc/8d+F444Sr4crk=', N'PsOu5SzPijFegLxnFOYFUw==', N'PaX2rrdIEJckyChlLb7/qQ==', N's62JhV3Pm/vbHGNbQjCNBg==', NULL, NULL, 0, NULL, 0, CAST(N'2019-04-26T08:44:51.7556267' AS DateTime2), 0, CAST(N'2019-04-26T08:44:51.7556267' AS DateTime2), CAST(N'2012-04-07' AS Date), N'93IfR8DIDCH1gtwapvAdXQ==')
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'czIedKb1A0YTGHQTdnRCT/Njevq744hAVd4kOSo0EU4=', N'EscasJ9qxTYwGZ3+3y0Hmw==', N'4WTJ5lVxG7NCg2ee3jZ/fA==', N'8PuWxouBVfAo2GmkKL/FVg==', N'0+m1CASv+CpTbRWkNENlmYKaRrv32gd9hP+999dTd3g=', NULL, 0, NULL, 0, CAST(N'2019-04-01T15:27:46.6901493' AS DateTime2), 1, CAST(N'2019-04-23T17:36:14.5833486' AS DateTime2), CAST(N'0001-01-01' AS Date), NULL)
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'Dfy5MumxoPHEMpL5Og2bA1HTvF5QI4ShQ+SHXao1l0I=', N'yj7mC9tgAS26JOdwDR/J7Q==', N'rHNlyn8l3WqJ2f3b6F4LoA==', N'eJVHtw128utNgqjPWYvUwA==', NULL, NULL, 0, NULL, 0, CAST(N'2019-04-16T14:37:43.5945528' AS DateTime2), 0, CAST(N'2019-04-16T14:37:43.5945528' AS DateTime2), CAST(N'0001-01-01' AS Date), NULL)
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'DsWOJPKG/jNWLIrUCCsI8zTQUxQlmSm0AfqM9kCljW8=', N'fBAaERKhv/EAT23Gv4Aj7Q==', N'ZwfxbVY0syWOYo7M5EDSEw==', N's62JhV3Pm/vbHGNbQjCNBg==', NULL, NULL, 0, NULL, 0, CAST(N'2019-04-26T09:04:41.3262739' AS DateTime2), 0, CAST(N'2019-04-26T09:04:41.3262739' AS DateTime2), CAST(N'1997-03-07' AS Date), NULL)
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'ElZ33/SDK4ZcQ+3W18kSBYRgtIJHb6m2R49dFgo/M0A=', N'DNPYljUDX79Ej3FF/dpufQ==', N'+jLFcrf6HSXfVJVzOb9cHw==', N'0Sa3WHIEM1U7fRO06qXH4Q==', NULL, NULL, 0, NULL, 0, CAST(N'2019-05-08T09:40:16.9166762' AS DateTime2), 0, CAST(N'2019-05-08T09:40:16.9166762' AS DateTime2), CAST(N'1980-01-01' AS Date), N'iSDL7UmNQUxdXpN4rlVuxA==')
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'HGUwnL93+cfYIVCzxmTZ4p0ebw75hkjbAuWjhNZsMVc=', N'o6r0skOXjjWEFZnjLHZvcA==', N'1YgwiiW2YxQlUMv0YAqbKQ==', N'OOaj9rYVuvqPOIOm+sgtBA==', NULL, NULL, 0, NULL, 0, CAST(N'2019-04-26T11:22:14.9821698' AS DateTime2), 0, CAST(N'2019-04-26T11:22:14.9831699' AS DateTime2), CAST(N'0001-01-01' AS Date), NULL)
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'hStgtpMF+Sz81fl9ibjEjZdbIzxea+Y23O9z2URcZRI=', N'rS0f6wggF5pRNBwNcpyfPw==', N'FO/vaBFsbhd/v3aYkStqcQ==', N'TJNiBQdZTQjLuJWgNNvOCw==', NULL, NULL, 0, NULL, 0, CAST(N'2019-04-23T19:30:30.4118118' AS DateTime2), 0, CAST(N'2019-04-23T19:30:30.4118118' AS DateTime2), CAST(N'1985-01-20' AS Date), N'93IfR8DIDCH1gtwapvAdXQ==')
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'K7FIX+BRuQiU0FKiNyqyNk55LSHjbKA8kYWLDVuv89U=', N'Q8oSfwhLMtpbnvUvsZ3+Zg==', N'D1jmQuByljbynnkFEiIOCg==', N'Kipl9hWggHEj7UcVUgsdqw==', NULL, NULL, 0, NULL, 0, CAST(N'2019-06-08T10:01:09.5755181' AS DateTime2), 0, CAST(N'2019-06-08T10:01:09.5755181' AS DateTime2), CAST(N'1990-01-01' AS Date), N'93IfR8DIDCH1gtwapvAdXQ==')
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'oihHbviouqtXoJg2/AmDw1bSdFhtYaqFHxcDk9YSkJ0=', N'P42QC/qaJnzTOcfEzCdx0w==', N'rqJTHxTmGumkRJAZWn1DDA==', N'NfBgJuTGNH+FdyK9c1fopw==', NULL, N'DDEIaqQSHTly0GWcxaQgD559GeCb4VMj72pInTpUs5vu9WKcnWwPeBLv+ENRXvvJ', 1, NULL, 0, CAST(N'2019-04-23T15:33:05.9876538' AS DateTime2), 1, CAST(N'2019-05-12T11:35:01.7528420' AS DateTime2), CAST(N'1987-03-21' AS Date), NULL)
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'pZIGF94WScj59OFoWme12IAj78Tatmo5CZykdGhxOKE=', N'AAJvEoRBwdzoa5bivKStOA==', N'WZmkKuBuLegbl7O6DION2g==', N'tz1h8PayeJnIGUK94VvVfw==', NULL, NULL, 0, NULL, 0, CAST(N'2019-04-16T11:01:09.8470702' AS DateTime2), 0, CAST(N'2019-04-16T11:01:09.8470702' AS DateTime2), CAST(N'1999-01-05' AS Date), N'nZzxFczcFCr4ltR61THEog==')
INSERT [dbo].[PERSONNE] ([PersonneID], [Nom], [Prenom], [TelephonePrincipal], [Email], [Adresse], [Sexe], [TelephoneSecondaire], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateNaissance], [LieuNaissance]) VALUES (N'ynq2OT625S6PvAi+02NVYUdvjv7BGH/TFWWLAdIzU3k=', N'bIxACNS72iRp7SOOIWmypQ==', N'CxheB2aNjrgxaojdVxNDPA==', N'eJVHtw128utNgqjPWYvUwA==', NULL, NULL, 0, NULL, 0, CAST(N'2019-04-26T08:51:40.2297991' AS DateTime2), 0, CAST(N'2019-04-26T08:51:40.2297991' AS DateTime2), CAST(N'1985-02-13' AS Date), N'tma0NamYOg9RjJzCYx0b4g==')
SET IDENTITY_INSERT [dbo].[PRIVILEGE] ON 

INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (1, N'uUxqQqvVsh7tetLkZceLbQmIoQumin8oCP/NJWOJEgE=', N'XwNEY/kaDNjvAhM3leHVrw==', N'TW/+OgdEefTXcJCuO+w5HuZStZak5x6Jf/WN7kc9qkY=', N'KZKMc4o8M4uglgn0NdLxkUkvuvP4CHxFYwNSEpUdPYB/ev6X23cXE+Vz+/FLN18o', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:26:41.9224184' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (2, N'1LdsRnmsOKrAVmgUCDRPr9zhPzPheWdab+nf7QVBHdM=', N'XwNEY/kaDNjvAhM3leHVrw==', N'NGoqxnA+m1QA4l6f+A9igvrkujb2XrOS3tLoVtQVvzY=', N'ZbkdECasEiWd9Dg6VSNigv6gcYsjAu8hoZ2z/hIAD1Y01X+xlW+wID9y6cckvVNNoJWt5c6vScvuv5mHx1zOHw==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:03:20.2299861' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (3, N'2FPYHLgNXmuZQxfXvIIiyA==', N'XwNEY/kaDNjvAhM3leHVrw==', N'TEDjGR1OMR/Y75cjguTzGIKpVEEN2lrgebGyOzepSjA=', N'tdYYqVQsXyiNcUmjPm5tdwBt4s2koRKUcFWqUoCjPRO+33m9qh1G64NNP2ccxvpeLcTGPXTJN7OGaUBVwcq5gw==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:01:56.7840891' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (4, N'pMCdizOYOHksZzexJ6LJtcIRLIpYAxnM+3r27J3HiRA=', N'XwNEY/kaDNjvAhM3leHVrw==', N'tiav/RC7KFWBMAdEkMwxlUiagH7Dpiqo7bP6dh7WDiU=', N'ZbkdECasEiWd9Dg6VSNigs/stVBhyf9BlF/c4yNWocE02DTLzDKjrfiRdP7bzwbAB7Pyg6QzQMvw4OAO2Efreoco+yUXPsUhZmcNIhEFRPY=', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:25:46.0865665' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (5, N'FrL6HZtWCYTTn/bUiE0mxg==', N'XwNEY/kaDNjvAhM3leHVrw==', N'nTfBMQwnfQNjzl5mKB65Zohnn9dXVr0+8O8AKaO2rQg=', N'GsUuFwSBLt65D5qimDReWLSvSVLKPVLz431uxD1BJXBjrWU+RxqsK+Nt9HWTobdNGF0TxjN2PeVAKkqOTmVMww==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:01:20.5559454' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (6, N'uZBbHIxv4HhP5CxEu1rcyDyAkPypeIzixSU+A4cbOKw=', N'XwNEY/kaDNjvAhM3leHVrw==', N'FTZRGa0P1FlhgCCu6q4Odr+54wNwY8YvPaaifyGPbWI=', N'ZbkdECasEiWd9Dg6VSNigv6gcYsjAu8hoZ2z/hIAD1ZX5mldmDz9U1/UXGHIknnCriOt46zZG07vdtXwsvxxaA==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:02:47.0149650' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (7, N'azORu1asosxoYKeXmZ2wFg==', N'XwNEY/kaDNjvAhM3leHVrw==', N'BYD4BDpz3fVG4zjYZ+vQLTSKDa2iiHXorxLS07wBDw8=', N'GsUuFwSBLt65D5qimDReWN2CdT2BG/9cn/jwjp7aWH/gq6sp03L+9PZdNoVMVxNO', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:00:58.7548724' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (8, N'Cd8wy0f52N34bEaFsYCK+Q==', N'XwNEY/kaDNjvAhM3leHVrw==', N'Uyq/HFF2BFA4sepPkdccaurVqp29lqZ+GXpUtd3h6Q4=', N'GsUuFwSBLt65D5qimDReWHNmYclW+FWokj//rihXL2X+pvcOCft683LeAh2RRwBm77diBc0ZI7rth8FzX64Y4w==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:01:32.1529885' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (9, N'NehA7Js1TEKOVhgMFKg5iNpxXBBAkDgrjkyWiDkuFKY=', N'XwNEY/kaDNjvAhM3leHVrw==', N'bkuUtrRaJqgqkxCvSEd9K/nnTATSZ3ZtkZmCh7wXExU=', N'n5piMpF1uE6Vjp30UW+opQEQ4KvgYDoE4hVAwlHtqxwK1Yqj0QzSnIUOo89Sg7FeD7k9Jxc+gBn0y4TG+/M3cA==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:27:00.2354437' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (10, N'79xOTWf7IFIccM0AHu9zZu4gNop27glOjPmP7pQygS0=', N'XwNEY/kaDNjvAhM3leHVrw==', N'9+nr1AOrc2+yhz1291DEFeDI0oCDjb4u4YqNZhfHTwU=', N'ZbkdECasEiWd9Dg6VSNigh85CJdVS+gvymoi7DuoGx4/Vk0MaMG31d+yFt26tJ7BesIhFKmNrsmNwNPGYGQJRS55q/b9TVkajTtFvyBXMHs=', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:02:09.1041163' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (11, N'DjOls5g848PzMY4drM874gSUlqgh1I+6I102NjwjTEI=', N'XwNEY/kaDNjvAhM3leHVrw==', N'xish2AQ8Tb08v94Rl3Xm0u1Jn847Rhy6PKRL6DMHu/M=', N'nkCptLog0kiX7tnLBE6iLuBi4jmrrXzayruek5jkCk8uVnbmVweYRFzt7rkVixP8', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:25:54.4767819' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (12, N'knF0P55XLJ6KlHRKowDrAA==', N'XwNEY/kaDNjvAhM3leHVrw==', N'IO6qTDQKUpiKLiGVXPdR/zjO3eCHOmn49omjmmBAphk=', N'9RdWChgZ1eIBhMwSD1Pn5apxX5yVKhFVXxFaD0iupNyVKwb1AwUGCo5T5akZJKex', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:26:29.5335877' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (13, N'KlevEWVvhjfn3VzpQYsOCqSme0DonpR6umzly3JTpQM=', N'XwNEY/kaDNjvAhM3leHVrw==', N'UoKlbTMFes/1whzXihx2hDLRSSH0ukKi4RPnbRCzIm8=', N'ZbkdECasEiWd9Dg6VSNigjwIQQnG+Sb/rnv2la4s1Tiwja7uU5GOpR4JQLMlgy1c', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:03:34.1244187' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (14, N'NiqWkKbTrYBlKezipgRdeA==', N'XwNEY/kaDNjvAhM3leHVrw==', N'2/+dk2oCrwYs+/GCZAU5gckXJR6HJNcH/5X5i9QWmeg=', N'GsUuFwSBLt65D5qimDReWDQi5qeCQacHJtxtHRTK0xxpP7FZzNs8EWb+pTYl+QaZ', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:01:12.3170232' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (15, N'tAuIaB3Y7rpmgbMi4mpHhC9zBys0y9kMDxkyjrl2+Rc=', N'XwNEY/kaDNjvAhM3leHVrw==', N'Ua9mjaGGw0ByB6Cx0CqR6vnytJkphCMggRNs7vbDkeE=', N'jx/nTZXuAgWnlSovh+r4JmR/jHmMCwjUXppuOXzYffitSjhEVKFsf1z2RWCGjsGb2ijen+s0nM49APBx/t/gq9aMW6qXjDzS+tgoe0tleW8=', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:26:05.2129133' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (16, N'N1lusS0ji7E007GE5VKNfg==', N'XwNEY/kaDNjvAhM3leHVrw==', N'bOhQrjTSBCXeDXdraq23xaoiG4H3S7wMgv1FgrgvU5M=', N't4rZmW5ijkzQ5SlI6xqh26NBrflTE0pRd9REzXJJC/xI0PuAuHaUT+0q9UzFo40O', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:01:41.7668695' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (17, N'zinK7efiw6Rxew8FwfFHjw==', N'XwNEY/kaDNjvAhM3leHVrw==', N'a8eN1dJ39vbcYPVvRmDQnwuAKbolCKIyOi3yCs6Z7gQ=', N'P7I0uoDpKIX4KXB0cNK/WvDl2IN89pclkOlDyO0YikKH09irhL2hYP70ZrrDqj3BWeqtj9RCyfn4vlEil3dKYg==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:27:44.4444623' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (18, N'CvqXGHGVPBPupM5NzxU8h7wqc6T0c2lp/TPslzIQYqM=', N'XwNEY/kaDNjvAhM3leHVrw==', N'60v3/rqs9hlgUZgLlkbQPEv+qL+K0KQKS0VSRPBYvfE=', N'ZbkdECasEiWd9Dg6VSNiglBHnofupdnIb85N9bI4aT3BbbEby28Y25PJhfYA8awBaDhr3r4OCN1ApLSW7lkK/rFDCuVQOs39yNnPwoyCyoo=', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:02:39.0641581' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (19, N'2aKLZ+jy/61cqB8qnW8uzA==', N'XwNEY/kaDNjvAhM3leHVrw==', N'/S53m+zDY1isMFpb7mTpyyiI0KHTxqlYZhl2ocakr38=', N'VzlM8bJ95wC3GXd4yhwHPudNf27YcUTADWGchW1WUSbqHuK7/qnWxM3sHjrh8Rsp', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:01:48.9008792' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (20, N'b9H+HhzA6BYbJ8ix2CUzSwv9NKiRr1kFr3i66hHnqKA=', N'XwNEY/kaDNjvAhM3leHVrw==', N'7Taz9dqq1+r/yDYjVTL3M4yj06H4YBBShjiBOvJGu9U=', N'ZbkdECasEiWd9Dg6VSNigs/stVBhyf9BlF/c4yNWocFsSbcLZHdljaJt5niH1UovdRJSyQmPYIRdIaFPL1h77w==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:02:31.4614992' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (21, N'291D6+TgaD23js7tMStCRizBcmoT2i+E/62PzjRU13M=', N'XwNEY/kaDNjvAhM3leHVrw==', N'86lJWkBScHjLlUfSBfGKBFD8WRGR2o1I1X/EnuuDEl8=', N'ZbkdECasEiWd9Dg6VSNigi8wE6mCEobsAHPzIyoXXl+fFIcJqSGEg6WN4PBii+F8cUqTDi3NFRIvxX7vaHc11g==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:02:25.1542200' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (22, N'svHY5DYMep/pKGSjNrozbVmyu/DBddpSX3Klo9YkKyw=', N'50+29KHA7Fn5++QJUGoENA==', N'OWsnEoYIVh17P5hKtFVwHje2QJIve1ZRam/8t1LBN2s=', N'0Zkj9W5IiBFQ5kMIvj7f4ut0UwuHQauqgKKgfC0fRwXXgkSt1X2vFMkGhWk64SPc', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:16:24.8598130' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (23, N'1gxqZ5LhAcongeuYla/dU2ZRM2rLl8Y+vlgc4wKHxQA=', N'50+29KHA7Fn5++QJUGoENA==', N'N0ZPIIbtVAs5F8Qn3dKVeKjl6vQru6M9eEYcmkyZFJE=', N'ZbkdECasEiWd9Dg6VSNigs/stVBhyf9BlF/c4yNWocGvKZ+DOd1lik92zKNbOtgL', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:16:11.8641629' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (24, N'AiBR8AtWWdBvWX4CRvzPUw==', N'50+29KHA7Fn5++QJUGoENA==', N'BSJvt6rpYw9tYBipn+f9meNb9QVyQ0c0hl7HCvUtvOg=', N'qhq0g8gdo/9AC7qxbmLwvDj/LzM2QhIlv5u0oBVLDfWeqDhzj/xN2Yr4dSXIztn0', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T08:55:20.8229268' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (25, N'1HjWebS78M8U+OYcZt/mYc8onB0PIRzu7unchaCDm5g=', N'50+29KHA7Fn5++QJUGoENA==', N'UoKlbTMFes/1whzXihx2hGXUO3dto2TNZhl0SxFqls8=', N'WjHurxRVBgrNtV+vMJ4OrDpkfR0lJKtRlbrJzaraohJYOO8ZwVpAvgH7vCYpQhS4', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:16:19.0317667' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (26, N'k3LubD6umRz1fuGgNk98dqHyaGEadl1WzWLsHk2udck=', N'50+29KHA7Fn5++QJUGoENA==', N'NHU0HmxPrF/Ujj6LXKP0as2fxZ5YIQ+7x5geUdy+dg4=', N'TcGwMEQ639N7qX/+9CQFhuHrBlny5ELkeUzLqXRVidevPIbggCryADHlMy2egiK7', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:15:57.4505405' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (27, N'0Z7D6sMZA9uP1+i7D+w7uW6Pkm3VoQA4Z/LnnTq11Kw=', N'50+29KHA7Fn5++QJUGoENA==', N'Vl7mRTMk7AXNJOHROvG0bC+p8uOmjwSTHO2JDGz0rvk=', N'ZbkdECasEiWd9Dg6VSNigtAB5jDlBOpsfWf5+j/4GZ3XMbs3pn8S0TLZA6dCH5uk8VFKO4BDUOKuEaMm7cKeHQ==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:16:04.8345337' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (28, N'/mZj6lavoFQQDt9VnjFtljrKIfLvVNQHA5W9qfMJWmM=', N'50+29KHA7Fn5++QJUGoENA==', N'VrPkJ6kuM7azFzVseOhQ3icSm20fs/ZL/UhnAHqLxUc=', N'slk9L3GCa4fN7pCPDPPkDrvnffJ0rwexUzQX8/dnwrxWFbX9Zf7Bzv4t5bjEmdAf', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:16:31.4306530' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (29, N'BA2Lyc54DYbthVWcURGRQfQmaScKD2v+5W1fTBHS9q8=', N'7ud6K4mRbol2VNgNWR+xGljQec2uJTpcBSQQDmf3UTI=', N't2U+T6OlMt0+yVxUDviwe9Sm5p0ApZckvux23aKZSqg=', N'nDswgD66MISuYtkzS2uimR4L/i0si9Ij+VF/b5HlecRcMMkDJiIo+f7qMGwdUFAj', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T08:41:34.5956253' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (30, N'b89arAQHX7LbA9lZj0inyILEg4SMahrg0APT5f6zrWE=', N'7ud6K4mRbol2VNgNWR+xGljQec2uJTpcBSQQDmf3UTI=', N'UoKlbTMFes/1whzXihx2hB7E/UpXDfGQalhGFyomnZo=', N'ZbkdECasEiWd9Dg6VSNigp+C3KomfMoUGiU4qIkciNmckURg9cTf8eS/I8eN57YO', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-07T20:40:07.1898873' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (31, N'aviDipPhqt/rKTHMFeS1F4aX8djI6n5XGaWhylgxS9k=', N'7ud6K4mRbol2VNgNWR+xGljQec2uJTpcBSQQDmf3UTI=', N'zRf2SjC5t1XtTzOdlRDxbemc3rCmZw3cJfl0NUacg9g=', N'nkCptLog0kiX7tnLBE6iLh4V2c0KZO0p7ca3zxcz426a+ex5p57NaMwtAPAR/6pH', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T08:42:15.1460307' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (32, N'W5WEoQOZzwVav7aAbqmvzA==', N'7ud6K4mRbol2VNgNWR+xGljQec2uJTpcBSQQDmf3UTI=', N'sQDc5GntNQTg0Mb0eOwnXBjpJMy9/uPAE+oJzjN+jbk=', N'm1mjyO/I59UQYPFBncDokOY2JL9h5yBuse8vEe6goS4uXxyxb6Pq3VS+pj0LPnleyXtepmjM1drVgLRODm/7uA==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T08:45:15.7817242' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (33, N'AhG/XCUIZMDhR1kxJvJVu8jVjl14SBUdAyC7YSFstvc=', N'7ud6K4mRbol2VNgNWR+xGljQec2uJTpcBSQQDmf3UTI=', N'UoKlbTMFes/1whzXihx2hJwh6khkcOa0Qql3SinWFp8=', N'ZbkdECasEiWd9Dg6VSNigqL2R6G/fZT8AuMS54KMompivKJbqBOa9x5cQ7yr6SLx', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T08:45:21.0687388' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (34, N'2WtA7PmT2PDDMcL7+0FvLA==', N'7ud6K4mRbol2VNgNWR+xGljQec2uJTpcBSQQDmf3UTI=', N'l3MEmZeA/3mTQ9h9PxdglA==', N'zH+n4J6pj3Fd++W3JFX3oTxSzbKeML8DYZ4YxmIf1QU=', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T08:45:11.2178631' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (35, N'tqkrs51yMP+8JDRP0EBVOw==', N'7ud6K4mRbol2VNgNWR+xGljQec2uJTpcBSQQDmf3UTI=', N'3UJxq/3Nba+2MqW7hrb6Lw==', N'czNNr8FxAdPDK3dC9FQ/3ZjKxUDO8xPUDeS5Q/xRwIs=', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-07T20:41:01.9094886' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (36, N'1HjWebS78M8U+OYcZt/mYRFmYsDmHmYl0jUB2EHKsBw=', N'KhHHSy+cFl6y8SvVFJxpgQ==', N'UoKlbTMFes/1whzXihx2hOOxGMOjgc1TKB6y4w14Rqg=', N'ZbkdECasEiWd9Dg6VSNigkvQhJDEnmd13ujZmMniAf4TbnFnbN4wzBs2wCM1hoj/0/lfj6MwH515JY9iV/qO3w==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:10:06.6214766' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (37, N'5Tz0GbXQNnNTxE6ArOArx8jQUTYA/uOW7nce9inTsVM=', N'KhHHSy+cFl6y8SvVFJxpgQ==', N'9C+PFsGVS448sXUUhoKDqYAvde0f48aZSD3zg7dd4sU=', N'SO276TGQ3vqE+MNBmV7ZspmGUuVAeCymJDyyjIcGrcjuzXPux5a31gBiEeXb0289', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:08:10.3321816' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (38, N'XwBOpgFXK9yOJzAcmXffXyGuBgHLAKPdBVKEQ9HRJN0=', N'KhHHSy+cFl6y8SvVFJxpgQ==', N'ox+Pe02GxIns8qbTLvbOndnrjOI7RDX99g9hLkQSF6s=', N'86qRswoGfMzy4FjiUuxbfPOEoYF0PRSPJqw8ZtsghRYFxWB9hEcZcq4d/E7nrG/FJ1+olVm32BApYAN99OnrHQ==', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:09:06.6402313' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (39, N'4ZtaCOkTQ2ZkPz/1LFNEVQ==', N'KhHHSy+cFl6y8SvVFJxpgQ==', N'e/g+z+VDyo4QQXDaiCTV+5Tosw6tKHEqJgTz+hfaI1U=', N'86qRswoGfMzy4FjiUuxbfPOEoYF0PRSPJqw8ZtsghRb/n0uBOcFD+g0x4UDgzpS0', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:09:13.6830408' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (40, N'RvGQehvuaz0Fy4lGnj5O948JVS30YE9tObkQgVbb0i8=', N'KhHHSy+cFl6y8SvVFJxpgQ==', N'fRAzSQbbtmBAxKHLTsDNspGQlEsa3gcbM80CCwtsXe8=', N'SO276TGQ3vqE+MNBmV7Zsmcu7N4hj4HDx+svUwb569Ba1MUT3F8kFvxD3Xp8N7Mh', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:08:03.3468156' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (41, N'eC7jbDUms5IBCO575nVwHlTNygz3UmGAFJWyvyBFMV4=', N'KhHHSy+cFl6y8SvVFJxpgQ==', N'SSc7FwRVtBUBsHkcKZiKA68drwCHgn9QZ4CHxkstHWY=', N'+RsrmVEo03lsnnj3PaFEAKOC/xsi/XVH1WDcVJjXjExpMeAznPP04hiA6rCVDZXj', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:07:55.6913705' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (42, N'fUyTJYLIWm2l5UeCziiPiyfIa3CFBqD4i1qyptGiIeA=', N'KhHHSy+cFl6y8SvVFJxpgQ==', N'RtZfUx7XL1jjn7Bs+f4aw9vGkzfdJQEaHswaZBUjU2w=', N'Ny+IxK4W3Gslpm61Jl6MIfkNN/evAZG8SQeUEO43IEM=', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T08:55:08.9480007' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (43, N'k0Vg/8Dn79w+RqZU0ahepw==', N'XwNEY/kaDNjvAhM3leHVrw==', N'39MUN3v6Nl0RGHVZ9MjJ4xjedulP8BZhEx4qaUiXJ7s=', N'xLzK7Keo5Sobc3lE8S5yAD5wx1EYn5G56uuebbQwIPloBtAAKM1nLG562apSmAtD', 0, CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2), 1, CAST(N'2019-06-09T09:26:15.0475605' AS DateTime2), CAST(N'2018-02-26T12:45:17.0370000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (44, N'ivrvpH62natltijShwMfDMxZACVa1cJ9GEL2de8AeQI=', N'XwNEY/kaDNjvAhM3leHVrw==', N'PPBpUfvKKCcOL9xV8IL7gvrtA3GIU4TS59xCLZwn59k=', N'ZbkdECasEiWd9Dg6VSNigmvv0USTfQbnLEN3lPpXEisgHnG7ajK0+matOlGJZx3OiU6SXaZhmKqu3aoZGKdNmA==', 0, CAST(N'2018-08-29T17:57:00.0000000' AS DateTime2), 1, CAST(N'2019-06-09T09:26:21.8435946' AS DateTime2), CAST(N'2018-08-29T17:57:00.0000000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (45, N'2gP7lJ+7sBKiCivbzrGgmnqM0bbNlQT/n9ONry7QBsU=', N'50+29KHA7Fn5++QJUGoENA==', N'RtZfUx7XL1jjn7Bs+f4aw8d/zFlZ3MW46WlpLhgQ4h0=', N'GsUuFwSBLt65D5qimDReWPLY38sS6dv0ZOv3ToykY6o=', 0, CAST(N'2018-08-29T17:57:00.0000000' AS DateTime2), 1, CAST(N'2019-06-09T09:15:50.1496015' AS DateTime2), CAST(N'2018-08-29T17:57:00.0000000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (46, N'LTiTzW+ygfYILcH9q0Dw80M9iLgR4FDqlFZ6niyLvzs=', N'XwNEY/kaDNjvAhM3leHVrw==', N'wf7/hLvYDdtuTdYL4Lx+V5O47/dJmjxrjBKKtQX3/Pg=', N'ZbkdECasEiWd9Dg6VSNigtTTRTr5UGm3uS28e61YdJIEGK8fcXoykc9BCZTcUW8Q', 0, CAST(N'2018-10-19T00:00:00.0000000' AS DateTime2), 1, CAST(N'2019-06-09T09:02:16.7194584' AS DateTime2), CAST(N'2018-10-19T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (47, N'8AgRdYtzuOTzSnkOSHuVZ3Isu8UBXqeKUF7cIgoSMfo=', N'XaT1h5px8Y71H3sqmKqPfA==', N'UoKlbTMFes/1whzXihx2hHKmeUyyQ0CPzukYm1ZQOd0=', N'ZbkdECasEiWd9Dg6VSNignYTgFYDepECTC4Cqjr/vDTKkwdEEgQOWFBxYI73IpM7', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2019-06-09T08:14:44.2990011' AS DateTime2), CAST(N'2019-06-07T17:52:31.4997185' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (52, N'LkLC3+LmIuh9zZzFDb/fxVYN8wOeZHFmID93TsB2280=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'0VBda5xUusqrX2bZFy5iOzk7iEysKyZBXLnS2/ot/lpHbVyTO8JjLtxe8fewNrXI', N'a0ZyRc3pmr/D4UcLDSqzZeLk0YZEjtrKH5F33TTTyXzQ0BsKn5MdcbGhoOlNWZll', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:42:32.4620275' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (53, N'lIkuBOUqTfDptlj+A1bsNVdEfInloFTxyMfnMQh/V10=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'UoKlbTMFes/1whzXihx2hH12ZMXVurA04ShC39BDJUc9Hob71thNUPgTMcCAJrIg', N'ZbkdECasEiWd9Dg6VSNigtxvha7TW6dUj3q1Xl+WbXTsqJpF8q6de6wLt8Uf/PIN', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:43:02.3151869' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (54, N'gg0164aaW8v/bFX5ZQ0p0T9DjEFlpczZu7YZJyRJBJ0=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'Wp7uwai1jLCB4rjjwBS3zC7+RZ+CuEaVgQ6skMsvmU8=', N'ZbkdECasEiWd9Dg6VSNigkJOPwG3Pug4UiWaObvPTtjAftfqSOAyfmegO8Is3JzLoBoLq8IkkkVz+ZzK372Q3A==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:43:35.0177772' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (55, N'8gz1wCRisWNMF3ukReXvzmFNkkO2C2t2JQwd+IPcH6U=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'lZpBgP6vIXsyFvsbfJlHYyz1Zc1rYEdEbYyzFB6jCSw=', N'Y7EGegoMjQVnjhc/z5fyWzr/OnCubDLoOogj/sSD1tFBucZS3J9XkQLQBzAbRkSIpH+x6AZQeGeGhxzx+Cw5Pw==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:44:17.7437109' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (56, N'u8TiQGap/DXV5yh67VPLojFKyCQecY0Dd+VMIR6Rf6U=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'UoKlbTMFes/1whzXihx2hJCXYTwdwXOKnOAW3jsGU50=', N'ZbkdECasEiWd9Dg6VSNigi6YT7GSXPGncGzMv7883DY2WJMf3ii1zGIyOMW6fUnTphMVumNX6KZmAk0pdN9hSA==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2019-06-09T08:01:58.5181656' AS DateTime2), CAST(N'2019-06-09T07:44:52.1627239' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (57, N'W8XhKgLSTjrj6HX61xoV5w==', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'+6zrPlDuPLSBLK141+elDbu71YwnPqZwCFaHT4xIfJI=', N'ZbkdECasEiWd9Dg6VSNigkJOPwG3Pug4UiWaObvPTtgnJ3jvQvr+Ynp69vZimNx7d9Kgq6lkIzh4R0/DAcqytw==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:47:01.2539632' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (58, N'aXeG2pGxAgNWedJr5/moG95FWX8p4Dvn/Naa7jYxCQY=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'oNVrYgMWFM8TDAz5ockqpegPNxStKnDHEtURhwTm86U=', N'GsUuFwSBLt65D5qimDReWPx/w1HQ1fM9kLdpxBS1tWZHoFXLQGQ5ZHEzuvApqk9XHwIkFrpUp1mykOYoSpaqiA==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:47:36.4845358' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (59, N'pzCVjr+2UXbZXpfeDoIyDfUEXBWE87LE3Eh5aCnUls4=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'UoKlbTMFes/1whzXihx2hBmsIBW0pKjXtNfo781JEZY=', N'ZbkdECasEiWd9Dg6VSNiglrJZIrzy7sykcI99XAAL3zQbvOmakQoZud3tZEsUwcMjB42HrQUmHpg13UcPsZ7PQ==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:48:17.3960919' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (60, N'SCSB/AhWaRb6NEIVkv+fVNw/CRoWEwGtU9xqROBBB5Q=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'U4xIgACh/nXq6ohmylWdzRrcANLyjLJujKVxWflKcns=', N'ZbkdECasEiWd9Dg6VSNigkJOPwG3Pug4UiWaObvPTtiPD9wqkGzBJ32UTektKPmrIA5/7RIsUz7XH4vQejQoyA==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:49:40.0950026' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (61, N'8gz1wCRisWNMF3ukReXvzmOx4G4p4XprbRlmTIHE2zY=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'lZpBgP6vIXsyFvsbfJlHY/B/E+zWAQ7seG96tclyONc=', N'a0ZyRc3pmr/D4UcLDSqzZWYbVFzD+yLLrdRRWGbcB0IeKo0bZgxLTewnNsihWfSr', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:52:22.0844399' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (62, N'cjMvYwjFhKib01qWhu7iOdzSjEjgMnps57VWULEkW0c=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'UoKlbTMFes/1whzXihx2hGv+EOgVHueka+uRZxzSVZs=', N'ZbkdECasEiWd9Dg6VSNigi6YT7GSXPGncGzMv7883DbSIbWNZgzpAHXZCJMEZ7Ma', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:53:03.2873715' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (63, N'XBkQnO0rzByl3AK6Iee5KWP9vpMwd3JMQNzePSrLqKo=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'+6zrPlDuPLSBLK141+elDe9qUkFsp8g0JxNh+ieNilw=', N'ZbkdECasEiWd9Dg6VSNigkJOPwG3Pug4UiWaObvPTtgnJ3jvQvr+Ynp69vZimNx7gZNM8E6Y1tni/aAL52tEDg==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:53:33.9763312' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (64, N'Na6TvODz/UpowPPKaOeJYuVGinWS2I4PNb/csundmhA=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'afW15rFAWabxE8z/fVygurmVvd+hJo1V8Mwf9MVE628=', N'KZKMc4o8M4uglgn0NdLxkUfcz6Juc4fKTirotT+v6s9ZuUKHx/yJwLmzfiXqceEgN3OJv/VBebm7qVBcjfxl9g==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:54:03.9338187' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (65, N'uTM43q11krKIpsxcKIxu+WbXCleO7n9WfJCC20ZW9Qw=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'DVtmj2LzVoCGbdCrgpDqHQ16ByuT2D5hEsmxs0vcHMw=', N'p/0vWXFl//bUtBSMkQQPLmp5wElAKkzKFvNIaoB9yehdQUp+1RZNEiRlaCFqdAVO', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:54:30.5888889' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (66, N'JEyrG+l+Je5HxKyY7waNev0QfNG3pwqUDmB59UMCHaY=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'z9HkTs3pa+b63Fg/vRU4enRQtjEHpcF86bIvdgRApls=', N'KZKMc4o8M4uglgn0NdLxkS5Aaagp+C4tq4LBSaZPhAkpB4YYbibf3B+HX+4JQV3N', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:55:00.3778142' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (67, N'RB8y6joy2JlThpbCVo4RbmyBZ+DXYxbr9iBM209EmK0=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'UoKlbTMFes/1whzXihx2hEAtyzPkJiEva5cH4avcb7Y=', N'ZbkdECasEiWd9Dg6VSNigpVTOatumv3tpJovFQmSsIYDksS5PIS65lwPfQf2GZa5ImKalWX5itvKDXzVnYNF7A==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:55:29.5896251' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (68, N'Bzx+mGUHMiZk06sCk9FBCR3nJJF5iFsoVmeXUfqcDnQ=', N'419ZS6ZqFuygzQmvaSnMdQx2ImSIaxJrjSqtVw/9LiA=', N'e9FxCpv1nR6F1e/itmYfEA2VBmtkp6Oe+jRd9g17TVo=', N'ZbkdECasEiWd9Dg6VSNigr32VM94CHgYeRvEqa91mZ/HGtyMdQY6cw5BILrQEwBw909nGt2rvnIFg9Ct2WJ/Bw==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:55:53.3641313' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (69, N'6WLJgnYvg440FqS54PES9yCajMgZUCyrOvWmkZ/4Clk=', N'jMwqa8hUVyGdzRLfBKlS/75uV4kiHC5WfkscAN68uVU=', N'YCvykIhkFh2ISo/IT9Z4pmNNHXr3s7S7fQiLkFa/BkY=', N'GsUuFwSBLt65D5qimDReWKupAtBvJ6dFchyPLELPi0SQBRzhd/X9jo74T7u/zwfBGzuF7KdnXYgK7aHPfUTuGQ==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:56:30.1656808' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (70, N'P3ciaccP3mNO7J4b0j9eLcDuJVDSqVRQhVxAhFQ0p3k=', N'jMwqa8hUVyGdzRLfBKlS/75uV4kiHC5WfkscAN68uVU=', N'N0ZPIIbtVAs5F8Qn3dKVeHL3dehDRv/RB8Og/CH92vw=', N'ZbkdECasEiWd9Dg6VSNigm3tSKUNH0+1III2axi9jYdEO8oDCXp4b5HMXTJEyIaTKg2xLzCRsB0HBQuQxpB5og==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T07:58:14.8905432' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (71, N'UFgg4VgD0CtFKtb3d3BV75AutbBblqT5TisHtjG6BCY=', N'jMwqa8hUVyGdzRLfBKlS/75uV4kiHC5WfkscAN68uVU=', N'VKQKQ2vBrIHrx65uVfQxJw8BMwqqmgwXXGoODYylHqo=', N'KZKMc4o8M4uglgn0NdLxkaXGZhbR+QT2MegIJ+i8VaeQh+PSePge8dGgpMvHwAhK', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2019-06-09T08:04:36.6535938' AS DateTime2), CAST(N'2019-06-09T07:59:03.0386388' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (72, N'eeL9UNI9wQCM+0venUHAZH1TGRJNe5hDmeaRXEQY1AA=', N'jMwqa8hUVyGdzRLfBKlS/75uV4kiHC5WfkscAN68uVU=', N'd5D1zOM8X6V8lPzy9D3VNH6Fm7yFz/wJBRrUISsV6+M=', N'ZbkdECasEiWd9Dg6VSNigkJOPwG3Pug4UiWaObvPTtg1WBS0CeF26cykwfrzHK8a8xU1J5dfRDUzMK/tNAomSA==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:00:02.6325625' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (73, N'wBhToxIwvfd05A6stzM9MN+un0gR1LXEo/CMYz7+tus=', N'jMwqa8hUVyGdzRLfBKlS/75uV4kiHC5WfkscAN68uVU=', N'UoKlbTMFes/1whzXihx2hEAToFmze4mUR50vF53zXg4=', N'ZbkdECasEiWd9Dg6VSNigsvltw94nMKD2o9mOMzVGo75SGjO4aBdEvR7dkrPyyIfz5u2Lr/g2vvMRHaDVxL/ZQ==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:00:41.8486259' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (74, N'SetHRqATdGDbKgpk6x9SVu3QVkdbQSFZUYH6JRbrLBU=', N'jMwqa8hUVyGdzRLfBKlS/75uV4kiHC5WfkscAN68uVU=', N'nO5EP4HhoQAS1L1uVo9K/H7eT3+0yvfxCZz0ZciHzCA=', N'ZbkdECasEiWd9Dg6VSNigmmvRIyvdESQ/vXmFdTzPG0bJ5DIPdEjhPtHEP9kgFGOZLfBTozBkVePRvUx3Rulx7veamYX25CfKQQObYifThA=', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:05:49.5553940' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (75, N'd28R/Pj6WgRGmf1g4M0rV7upBwJ7jwqziC59n+o6gLA=', N'jMwqa8hUVyGdzRLfBKlS/75uV4kiHC5WfkscAN68uVU=', N'crpiNNc6hQmdMtS78lQ870Vd6hvH6dxZjnQZNRWXFpI=', N'KZKMc4o8M4uglgn0NdLxkdnc8DuXwg3CNgdsD/unzhJKxhmk4kV9DriIpWXFYrD5oMAaAqgwFXijNzmcA5sY7g==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:06:34.4687839' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (76, N'vy4JgbC0MgtxzIv8GuICGHhkTG6Z1FgU5YGOa/VoX5w=', N'AwReKNFsLj08hmEORdqEPA==', N'A3d0bf63OzBUjbfu9YRfKy2LCNuyPjT5axPlDK8WweA=', N'GsUuFwSBLt65D5qimDReWC0MKpXOG/Ycpk4wkz8j+6jLKpb34yxNFy8JsrjtiLWZ', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:07:09.6665986' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (77, N'wBhToxIwvfd05A6stzM9MN+un0gR1LXEo/CMYz7+tus=', N'AwReKNFsLj08hmEORdqEPA==', N'UoKlbTMFes/1whzXihx2hEAToFmze4mUR50vF53zXg4=', N'ZbkdECasEiWd9Dg6VSNigsvltw94nMKD2o9mOMzVGo4Qglr+SSe45o6QcmvIf6at', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:07:45.8482450' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (78, N'eeL9UNI9wQCM+0venUHAZH1TGRJNe5hDmeaRXEQY1AA=', N'AwReKNFsLj08hmEORdqEPA==', N'36XSbUsqDMKfvGl6rfPX2dlIAMfWNvkE4v2A5KYkZns=', N'ZbkdECasEiWd9Dg6VSNigkJOPwG3Pug4UiWaObvPTthsRKrz8uqWgir/BWfKoOqIA9sM7/Yb2JaU/Oz71awp3A==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:08:21.2524728' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (79, N'UFgg4VgD0CtFKtb3d3BV75AutbBblqT5TisHtjG6BCY=', N'AwReKNFsLj08hmEORdqEPA==', N'VKQKQ2vBrIHrx65uVfQxJw8BMwqqmgwXXGoODYylHqo=', N'KZKMc4o8M4uglgn0NdLxkaXGZhbR+QT2MegIJ+i8VadaELP/oea+O8NJ+nnh1VUg', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:08:54.3341676' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (80, N'lG9+ezY/loQGrkmLtkqDIe34zHH0k3YLJahfuZgh8UM=', N'AwReKNFsLj08hmEORdqEPA==', N'BqtDBYz5dFtfhIQF8qcVStgS89oN7TXJ11IGvPGXNHY=', N'GsUuFwSBLt65D5qimDReWMEX//Pz5RpJmS/bvFSmkW6ecGPzL+1tnc07Tuu7RJw805BfUe12cQgmzG6qp+516Q==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:09:45.5755928' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (81, N'YhfaVuJrAffIUyfCawpFnQ==', N'AwReKNFsLj08hmEORdqEPA==', N'niwt0F6QaqOkJzCBmlgswLexmWZEZhrX36mwEO89EYw=', N'FKcK5K1YTTUthe5w6yMXZmXe/iUuuj/R6t9fjKLXskxtRhqcGOOiZGXZallab0UJ', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:10:13.1000511' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (82, N'vojroJxzpFqKGWkvgQkKTdpg8ZrpO96z0TSIxn7fPn4=', N'AwReKNFsLj08hmEORdqEPA==', N'Q7tUS5bJpyHXpXVebUBvMzrABDer0FOCS2eqiXktwWY=', N'ZbkdECasEiWd9Dg6VSNigmmvRIyvdESQ/vXmFdTzPG1rSStFlNIaF/anWohfZevRHO15q5X6VoDDxgF54SxsQA==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:10:42.2323266' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (83, N'XLhSCOWyazhdG+3pl/kNaivkAmGhS/TUvBl2aFUpuus=', N'AwReKNFsLj08hmEORdqEPA==', N'ERq1lmUE8eWfGkAXsvTG5e5oyvHqPiHXEJTO2rpzKLI=', N'a0ZyRc3pmr/D4UcLDSqzZUiBNJNgJCm8YCq44QnWMls=', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:11:10.6823444' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (84, N'YkhM2UxEzJkNdh5VeXIhYUCkJnAleZBZLnWy4M0IA0M=', N'AwReKNFsLj08hmEORdqEPA==', N'sC946jyGga8iGEa1m8gghKnqo9a9d9XcAC+cpKGlNXw=', N'ZbkdECasEiWd9Dg6VSNigmaSHm3ZPxQLWMGUbLzgKEgLnbgx2xqGW5G0meKZuZ1o', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:11:36.7090226' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (85, N'y1k6HNr2kqFU9TTN3uujjQ==', N'AwReKNFsLj08hmEORdqEPA==', N'xiRK3pW+NphZHC8dFvwgYqRR2lU5X25VZEbrgjqd0U8=', N'ZbkdECasEiWd9Dg6VSNigkJOPwG3Pug4UiWaObvPTtha70BR7K8K1TK0SOcUJvuo', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:12:06.0761358' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (86, N'ElFlMURaEZTLppES3bECOg==', N'XaT1h5px8Y71H3sqmKqPfA==', N'rWQRmk6XkyitN3D8K/bUgQ==', N'a0ZyRc3pmr/D4UcLDSqzZUxbXYK6Fy/SJSiD+LJ0ffI=', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2019-06-09T08:13:50.0775835' AS DateTime2), CAST(N'2019-06-09T08:12:37.9298007' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (87, N'7j/IBypsT5/LFpPj/0mTTw==', N'XaT1h5px8Y71H3sqmKqPfA==', N'CVjIlyDEMfZ/PDzrAbAYtQ==', N'3Dalo5VGMhbJdPIRG3whTtC68majZO84asSfAw3TbYI=', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:15:24.0413014' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (88, N'sL9afngJ6UYtKriA/COVnw==', N'XaT1h5px8Y71H3sqmKqPfA==', N'XVtyihS4/3PXpmCECxGZww==', N'Mh/Y2Z0n2uW5dkiNiRxdtyMxDqsqk8BIxKsQZ7fdAVE=', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:16:04.9478482' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (89, N'ciIAYLTGLwx1TSEGmHWn3NQrwvNkjd2gcn6gOuToe5A=', N'XaT1h5px8Y71H3sqmKqPfA==', N'XAMG8Aw6XaY93++3DxX6pFt36evrX3t6WUZY04EUvgE=', N'cIhls9h484cXYmktusoJjqkEsUpxwGP+rjnt12nOVJk=', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:17:07.2985666' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (90, N'4j7y2015I/phTyfmpDYNJ1RDhdKd2zE8prHgzCbreGc=', N'XaT1h5px8Y71H3sqmKqPfA==', N'UoKlbTMFes/1whzXihx2hESE/hUwvgAp6FGgK1CgBtg=', N'ZbkdECasEiWd9Dg6VSNignHLZhfE9DN3LY8TL4VFw86iPmMwcLzwfrT1cyPNFBQw', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2019-06-09T09:19:46.5612005' AS DateTime2), CAST(N'2019-06-09T08:18:38.5715812' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (91, N'3OWmHZOPSE3LkVeUmLYDZrGCW9uV7A3fACFeEJ2C9bI=', N'XaT1h5px8Y71H3sqmKqPfA==', N'6e+BFkvkKlV8isA2QUttx5EJKTrT9J027XTNy2MZj/M=', N'ZbkdECasEiWd9Dg6VSNigkJOPwG3Pug4UiWaObvPTthItHMczhD7mf2dgx2noGFPaUHO6eliAr6sVAjqgLhxRQ==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2019-06-09T08:29:03.3090105' AS DateTime2), CAST(N'2019-06-09T08:19:23.3518399' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (92, N'aj6LTjkQuBq+29EvSPftcAJ75a+A8HZ3TIdvK0pgJCw=', N'XaT1h5px8Y71H3sqmKqPfA==', N'CckUJjocVFYP3zZNU2kMU/6vZuHgm9fbBR0SAv39BL8=', N'GsUuFwSBLt65D5qimDReWD6byRGoI6bnh1qALuwHhYuBB0uQI37NHGcPKlQ14qd3', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:19:53.4646995' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (93, N'pzCVjr+2UXbZXpfeDoIyDWSlr1nl8W0wy8Al18Jv8pk=', N'XaT1h5px8Y71H3sqmKqPfA==', N'UoKlbTMFes/1whzXihx2hAkit1bWIWCbYFsyyKmpkWQ=', N'ZbkdECasEiWd9Dg6VSNighP4GGHkWQy6+AguTHKYtW93+U/nf4yQFMPXndD+YMx4Q3m4ZrEU61qUtAM6Sjdb0A==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:21:47.0409216' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (94, N'qb9deSwy7W6wq8dlIdDum9v88r2SKbaS6/Ki8bzZR4c=', N'XaT1h5px8Y71H3sqmKqPfA==', N'+msRChNBpNpcs+//8YsKBoDXr5zm6JKyVlmsdaDFrBQ=', N'ZbkdECasEiWd9Dg6VSNigkJOPwG3Pug4UiWaObvPTtgoXx8ryrjTaOYj8kPgXdw2', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:22:13.9416227' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (95, N'eDhk4BJg5wY08T+nIdO/x4mNqzihfI44PTOsy332+Ao=', N'XaT1h5px8Y71H3sqmKqPfA==', N'KKdh4Egp6ws7qbJbcokNELsywOWRCDPg8NSZE3/oETA=', N'GsUuFwSBLt65D5qimDReWP+3Fgti/8gUmEaWnz1CzyEBrnwrh8NOwOAEmqm3QzhRCLkcPYSbFnk2BOaLDey9bw==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:22:44.2605220' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (96, N'XNnQ+8DRXYJwmV7DmxVZ/RNuAiHyZal2a7YuLM9Q4N8=', N'XaT1h5px8Y71H3sqmKqPfA==', N'frJoQJbHmgoEcHF4pbET/Mzdm9yaj8wHoI4g6AFq9MU=', N'9rR3qlwb91A4RW1jaOBLasv/bdQrbLF+3KukHlam3Ke6RWi/SLm+MhrT2B2DcIccg5vQyK7U44PDs7EH0JW0Pg==', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:23:23.2500530' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (97, N'mRpA0j9K2PQqtDeOQSUsI+qfycq8PUw3AF39nAz0cjM=', N'XaT1h5px8Y71H3sqmKqPfA==', N'+G9DmvaQj+aDRLsct7Q56lGE8oGsxiG2ekT32AEV9No=', N'9rR3qlwb91A4RW1jaOBLalxNLzYL+pjHUqsG3GCGGr4aBeT/J1H/U1oErrBC/Wb+6Nvbr6I1o6gCjxVpJQX/hCTm6nIEoIqthhjqyRjmOz0=', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:24:10.7867141' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (98, N'XTZ1rynfJ9F12Lfjf/qRVkpZZb23qA3c0qb9xyYpasE8gQwi7xX5C/7IGBLWO52u', N'XaT1h5px8Y71H3sqmKqPfA==', N'OV/OMy+t8J45mcgKSxQhC3A2hkut1vlphmt2rfJMhNbzs2y379/uRBFBi4XsThuE', N'ZbkdECasEiWd9Dg6VSNigr1WlvjoyZ4p1AP4ALEiW+dKt4biuKHsXXxk1Gp06EatuxdT1KFFamC+KGnya4QUMNkc0YuUeEM0V73/SZamyAY=', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:25:04.8734610' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (99, N'uo3Bx2UKICMv0lUjh9SWJCFp2anbREGehM8OMioymHU=', N'XaT1h5px8Y71H3sqmKqPfA==', N'Vqd7WIIkH+THrolobIZhN267agGRrlJjguhLhEKp2J0=', N'0JRMW4GnOOfN20eiXQwRJuoPs6qSejFPjjrHPMpNrpPDIHGDfWiUJ8KksbRQroJJ', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-06-09T08:25:44.5515649' AS DateTime2))
INSERT [dbo].[PRIVILEGE] ([PrivilegeID], [ActionName], [Controller], [Peut], [Libelle], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [DateCreation]) VALUES (100, N'uUxqQqvVsh7tetLkZceLbQmIoQumin8oCP/NJWOJEgE=', N'XaT1h5px8Y71H3sqmKqPfA==', N'TW/+OgdEefTXcJCuO+w5HuZStZak5x6Jf/WN7kc9qkY=', N'KZKMc4o8M4uglgn0NdLxkeBGsxpQCYR1FOmJE62O6ZI6SUVJ1096zUn3dUNMPj11', 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, CAST(N'2019-06-09T08:29:16.9294475' AS DateTime2), CAST(N'2019-06-09T08:26:29.3024282' AS DateTime2))
SET IDENTITY_INSERT [dbo].[PRIVILEGE] OFF
INSERT [dbo].[PRODUIT] ([ProduitID], [Stock_StockID], [Rayon_RayonID], [Fabricant_FabricantID], [Fournisseur_FournisseurID], [Reference], [Nom], [PrixVente], [PrixAchat], [ReferenceExterne], [StockAlert], [EstCompte], [Description], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'R08H0520O2101190636P919                     ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'Rayon1                                      ', N'Fabricant1                                  ', NULL, N'PR8H05192110636', N'Mon bon produit', CAST(13000 AS Decimal(15, 0)), CAST(12000 AS Decimal(15, 0)), N'sdfsdfsdf', 0, 0, N'sdfsdf ', CAST(N'2019-05-06T08:21:36.9191423' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[PRODUIT] ([ProduitID], [Stock_StockID], [Rayon_RayonID], [Fabricant_FabricantID], [Fournisseur_FournisseurID], [Reference], [Nom], [PrixVente], [PrixAchat], [ReferenceExterne], [StockAlert], [EstCompte], [Description], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'R13H0520O0201190433P385                     ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'Rayon1                                      ', N'Fabricant1                                  ', NULL, N'PR13H0519210433', N'WSDFSD', CAST(13 AS Decimal(15, 0)), CAST(12 AS Decimal(15, 0)), N'WSDFSDF', 0, 0, N'QSQSDFDS', CAST(N'2019-05-04T13:02:33.3821398' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[PRODUIT] ([ProduitID], [Stock_StockID], [Rayon_RayonID], [Fabricant_FabricantID], [Fournisseur_FournisseurID], [Reference], [Nom], [PrixVente], [PrixAchat], [ReferenceExterne], [StockAlert], [EstCompte], [Description], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'R13H0520O5501190410P963                     ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'Rayon1                                      ', N'Fabricant1                                  ', NULL, N'PR13H05195510410', N'wsdfwsdf', CAST(152 AS Decimal(15, 0)), CAST(125 AS Decimal(15, 0)), N'qsdqds', 0, 0, N'qsdqsd', CAST(N'2019-05-04T13:55:10.9639500' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[PRODUIT] ([ProduitID], [Stock_StockID], [Rayon_RayonID], [Fabricant_FabricantID], [Fournisseur_FournisseurID], [Reference], [Nom], [PrixVente], [PrixAchat], [ReferenceExterne], [StockAlert], [EstCompte], [Description], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'R14H0520O4301190407P746                     ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'Rayon1                                      ', N'Fabricant1                                  ', NULL, N'PR14H0519431047', N'qsdqsd', CAST(135 AS Decimal(15, 0)), CAST(123 AS Decimal(15, 0)), N'qsdqsd', 0, 0, N'qsdqsd', CAST(N'2019-05-04T14:43:07.7468164' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[PRODUIT] ([ProduitID], [Stock_StockID], [Rayon_RayonID], [Fabricant_FabricantID], [Fournisseur_FournisseurID], [Reference], [Nom], [PrixVente], [PrixAchat], [ReferenceExterne], [StockAlert], [EstCompte], [Description], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'R14H0520O5701190418P895                     ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'Rayon1                                      ', N'Fabricant1                                  ', NULL, N'PR14H05195710418', N'sdfqdsfqdsf', CAST(456456 AS Decimal(15, 0)), CAST(4566 AS Decimal(15, 0)), N'sqsdqsd', 0, 0, N'DQSDQS', CAST(N'2019-05-04T14:57:18.8950161' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[PRODUIT] ([ProduitID], [Stock_StockID], [Rayon_RayonID], [Fabricant_FabricantID], [Fournisseur_FournisseurID], [Reference], [Nom], [PrixVente], [PrixAchat], [ReferenceExterne], [StockAlert], [EstCompte], [Description], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'R14H0520O5801190421P558                     ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'Rayon1                                      ', N'Fabricant1                                  ', NULL, N'PR14H05195810421', N'sdfqdsfqdsf', CAST(456456 AS Decimal(15, 0)), CAST(4566 AS Decimal(15, 0)), N'sqsdqsd', 0, 0, N'DQSDQS', CAST(N'2019-05-04T14:58:21.5586269' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[PRODUIT] ([ProduitID], [Stock_StockID], [Rayon_RayonID], [Fabricant_FabricantID], [Fournisseur_FournisseurID], [Reference], [Nom], [PrixVente], [PrixAchat], [ReferenceExterne], [StockAlert], [EstCompte], [Description], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'R15H0520O0401190455P291                     ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'Rayon1                                      ', N'Fabricant1                                  ', NULL, N'PR15H0519410455', N'WSDFSDF', CAST(46 AS Decimal(15, 0)), CAST(45 AS Decimal(15, 0)), N'QSD', 0, 0, N'QSDQSD', CAST(N'2019-05-04T15:04:55.2916701' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[PRODUIT] ([ProduitID], [Stock_StockID], [Rayon_RayonID], [Fabricant_FabricantID], [Fournisseur_FournisseurID], [Reference], [Nom], [PrixVente], [PrixAchat], [ReferenceExterne], [StockAlert], [EstCompte], [Description], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'R15H0520O0701190455P669                     ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'Rayon1                                      ', N'Fabricant1                                  ', NULL, N'PR15H0519710455', N'Consultation Patient', CAST(500 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), N'', 0, 0, N'Frais Consultation', CAST(N'2019-05-04T15:07:55.6699747' AS DateTime2), 1, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[RAYON] ([RayonID], [Stock_StockId], [Code], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Rayon1                                      ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'RAYON02-03', N'pMVx0eVdrY3gGNGnLvZEKA==                    ', CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[RAYON] ([RayonID], [Stock_StockId], [Code], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Rayon2                                      ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'RAYON03-02', N'pMVx0eVdrY3gGNGnLvZEKA==                    ', CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[RAYON] ([RayonID], [Stock_StockId], [Code], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Rayon3                                      ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'RAYON10-23', N'pMVx0eVdrY3gGNGnLvZEKA==                    ', CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[RAYON] ([RayonID], [Stock_StockId], [Code], [Nom], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Rayon4                                      ', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'RAYON50-60', N'pMVx0eVdrY3gGNGnLvZEKA==                    ', CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-10-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[REGLEMENT] ([ReglementID], [Caisse_CaisseID], [Facture_FactureID], [ModePaiement_ModePaiementID], [Motif], [Reference], [MontantNet], [MontantRecu], [MontantRembourse], [MontantARembourse], [MontantRestant], [EstLivre], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'GR/MSwlujyVcsAHrwCFalbuIMYuySsYutGObeQzOy0k=', N'IQ0dre4xQ60gOGYdcS7qrN5sbSmf7IWy19G3sisDwuE=', N'6VmMY3rcMQMCthFjShmqNsfMwoOKj/ll3EgmeR0QrM4=', N'ModePaiement1                               ', NULL, N'Cg6DSGk7UEdJltEk4WQFJozUO4DEDe5WXO9hY46Q1MU=', CAST(100 AS Decimal(15, 0)), CAST(100 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), 0, CAST(N'2019-06-09T21:10:46.0607869' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[REGLEMENT] ([ReglementID], [Caisse_CaisseID], [Facture_FactureID], [ModePaiement_ModePaiementID], [Motif], [Reference], [MontantNet], [MontantRecu], [MontantRembourse], [MontantARembourse], [MontantRestant], [EstLivre], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'ic6mlMKC4Vda+g1orrTLeEgOegsAaM6hnfqYitnE/Jo=', N'IQ0dre4xQ60gOGYdcS7qrN5sbSmf7IWy19G3sisDwuE=', N'6VmMY3rcMQMCthFjShmqNsfMwoOKj/ll3EgmeR0QrM4=', N'ModePaiement1                               ', NULL, N'sAlhFWmmCAUeodmXFN5/YY7YAFs2NURxhK07JLwcqB4=', CAST(100 AS Decimal(15, 0)), CAST(100 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), 0, CAST(N'2019-06-09T21:18:46.6163454' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[REGLEMENT] ([ReglementID], [Caisse_CaisseID], [Facture_FactureID], [ModePaiement_ModePaiementID], [Motif], [Reference], [MontantNet], [MontantRecu], [MontantRembourse], [MontantARembourse], [MontantRestant], [EstLivre], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'rZVDBiOBLKPnKas6HEL24P55hesW5saB0zYp1y7IKew=', N'IQ0dre4xQ60gOGYdcS7qrN5sbSmf7IWy19G3sisDwuE=', N'6VmMY3rcMQMCthFjShmqNsfMwoOKj/ll3EgmeR0QrM4=', N'ModePaiement1                               ', NULL, N'qH0wbM4FvFbMHybByPvqGlaEfvCaaQZg4XgPyzC/jhU=', CAST(200 AS Decimal(15, 0)), CAST(200 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(-300 AS Decimal(15, 0)), 0, CAST(N'2019-06-09T20:35:19.2384530' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[REGLEMENT] ([ReglementID], [Caisse_CaisseID], [Facture_FactureID], [ModePaiement_ModePaiementID], [Motif], [Reference], [MontantNet], [MontantRecu], [MontantRembourse], [MontantARembourse], [MontantRestant], [EstLivre], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'wFjw9tB2KR+OD7QzMDCWEd7R69g4UPzlcVae1xQo/SM=', N'IQ0dre4xQ60gOGYdcS7qrN5sbSmf7IWy19G3sisDwuE=', N'6VmMY3rcMQMCthFjShmqNsfMwoOKj/ll3EgmeR0QrM4=', N'ModePaiement1                               ', NULL, N'FEAYwGktrSGUdlkuPSJFiPwldOrDEJtPHUu32ibzKXY=', CAST(100 AS Decimal(15, 0)), CAST(100 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), CAST(0 AS Decimal(15, 0)), 0, CAST(N'2019-06-09T21:12:18.3601537' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[RENDEZVOUS] ([RendezVousID], [Recepteur_DossierID], [Emetteur_UtilisateurID], [Horaire], [Commentaire], [Recu], [Actif], [Manque], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'JTtcHEldUzxywarZtvPdSnmqMJqOXsa+mUg7ehOhcOo=', N'S/mOQHRjA7/wvxaJsFRYlBluK2fT815XLVSc3llfgKU=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', CAST(N'2019-05-02T10:00:00.0000000' AS DateTime2), N'FScDAjbF3TlTf0u2DPNlMnduGWxPexVSW2av4JXKAbw=', 1, 1, 0, 0, CAST(N'2019-05-08T09:48:39.5707280' AS DateTime2), 1, CAST(N'2019-05-08T09:50:05.5465920' AS DateTime2))
INSERT [dbo].[RENDEZVOUS] ([RendezVousID], [Recepteur_DossierID], [Emetteur_UtilisateurID], [Horaire], [Commentaire], [Recu], [Actif], [Manque], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'pGFTdhqCjujYkzZTncgm62/YrtCCZ7lDjQrNU7gGsGg=', N'q9jvxB7YwT1jkz1bx7hd0+ib724tQkOCOLdlw+PmJ7w=', N'kEijK6KJkzxSJvPyiD5xVSYjMuhixElq9rZ1w2/4qcg=', CAST(N'2019-07-04T06:23:00.0000000' AS DateTime2), N'ejTyZO60xpJTZuoUjTm3bw==', 0, 0, 0, 0, CAST(N'2019-06-09T21:36:34.7510536' AS DateTime2), 1, CAST(N'2019-06-09T21:37:11.6006797' AS DateTime2))
INSERT [dbo].[RENDEZVOUS] ([RendezVousID], [Recepteur_DossierID], [Emetteur_UtilisateurID], [Horaire], [Commentaire], [Recu], [Actif], [Manque], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'vKF4ci+/p57udrSg8xBEHjl6OUFlwASkhDJZBEB5Z0Y=', N'mgVPBxHUN71xBAJi1VktYMV7HwatQmphO9oP0zxQAAY=', N'kEijK6KJkzxSJvPyiD5xVSYjMuhixElq9rZ1w2/4qcg=', CAST(N'2019-05-23T10:30:00.0000000' AS DateTime2), N'/1GCw+gyp7CjRyCmV5hH/yYfrpPlRBC0v6oESjsvt0U=', 1, 1, 0, 0, CAST(N'2019-05-03T14:54:59.8752831' AS DateTime2), 1, CAST(N'2019-06-09T21:35:44.9432896' AS DateTime2))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'AC68PtB//JWmPGxsddZK6RbDXpkA0+Gd6dXP1lRvUQo=', N'evdvfKgw8GCXOp7etUr8jNce/D9KppGAy3Q5NO/OXNY=', N'cbaYSzZaLU+zjiB4GQ9ej0W0Iza1ZJkRLaok6nkxkR0=', NULL, CAST(N'2019-06-04T14:49:46.557' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'ePj3ZAmCA2hGnvCQxVQ95WrBrBv2P2SLIUMZMULQXN4=', N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'0E1YDE41GIsFawn+mt8IHddBIPhkpGdE+uS8LrPKavk=', NULL, CAST(N'2019-05-28T14:46:26.223' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'ermhtgrz1KzP2C9KxePn62JM7mSj4k0cn2TYzeQw/dg=', N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'O8imk65VvNoAHzMu1DFHgQeraMpZHd3Apqz21MMzrwY=', NULL, CAST(N'2019-05-28T14:11:28.880' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'GRoZHJEoVERVq+B2slIY+Hp8aq87opvoPTIPPQXAbMw=', N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'99QfA6eVwsgeTF4eg3hYIP47WMA9NMN8Vm+8QwvjUuc=', NULL, CAST(N'2019-05-28T14:38:01.777' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'hijVE16lbzJpKqXDR3X8cyqfdTf797wF0qPIUD+2rwI=', N'evdvfKgw8GCXOp7etUr8jNce/D9KppGAy3Q5NO/OXNY=', N'Tgs/nVf7FAExrBYNUskglXbS1mBgvzyu5/H+Bc0hzfs=', NULL, CAST(N'2019-06-04T15:02:16.393' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'hQecH+6Eidb4EoLQUKa5YO5eVCnLnpWGcg0z0MF3qdg=', N'evdvfKgw8GCXOp7etUr8jNce/D9KppGAy3Q5NO/OXNY=', N'+tNuCOwj0ATHYLjPn9/+iDChzSgg3ku59p5nybcY3fc=', NULL, CAST(N'2019-06-04T14:44:00.963' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'kAFSN0jfxxcSRI5N6Sg2lbtVlLyC5+RkEQPeOXItHko=', N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'+60QUqxOjr50Gy15vSWrDKrJHvLXjYjHG5cC/7t6exc=', NULL, CAST(N'2019-05-28T13:45:01.457' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'n/JOBjmm/eQoU3A8Hor2VyuFrP+ZHM4QQsf4KjJUIBY=', N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'V6mNERE3CEOulYtGVjM8ztLx91DpYEc9QjuwUBr2cmU=', NULL, CAST(N'2019-05-28T14:28:26.787' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'QIXoBxwdWSbMLpvcIx03A0nqswd06SKZGDRRMbFjlxc=', N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'kfHSB7y+xq5CBOnWNU/OsBi/gpniynC83yHccPkL2ro=', NULL, CAST(N'2019-05-28T12:40:16.983' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'ULIE7jK/HC4/Phe1suWlECzPX2PVqzyrsgGvGrwAD44=', N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'LkebMznYZKkN3MCkLe26zT0j98Ozf6dI0i7QW/EhzSI=', NULL, CAST(N'2019-05-28T14:04:16.207' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'uPp2EafSNtbLIni8sLck/964CBM/BuDlgok7ssjrn00=', N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'waSBEC0tX8iSwocasMacj+LokTkLxpETafFvxU1lBU4=', NULL, CAST(N'2019-05-28T14:02:53.070' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'xvm3K4HgvqZWvORpGbJrzvMLnD4q6D3N5iCuQ7HUxjc=', N'uwI/lNmykKly+jC5xQI5G9uQvW3/uery6DzzVFar1kw=', N'ruaI+3ZAM1MTF+zvO908JbMkRZFzTKlEVbrSDjH/4cw=', NULL, CAST(N'2019-06-09T21:39:24.350' AS DateTime))
INSERT [dbo].[RESULTAT] ([ResultatID], [Examen_ExamenID], [Reference], [Description], [DateCreation]) VALUES (N'ZShVmRpN0Pzlrw/qvj5aIRS2MBPh/Gzss41lrS2eWlE=', N'eXQD4XlScEngVeYcnk/cIw+I9GGx4g/ZuqzgZtR/5fc=', N'j3LApmPV5yRe6SPohxGzXBDWeujDI6cz+bo24vElSO0=', NULL, CAST(N'2019-05-28T14:55:36.967' AS DateTime))
INSERT [dbo].[ROLE] ([RoleID], [Intitule], [DateCreation], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=', N'BE/8uuHguiAkIFUozybl9pdzLYMrjCiEuodu8My5jyk=', CAST(N'2018-02-05T15:18:21.9530000' AS DateTime2), 0, CAST(N'2018-02-05T15:18:21.9530000' AS DateTime2), 1, CAST(N'2018-06-08T13:51:34.6403737' AS DateTime2))
INSERT [dbo].[ROLE] ([RoleID], [Intitule], [DateCreation], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=', N'MO9xIISmhgwcPaBIDNSSWA==', CAST(N'2018-06-20T13:21:16.0753155' AS DateTime2), 0, CAST(N'2018-06-20T13:21:16.0753155' AS DateTime2), 1, CAST(N'2019-04-26T13:42:17.9092157' AS DateTime2))
INSERT [dbo].[ROLE] ([RoleID], [Intitule], [DateCreation], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'e7bu8bYKvcVILlNX3EV3Mwh1aynymBsrXbxVhcDZh9Y=', N'BE/8uuHguiAkIFUozybl9o6dvBTxvMc/UjFKJHrlUyY=', CAST(N'2018-06-20T13:24:14.3609666' AS DateTime2), 0, CAST(N'2018-06-20T13:24:14.3609666' AS DateTime2), 1, CAST(N'2019-04-26T16:58:44.5844461' AS DateTime2))
INSERT [dbo].[ROLE] ([RoleID], [Intitule], [DateCreation], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'ekLNzG59BlBR+0UBEtZ4aaDvr8Q0y7p4ac7S+YDhgRw=', N'YDeaEV8f9wf79b+E7Dt4wpctSkSgiRFVoto93cnmmfM=', CAST(N'2018-06-20T14:07:05.6034017' AS DateTime2), 0, CAST(N'2018-06-20T14:07:05.6034017' AS DateTime2), 1, CAST(N'2019-04-26T16:59:17.1930575' AS DateTime2))
INSERT [dbo].[ROLE] ([RoleID], [Intitule], [DateCreation], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'LlUxN+GQnDhnXdh5mCUMzjy2erqNfOIWC0BlANc1cwY=', N'j8KpzTi4GlU/gbRO4AZWQA==', CAST(N'2019-04-26T17:03:46.0997620' AS DateTime2), 0, CAST(N'2019-04-26T17:03:46.0997620' AS DateTime2), 0, CAST(N'2019-04-26T17:03:46.0997620' AS DateTime2))
INSERT [dbo].[ROLE] ([RoleID], [Intitule], [DateCreation], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'MSggRC3TRLhzIWI2ptqLmx5tuQokKwbNOnWnu9866hM=', N'hUwLdcdRDxeH4zqAmum9fg==', CAST(N'2019-04-26T17:04:48.5523807' AS DateTime2), 0, CAST(N'2019-04-26T17:04:48.5523807' AS DateTime2), 0, CAST(N'2019-04-26T17:04:48.5523807' AS DateTime2))
INSERT [dbo].[ROLE] ([RoleID], [Intitule], [DateCreation], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=', N'ERUmj4fzUs7vX7ugBA+fnA==', CAST(N'2018-06-20T13:12:18.5142042' AS DateTime2), 0, CAST(N'2018-06-20T13:12:18.5142042' AS DateTime2), 1, CAST(N'2019-04-26T16:57:51.5459080' AS DateTime2))
INSERT [dbo].[SERVICE] ([ServiceID], [Nom], [DateCreation]) VALUES (N'Service1                                    ', N'C. Hematologie', CAST(N'2019-02-02T00:00:00.000' AS DateTime))
INSERT [dbo].[SERVICE] ([ServiceID], [Nom], [DateCreation]) VALUES (N'Service2                                    ', N'Consultation', CAST(N'2019-02-02T00:00:00.000' AS DateTime))
INSERT [dbo].[STOCK] ([StockID], [Utilisateur_UtilisateurID], [StockType_StockTypeID], [Nom], [IsStocktCentral], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'IHdar5nRkB97y/gRyq8eFFoF5qIYAlZC9skJotlzm1I=', N'gkS4zaZR8LXQwAzao7/XCg==                    ', 0, CAST(N'2019-05-20T16:51:43.1221118' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCK] ([StockID], [Utilisateur_UtilisateurID], [StockType_StockTypeID], [Nom], [IsStocktCentral], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'N5zCpdtiZWMQUM1OVsd0k9Gb7et5+m9i8WoC2dm/+k0=', N'kEijK6KJkzxSJvPyiD5xVSYjMuhixElq9rZ1w2/4qcg=', N'IHdar5nRkB97y/gRyq8eFFoF5qIYAlZC9skJotlzm1I=', N'8fT8EgYZo9os/+KQihacEw==                    ', 0, CAST(N'2019-05-21T14:12:31.3485584' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCK] ([StockID], [Utilisateur_UtilisateurID], [StockType_StockTypeID], [Nom], [IsStocktCentral], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'IHdar5nRkB97y/gRyq8eFE16CW2n/gUmCm5YurfOTX4=', N'pMVx0eVdrY3gGNGnLvZEKA==                    ', 1, CAST(N'2019-05-15T13:38:50.0779076' AS DateTime2), 0, 1, CAST(N'2019-05-16T22:25:22.0398166' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'+odBvD3gZXszXqAjQ25pysSg2Wrz74DOtCpyQuQ2Zok=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2020-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T11:19:22.7457198' AS DateTime2), 0, 1, CAST(N'2019-05-21T12:00:48.6745540' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'00UHop2QthflIwFjOQKovAxtq/z4EOWz8NA29tLLQuc=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 23, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-20T21:46:48.7745199' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'0WSQCKrCsP3+sarPSExwy0ykkruUbOoj06EwrKdHHYI=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 23, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:47:33.7052326' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'2jSFhp8neBFafTycpiBj6mBq6RsFUsESUPMOx73DyJ8=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 26, 0, CAST(N'2020-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T12:01:29.0535540' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'3w+PFeyUw9V3wQfEM1p7Yi7w4BGZt7Ky3UdEWepmXQI=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2020-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-17T12:00:25.5653510' AS DateTime2), 0, 1, CAST(N'2019-05-21T12:01:38.2328567' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'3w+PFeyUw9V3wQfEM1p7YkCKlcFG4dSKNAvHSPQK22Q=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2019-05-24T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-17T12:00:57.4917028' AS DateTime2), 0, 1, CAST(N'2019-05-21T11:59:23.0887662' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'3w+PFeyUw9V3wQfEM1p7Yrx7Tt76kB3V7FwsJuJQLQ0=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2019-05-18T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-17T12:00:57.4487289' AS DateTime2), 0, 1, CAST(N'2019-05-21T11:50:19.6259547' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'4RY4PZCrxvsm2H6SlJ/r2QkHr1/G1Z8ikwLKjPbEtR8=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R15H0520O0701190455P669                     ', 4, 0, CAST(N'2019-05-24T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T11:49:20.0902751' AS DateTime2), 0, 1, CAST(N'2019-05-18T11:51:09.8177205' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'a9gANo+fPBb1R1AYDFoP+NBRMxPVLvhOHeljp4mxv9A=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 6, 0, CAST(N'2023-03-05T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T12:02:34.3142081' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'cb4Ro7mh3eqaAky1aHkapA7cHknl7NW80c0I1XfZgFY=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R14H0520O5701190418P895                     ', 150, 0, CAST(N'2019-05-26T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:55:10.2654583' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'DwSzuDtLgkeRF8/qo/RaugiIw9Z24vgHTHGFoRkqtX8=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 23, 0, CAST(N'2019-05-24T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:59:10.6992812' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'fDCyA6kpLk/uJtUC3+QSL5saW/QgEyfJn3dt8kvVKaI=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 7, 0, CAST(N'2019-05-18T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:49:48.2660894' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'fxnJlJE7qG8Tng4IOrWXt2t1JMZKKhdM2FP0mJS3hGQ=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 97, 0, CAST(N'2020-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:50:20.3515060' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'fxnJlJE7qG8Tng4IOrWXt5ti0kOjZAonKpgDrz+Ck6E=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 12, 0, CAST(N'2021-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:50:20.3575012' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'fxnJlJE7qG8Tng4IOrWXt9DpsSTdK28iQqNIdZ72kgk=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 97, 0, CAST(N'2020-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:50:20.3185247' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'fxnJlJE7qG8Tng4IOrWXty+TzT1YlqWP/7+qvJdY69w=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 97, 0, CAST(N'2019-05-24T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:50:20.1526283' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'fxnJlJE7qG8Tng4IOrWXtyxwpq/Q9OLFfPFAaQ4Snso=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', -12, 0, CAST(N'2023-03-05T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:50:20.5144027' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'iOWVY5hz7651WsYz/GCuntBR1r9gGaEKyuldHdvASAY=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R15H0520O0401190455P291                     ', 6, 0, CAST(N'2019-05-25T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T12:01:21.1159356' AS DateTime2), 0, 1, CAST(N'2019-05-18T12:01:21.2818305' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'j5Z4OKQtSK2qhJ5w5enVXFYgxX8KM+JC60lpzcJW2jE=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R13H0520O5501190410P963                     ', 2, 0, CAST(N'2019-07-19T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T11:42:57.0422456' AS DateTime2), 0, 1, CAST(N'2019-05-18T11:42:57.1841584' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'j5Z4OKQtSK2qhJ5w5enVXP63fIDoxpp6jZ74IjoUJ30=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R14H0520O5701190418P895                     ', 98, 0, CAST(N'2019-05-26T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T11:42:18.4248841' AS DateTime2), 0, 1, CAST(N'2019-05-18T11:42:18.7416882' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'kpYzkegCSiu3tk7a9n1QVcEEjPmNHkrFb8629zOXe/4=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R14H0520O5801190421P558                     ', 120, 0, CAST(N'2019-05-23T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-17T17:40:06.3670827' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'LMu0MMtOKcjBnSWSLVg1IC5iDN4L+G2unV8P5QG44N8=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R15H0520O0401190455P291                     ', 7, 0, CAST(N'2019-05-30T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T12:03:45.2131501' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'LMu0MMtOKcjBnSWSLVg1IFh6vGgVw0WsGFQEBh7EL5c=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R13H0520O0201190433P385                     ', 7, 0, CAST(N'2019-05-25T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T12:03:44.9693020' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'LwxHB3vMTmC7PmXspUjIfBeOciD5h5oUst4WV8/c4ek=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R08H0520O2101190636P919                     ', 29, 0, CAST(N'2023-03-05T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-17T11:50:41.7281841' AS DateTime2), 0, 1, CAST(N'2019-05-21T12:02:34.4811106' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'LwxHB3vMTmC7PmXspUjIfNK/5QDrcqPdXQaMLIpV16Y=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-17T11:50:41.8261221' AS DateTime2), 0, 1, CAST(N'2019-05-21T11:47:41.9930894' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'n34fbkCvnSKIiThvuGX6Khxl07nMTlADCe7eYFTXn84=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 23, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:40:15.0444374' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'n34fbkCvnSKIiThvuGX6Kl0DiFJMmjFDMZPEjBDAuFk=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 7, 0, CAST(N'2019-05-18T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:40:47.5242404' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'n34fbkCvnSKIiThvuGX6KsjpnU2f3LT2e+th2yyFr/o=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 120, 0, CAST(N'2019-05-24T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:40:47.6371701' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'r8npMRf5mquoj7i/NAzpgoi3Hm3h7JNW0E/YOMwQuMA=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 23, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:39:39.0062858' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'vJmcAMdJOqdBLgR9v4FMCapl0WOBfRGEUIIvWFuF5Jc=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R14H0520O4301190407P746                     ', 2, 0, CAST(N'2019-05-18T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T12:04:20.5443929' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'vJmcAMdJOqdBLgR9v4FMCTIyzV17Gp8tAqCwE5hCbHo=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R13H0520O5501190410P963                     ', 2, 0, CAST(N'2019-05-18T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T12:04:20.4454540' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'y1dVo8WCdikZQeY6kdrsxaQW1Jv5gyTmEhfR5bhn7Vk=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2019-05-18T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:37:17.1843967' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'y1dVo8WCdikZQeY6kdrsxR/rH6SIlPZw5CvUvQsiePw=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2019-05-24T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:37:17.5323999' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'y1dVo8WCdikZQeY6kdrsxRMXCEi/Ya3GomL1MJJq5mU=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2020-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:37:17.6511954' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'y1dVo8WCdikZQeY6kdrsxT4v1Qm8isxtLVSza+DWNGE=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2021-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:37:17.7161706' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'y1dVo8WCdikZQeY6kdrsxUnMNEEyFe1GTRHej8NwAik=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:37:16.8823052' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'y1dVo8WCdikZQeY6kdrsxVEtxwMg2k/LLEYPcu8sZeQ=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2020-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:37:17.5467460' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'y1dVo8WCdikZQeY6kdrsxX71ccni/s7/0O7nsWwoDFA=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2023-03-05T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T11:37:17.7436679' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'Yj79PzwxT0iQlyLVKBXICdmDSkxNomyILvWS3rO5XO8=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 23, 0, CAST(N'2020-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-21T12:00:37.7443361' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'YP0Vhvw3xAA6ZlCHfXOGggWbh8ILIzTQYGHUlfTNGpc=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 7, 0, CAST(N'2019-05-18T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-20T21:49:23.6177425' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'YP0Vhvw3xAA6ZlCHfXOGgibm1RQZmQ3duR7L2j4Bffg=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 120, 0, CAST(N'2019-05-24T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-20T21:49:23.7006897' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'YP0Vhvw3xAA6ZlCHfXOGgog7W8p3cj3uzuFrzLfZ6/8=', N'1kd2prQz0Ikq7AWlWZ1YfXSgFhoiDmAXq77XYMXOOBo=', N'R08H0520O2101190636P919                     ', 120, 0, CAST(N'2020-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-20T21:49:23.7736424' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'z5rwi7ijTw6XGncHHlXgwcRHHKeCO+kwPG9clqHp2aQ=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'2021-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-17T11:44:40.6491933' AS DateTime2), 0, 1, CAST(N'2019-05-21T11:50:20.4704299' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'z5rwi7ijTw6XGncHHlXgwV6JxoR1slkvyfdbS1LpA58=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-17T11:44:42.3411427' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'z5rwi7ijTw6XGncHHlXgwVYKzdKM+AG3eUsOkDTAaoc=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R08H0520O2101190636P919                     ', 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-17T11:44:42.5799953' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'zMz24g1+sOBy8BdIKSwNRjZUw/xhW7zCGRNd43YNlN8=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R14H0520O4301190407P746                     ', 2, 0, CAST(N'2019-05-25T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T11:43:11.6992967' AS DateTime2), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKDETAILS] ([StockDetailsID], [Stock_StockID], [Produit_ProduitID], [StockQuantity], [StockAlert], [DateExpiration], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'zMz24g1+sOBy8BdIKSwNRpArPo6K+0DMGNcha9caCNk=', N'p5zangKodJX6D2JMZyGewCoLakFMRxr2+OQSGAlFGBI=', N'R15H0520O0401190455P291                     ', 0, 0, CAST(N'2019-05-31T00:00:00.0000000' AS DateTime2), CAST(N'2019-05-18T11:43:32.0796513' AS DateTime2), 0, 1, CAST(N'2019-05-18T11:43:32.1915800' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKTYPE] ([StockTypeId], [Nom], [IsActif], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'IHdar5nRkB97y/gRyq8eFE16CW2n/gUmCm5YurfOTX4=', N'sM5Qpn8BuFdfLhr1IE66Qg==                    ', 1, CAST(N'2019-05-21T14:28:37.237' AS DateTime), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKTYPE] ([StockTypeId], [Nom], [IsActif], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'IHdar5nRkB97y/gRyq8eFFoF5qIYAlZC9skJotlzm1I=', N'XfoF1+38D+f0ZSdfLmKHSw==                    ', 1, CAST(N'2019-05-21T14:28:52.337' AS DateTime), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[STOCKTYPE] ([StockTypeId], [Nom], [IsActif], [DateCreation], [IsDeleted], [IsModified], [DateModification], [DateSuppression]) VALUES (N'IHdar5nRkB97y/gRyq8eFHCh8Oaay6rXOPir07oLuZQ=', N'8fT8EgYZo9os/+KQihacEw==                    ', 1, CAST(N'2019-05-21T14:28:03.587' AS DateTime), 0, 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[TRAITEMENT] ([TraitementID], [Diagnostic_DiagnosticID], [Specialiste_UtilisateurID], [Recommandation], [DateTraitement], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'/t+FTu/pr54FoNSJJKu8daX/+fTeqR1+mR32CWMK4PE=', N'Vgo9vuHhkC9O1I9RWiaoH8xzl06XsBC6K1WRgoI/CCw=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'4ZTEcNRm3P0AiZX1uL/7oPisXXCmubU5dE/Cd8TDDp4qT0IT4YwEy7Q2VyGsx62QV559Jb+CaGNuE/t4/Nk6Mw==', CAST(N'2019-05-03T14:43:43.6890723' AS DateTime2), 0, CAST(N'2019-05-03T14:43:43.6910690' AS DateTime2), 0, CAST(N'2019-05-03T14:43:43.6910690' AS DateTime2))
INSERT [dbo].[TRAITEMENT] ([TraitementID], [Diagnostic_DiagnosticID], [Specialiste_UtilisateurID], [Recommandation], [DateTraitement], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'b5ZEur6FzuIGkfWd0uoyesgaFWKH4rbRt7jHin/V4n4=', N'tR+/BD4cao4z4ejKAfYHutUIRIPxQUX1vhxoX0dLqgw=', N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'PetxDkxd8wh1+/iOQNJUNw9xTXr8YaAegdRAsWh8d5nDHkCJJXu645eQZds3LCeI', CAST(N'2019-05-08T09:44:40.0661844' AS DateTime2), 0, CAST(N'2019-05-08T09:44:40.0671842' AS DateTime2), 0, CAST(N'2019-05-08T09:44:40.0671842' AS DateTime2))
INSERT [dbo].[TYPEGROUPE] ([TypeGroupeID], [Objet], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'JhQsOxL9dXCGnhAzZxh5+jrYgBRof/ojVyuswUIWSnA=', N'52IJEnG6uRRN7HVk9STbM75s8JVgXEX/GjA1NHvqcRk=                                    ', 0, CAST(N'2018-02-06T09:34:33.5630000' AS DateTime2), 0, CAST(N'2018-02-06T09:34:33.5630000' AS DateTime2))
INSERT [dbo].[TYPEGROUPE] ([TypeGroupeID], [Objet], [IsDeleted], [DateSuppression], [IsModified], [DateModification]) VALUES (N'JhQsOxL9dXCGnhAzZxh5+jrYgBRof/ojVyuswUIWSnB=', N'rc/KGfmfse/NccO8KsjTWnAU/kSHmqB7ncWc1OoSs56b6P7hDqfHMvH6eEUdTWu3                ', 0, CAST(N'2018-02-06T09:34:33.5630000' AS DateTime2), 0, CAST(N'2018-02-06T09:34:33.5630000' AS DateTime2))
INSERT [dbo].[UTILISATEUR] ([UtilisateurID], [Personne_PersonneID], [DateCreation], [Login], [Password], [Fonction], [Actif], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [Role_RoleID]) VALUES (N'kEijK6KJkzxSJvPyiD5xVSYjMuhixElq9rZ1w2/4qcg=', N'Dfy5MumxoPHEMpL5Og2bA1HTvF5QI4ShQ+SHXao1l0I=', CAST(N'2019-04-16T14:37:43.7284690' AS DateTime2), N'E33mp0AO+j2hmi69+JCXIQ==', N'E33mp0AO+j2hmi69+JCXIQ==', NULL, 1, 0, CAST(N'2019-04-16T14:37:43.7804374' AS DateTime2), 0, CAST(N'2019-04-26T17:05:59.9880144' AS DateTime2), N'4qqum3UcSSw01TTCKb6HceQMrhMpw05xDyF710tX/Ws=')
INSERT [dbo].[UTILISATEUR] ([UtilisateurID], [Personne_PersonneID], [DateCreation], [Login], [Password], [Fonction], [Actif], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [Role_RoleID]) VALUES (N'PkJJfBjL+U34nBLsbi99aDM9BGMicBetSVc33F6iSto=', N'czIedKb1A0YTGHQTdnRCT/Njevq744hAVd4kOSo0EU4=', CAST(N'2019-04-01T15:27:47.4729782' AS DateTime2), N'cL3MNXLwajPMCJoAHGv1hg==', N'ahV3H3LKv+0wuXJewiWpuA==', N'T2tUcB+GDqte7VONsK+V589b7Kt93jmYZm/mV73oPlQ=', 1, 0, CAST(N'2019-04-01T15:27:47.5199506' AS DateTime2), 0, CAST(N'2019-06-09T09:30:03.6843559' AS DateTime2), N'/p9N2gPlMpXQUrE+5j6T/tUq4lL8zDPsosX6ZPE1Ixw=')
INSERT [dbo].[UTILISATEUR] ([UtilisateurID], [Personne_PersonneID], [DateCreation], [Login], [Password], [Fonction], [Actif], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [Role_RoleID]) VALUES (N'Wh18JZShQpu6vEsqQVNxth+F5ZkDpHCB+SrcfrTeLi4=', N'a5+w3MSejGMZjCTPxrFhUMdAsu859mC2W4KLMP8qgaM=', CAST(N'2019-04-09T15:01:00.0000000' AS DateTime2), N'Wh18JZShQpu6vEsqQVNxth+F5ZkDpHCB+SrcfrTkjdi4=', N'Wh18JZShQpu6vEsqQVNxth+F5ZkDpHCB+lki4=', N'Infimier', 1, 0, CAST(N'2019-04-15T05:02:00.0000000' AS DateTime2), 0, CAST(N'2019-04-16T05:02:00.0000000' AS DateTime2), N'LlUxN+GQnDhnXdh5mCUMzjy2erqNfOIWC0BlANc1cwY=')
INSERT [dbo].[UTILISATEUR] ([UtilisateurID], [Personne_PersonneID], [DateCreation], [Login], [Password], [Fonction], [Actif], [IsDeleted], [DateSuppression], [IsModified], [DateModification], [Role_RoleID]) VALUES (N'Wh28JZShQpu6vEsqQVNxth+F5ZkDpHCB+SrcfrTeLi4=', N'HGUwnL93+cfYIVCzxmTZ4p0ebw75hkjbAuWjhNZsMVc=', CAST(N'2019-04-26T11:22:15.2515630' AS DateTime2), N'zzKRiQSYX8MSysl9HttipA==', N'zzKRiQSYX8MSysl9HttipA==', NULL, 1, 0, CAST(N'2019-04-26T11:22:15.2855452' AS DateTime2), 0, CAST(N'2019-04-26T17:29:21.6257907' AS DateTime2), N'unmJ08uA/zhZJEbTt2D8k/kzDfC5ei1WeOjsKpQH0Qc=')
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ux_ProductManufacturer_Name]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[FABRICANT] ADD  CONSTRAINT [Ux_ProductManufacturer_Name] UNIQUE NONCLUSTERED 
(
	[Nom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_PurchaseInvoice_Reference]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[FACTURE] ADD  CONSTRAINT [U_PurchaseInvoice_Reference] UNIQUE NONCLUSTERED 
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_Inventory_Reference]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[INVENTAIRE] ADD  CONSTRAINT [U_Inventory_Reference] UNIQUE NONCLUSTERED 
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ux_Inventory_Reference]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[INVENTAIRE] ADD  CONSTRAINT [Ux_Inventory_Reference] UNIQUE NONCLUSTERED 
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_InventoryCountingDetail_InventoryProduct]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[INVENTAIREDETAILS] ADD  CONSTRAINT [U_InventoryCountingDetail_InventoryProduct] UNIQUE NONCLUSTERED 
(
	[Inventaire_InventaireID] ASC,
	[Produit_ProduitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_SalesDelivery]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[LIVRAISON] ADD  CONSTRAINT [U_SalesDelivery] UNIQUE NONCLUSTERED 
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ux_SalesDelivery_Reference]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[LIVRAISON] ADD  CONSTRAINT [Ux_SalesDelivery_Reference] UNIQUE NONCLUSTERED 
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ux_Product_Reference]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[PRODUIT] ADD  CONSTRAINT [Ux_Product_Reference] UNIQUE NONCLUSTERED 
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [U_SalesPayment_Reference]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[REGLEMENT] ADD  CONSTRAINT [U_SalesPayment_Reference] UNIQUE NONCLUSTERED 
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ux_StockInOut_Reference]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[STOCKMOUVEMENT] ADD  CONSTRAINT [Ux_StockInOut_Reference] UNIQUE NONCLUSTERED 
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ux_StockTransfer_Reference]    Script Date: 6/9/2019 11:12:07 PM ******/
ALTER TABLE [dbo].[STOCKTRANSFERT] ADD  CONSTRAINT [Ux_StockTransfer_Reference] UNIQUE NONCLUSTERED 
(
	[Reference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CAISSE] ADD  CONSTRAINT [DF_CashRegister_Label]  DEFAULT ('') FOR [Nom]
GO
ALTER TABLE [dbo].[CAISSEMOUVEMENT] ADD  CONSTRAINT [DF_CashRegisterInOut_IsValidated]  DEFAULT ((0)) FOR [EstValide]
GO
ALTER TABLE [dbo].[FACTURE] ADD  CONSTRAINT [DF_PurchaseInvoice_AdvancedAmount]  DEFAULT ((0)) FOR [Montant]
GO
ALTER TABLE [dbo].[FACTURE] ADD  CONSTRAINT [DF_PurchaseInvoice_IsValidated]  DEFAULT ((0)) FOR [EstValide]
GO
ALTER TABLE [dbo].[FACTURE] ADD  CONSTRAINT [DF_PurchaseInvoice_IsPaid]  DEFAULT ((0)) FOR [EstPaye]
GO
ALTER TABLE [dbo].[FACTUREDETAILS] ADD  CONSTRAINT [DF_SalesInvoiceDetail_Quantity]  DEFAULT ((0)) FOR [Quantite]
GO
ALTER TABLE [dbo].[FACTUREDETAILS] ADD  CONSTRAINT [DF_SalesInvoiceDetail_AmountAllTaxExcludedWithDiscount]  DEFAULT ((0)) FOR [PrixUnitaire]
GO
ALTER TABLE [dbo].[INVENTAIRE] ADD  CONSTRAINT [DF_Inventory_IsValidated1]  DEFAULT ((0)) FOR [EstFini]
GO
ALTER TABLE [dbo].[INVENTAIRE] ADD  CONSTRAINT [DF_Inventory_IsValidated]  DEFAULT ((0)) FOR [EstValide]
GO
ALTER TABLE [dbo].[INVENTAIREDETAILS] ADD  CONSTRAINT [DF_Table_1_DeliveredQuantity]  DEFAULT ((0)) FOR [QuantiteReelle]
GO
ALTER TABLE [dbo].[LIVRAISON] ADD  CONSTRAINT [DF_DeliveryNote_IsValidated]  DEFAULT ((0)) FOR [EstValide]
GO
ALTER TABLE [dbo].[PRODUIT] ADD  CONSTRAINT [DF_Product_PU]  DEFAULT ((0)) FOR [PrixVente]
GO
ALTER TABLE [dbo].[PRODUIT] ADD  CONSTRAINT [DF_PRODUIT_StockAlert]  DEFAULT ((0)) FOR [StockAlert]
GO
ALTER TABLE [dbo].[PRODUIT] ADD  CONSTRAINT [DF_Product_IsCount]  DEFAULT ((0)) FOR [EstCompte]
GO
ALTER TABLE [dbo].[REGLEMENT] ADD  CONSTRAINT [DF_SalesPayment_Reason]  DEFAULT ('') FOR [Motif]
GO
ALTER TABLE [dbo].[REGLEMENT] ADD  CONSTRAINT [DF_SalesPayment_AmountPaid1]  DEFAULT ((0)) FOR [MontantNet]
GO
ALTER TABLE [dbo].[REGLEMENT] ADD  CONSTRAINT [DF_SalesPayment_AmountReceived]  DEFAULT ((0)) FOR [MontantRecu]
GO
ALTER TABLE [dbo].[REGLEMENT] ADD  CONSTRAINT [DF_SalesPayment_AmountToReimburse]  DEFAULT ((0)) FOR [MontantRembourse]
GO
ALTER TABLE [dbo].[REGLEMENT] ADD  CONSTRAINT [DF_SalesPayment_AmountReimbursed]  DEFAULT ((0)) FOR [MontantARembourse]
GO
ALTER TABLE [dbo].[REGLEMENT] ADD  CONSTRAINT [DF_SalesPayment_IsValidated]  DEFAULT ((0)) FOR [EstLivre]
GO
ALTER TABLE [dbo].[STOCKDETAILS] ADD  CONSTRAINT [DF_StoreProduct_StockQuantity]  DEFAULT ((0)) FOR [StockQuantity]
GO
ALTER TABLE [dbo].[STOCKDETAILS] ADD  CONSTRAINT [DF_StoreProduct_StockQuantity1]  DEFAULT ((0)) FOR [StockAlert]
GO
ALTER TABLE [dbo].[STOCKMOUVEMENT] ADD  CONSTRAINT [DF_StockInOut_IsValidated]  DEFAULT ((0)) FOR [IsValidated]
GO
ALTER TABLE [dbo].[STOCKTRANSFERT] ADD  CONSTRAINT [DF_StockTransfer_IsValidated]  DEFAULT ((0)) FOR [EstValide]
GO
ALTER TABLE [dbo].[ACCES]  WITH CHECK ADD  CONSTRAINT [FK_ACCES_PRIVILEGE] FOREIGN KEY([Privilege_PrivilegeID])
REFERENCES [dbo].[PRIVILEGE] ([PrivilegeID])
GO
ALTER TABLE [dbo].[ACCES] CHECK CONSTRAINT [FK_ACCES_PRIVILEGE]
GO
ALTER TABLE [dbo].[ACCES]  WITH CHECK ADD  CONSTRAINT [FK_ACCES_ROLE] FOREIGN KEY([Role_RoleID])
REFERENCES [dbo].[ROLE] ([RoleID])
GO
ALTER TABLE [dbo].[ACCES] CHECK CONSTRAINT [FK_ACCES_ROLE]
GO
ALTER TABLE [dbo].[ATTENTE]  WITH CHECK ADD  CONSTRAINT [FK_ATTENTE_DOSSIER] FOREIGN KEY([Patient_DossierID])
REFERENCES [dbo].[DOSSIER] ([DossierID])
GO
ALTER TABLE [dbo].[ATTENTE] CHECK CONSTRAINT [FK_ATTENTE_DOSSIER]
GO
ALTER TABLE [dbo].[ATTENTE]  WITH CHECK ADD  CONSTRAINT [FK_ATTENTE_UTILISATEUR] FOREIGN KEY([Specialiste_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[ATTENTE] CHECK CONSTRAINT [FK_ATTENTE_UTILISATEUR]
GO
ALTER TABLE [dbo].[CAISSEOUVERTUREFERMETURE]  WITH CHECK ADD  CONSTRAINT [FK_CAISSEOUVERTUREFERMETURE_CAISSE] FOREIGN KEY([Caisse_CaisseID])
REFERENCES [dbo].[CAISSE] ([CaisseID])
GO
ALTER TABLE [dbo].[CAISSEOUVERTUREFERMETURE] CHECK CONSTRAINT [FK_CAISSEOUVERTUREFERMETURE_CAISSE]
GO
ALTER TABLE [dbo].[CAISSEOUVERTUREFERMETURE]  WITH CHECK ADD  CONSTRAINT [FK_CAISSEOUVERTUREFERMETURE_UTILISATEUR] FOREIGN KEY([Utilisateur_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[CAISSEOUVERTUREFERMETURE] CHECK CONSTRAINT [FK_CAISSEOUVERTUREFERMETURE_UTILISATEUR]
GO
ALTER TABLE [dbo].[DIAGNOSTIC]  WITH CHECK ADD  CONSTRAINT [FK_Diagnostic_Dossier] FOREIGN KEY([Dossier_DossierID])
REFERENCES [dbo].[DOSSIER] ([DossierID])
GO
ALTER TABLE [dbo].[DIAGNOSTIC] CHECK CONSTRAINT [FK_Diagnostic_Dossier]
GO
ALTER TABLE [dbo].[DIAGNOSTIC]  WITH CHECK ADD  CONSTRAINT [FK_DIAGNOSTIC_MALADIE] FOREIGN KEY([Maladie_MaladieID])
REFERENCES [dbo].[MALADIE] ([MaladieID])
GO
ALTER TABLE [dbo].[DIAGNOSTIC] CHECK CONSTRAINT [FK_DIAGNOSTIC_MALADIE]
GO
ALTER TABLE [dbo].[DIAGNOSTIC]  WITH CHECK ADD  CONSTRAINT [FK_Diagnostic_Utilisateur] FOREIGN KEY([Auteur_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[DIAGNOSTIC] CHECK CONSTRAINT [FK_Diagnostic_Utilisateur]
GO
ALTER TABLE [dbo].[DOSSIER]  WITH CHECK ADD  CONSTRAINT [FK_Dossier_Personne] FOREIGN KEY([Patient_PersonneID])
REFERENCES [dbo].[PERSONNE] ([PersonneID])
GO
ALTER TABLE [dbo].[DOSSIER] CHECK CONSTRAINT [FK_Dossier_Personne]
GO
ALTER TABLE [dbo].[DOSSIER]  WITH CHECK ADD  CONSTRAINT [FK_Dossier_Utilisateur] FOREIGN KEY([Createur_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[DOSSIER] CHECK CONSTRAINT [FK_Dossier_Utilisateur]
GO
ALTER TABLE [dbo].[EXAMEN]  WITH CHECK ADD  CONSTRAINT [FK_EXAMEN_DIAGNOSTIC] FOREIGN KEY([Diagnostic_DiagnosticID])
REFERENCES [dbo].[DIAGNOSTIC] ([DiagnosticID])
GO
ALTER TABLE [dbo].[EXAMEN] CHECK CONSTRAINT [FK_EXAMEN_DIAGNOSTIC]
GO
ALTER TABLE [dbo].[EXAMEN]  WITH CHECK ADD  CONSTRAINT [FK_EXAMEN_DOSSIER] FOREIGN KEY([Dossier_DossierID])
REFERENCES [dbo].[DOSSIER] ([DossierID])
GO
ALTER TABLE [dbo].[EXAMEN] CHECK CONSTRAINT [FK_EXAMEN_DOSSIER]
GO
ALTER TABLE [dbo].[EXAMEN]  WITH CHECK ADD  CONSTRAINT [FK_EXAMEN_EXAMENTYPE] FOREIGN KEY([ExamenType_ExamenTypeID])
REFERENCES [dbo].[EXAMENTYPE] ([ExamenTypeID])
GO
ALTER TABLE [dbo].[EXAMEN] CHECK CONSTRAINT [FK_EXAMEN_EXAMENTYPE]
GO
ALTER TABLE [dbo].[EXAMEN]  WITH CHECK ADD  CONSTRAINT [FK_EXAMEN_SERVICE] FOREIGN KEY([Service_ServiceID])
REFERENCES [dbo].[SERVICE] ([ServiceID])
GO
ALTER TABLE [dbo].[EXAMEN] CHECK CONSTRAINT [FK_EXAMEN_SERVICE]
GO
ALTER TABLE [dbo].[EXAMEN]  WITH CHECK ADD  CONSTRAINT [FK_EXAMEN_UTILISATEUR] FOREIGN KEY([Utilisateur_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[EXAMEN] CHECK CONSTRAINT [FK_EXAMEN_UTILISATEUR]
GO
ALTER TABLE [dbo].[FACTURE]  WITH CHECK ADD  CONSTRAINT [FK_FACTURE_DOSSIER] FOREIGN KEY([Dossier_DossierID])
REFERENCES [dbo].[DOSSIER] ([DossierID])
GO
ALTER TABLE [dbo].[FACTURE] CHECK CONSTRAINT [FK_FACTURE_DOSSIER]
GO
ALTER TABLE [dbo].[FACTURE]  WITH CHECK ADD  CONSTRAINT [FK_FACTURE_UTILISATEUR] FOREIGN KEY([Utilisateur_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[FACTURE] CHECK CONSTRAINT [FK_FACTURE_UTILISATEUR]
GO
ALTER TABLE [dbo].[FACTUREDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_FACTUREDETAILS_FACTURE] FOREIGN KEY([Facture_FactureID])
REFERENCES [dbo].[FACTURE] ([FactureID])
GO
ALTER TABLE [dbo].[FACTUREDETAILS] CHECK CONSTRAINT [FK_FACTUREDETAILS_FACTURE]
GO
ALTER TABLE [dbo].[FACTUREDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_FACTUREDETAILS_PRODUIT] FOREIGN KEY([Produit_ProduitID])
REFERENCES [dbo].[PRODUIT] ([ProduitID])
GO
ALTER TABLE [dbo].[FACTUREDETAILS] CHECK CONSTRAINT [FK_FACTUREDETAILS_PRODUIT]
GO
ALTER TABLE [dbo].[GROSSESSE]  WITH CHECK ADD  CONSTRAINT [FK_GROSSESSE_LIAISONDOSSIERGROUPECIBLE] FOREIGN KEY([Maternite_LiaisonDossierGroupeCibleID])
REFERENCES [dbo].[LIAISONDOSSIERGROUPECIBLE] ([LiaisonDossierGroupeCibleID])
GO
ALTER TABLE [dbo].[GROSSESSE] CHECK CONSTRAINT [FK_GROSSESSE_LIAISONDOSSIERGROUPECIBLE]
GO
ALTER TABLE [dbo].[GROSSESSE]  WITH CHECK ADD  CONSTRAINT [FK_GROSSESSE_UTILISATEUR] FOREIGN KEY([MedecinTraitant_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[GROSSESSE] CHECK CONSTRAINT [FK_GROSSESSE_UTILISATEUR]
GO
ALTER TABLE [dbo].[GROUPECIBLE]  WITH CHECK ADD  CONSTRAINT [FK_GROUPECIBLE_UTILISATEUR] FOREIGN KEY([Administrateur_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[GROUPECIBLE] CHECK CONSTRAINT [FK_GROUPECIBLE_UTILISATEUR]
GO
ALTER TABLE [dbo].[GROUPECIBLE]  WITH CHECK ADD  CONSTRAINT [FK_GROUPECIBLE_UTILISATEUR1] FOREIGN KEY([Createur_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[GROUPECIBLE] CHECK CONSTRAINT [FK_GROUPECIBLE_UTILISATEUR1]
GO
ALTER TABLE [dbo].[INVENTAIRE]  WITH CHECK ADD  CONSTRAINT [FK_INVENTAIRE_STOCK] FOREIGN KEY([Stock_StockID])
REFERENCES [dbo].[STOCK] ([StockID])
GO
ALTER TABLE [dbo].[INVENTAIRE] CHECK CONSTRAINT [FK_INVENTAIRE_STOCK]
GO
ALTER TABLE [dbo].[INVENTAIREDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_INVENTAIREDETAILS_INVENTAIRE] FOREIGN KEY([Inventaire_InventaireID])
REFERENCES [dbo].[INVENTAIRE] ([InventaireID])
GO
ALTER TABLE [dbo].[INVENTAIREDETAILS] CHECK CONSTRAINT [FK_INVENTAIREDETAILS_INVENTAIRE]
GO
ALTER TABLE [dbo].[INVENTAIREDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_INVENTAIREDETAILS_PRODUIT] FOREIGN KEY([Produit_ProduitID])
REFERENCES [dbo].[PRODUIT] ([ProduitID])
GO
ALTER TABLE [dbo].[INVENTAIREDETAILS] CHECK CONSTRAINT [FK_INVENTAIREDETAILS_PRODUIT]
GO
ALTER TABLE [dbo].[LABORATOIREOUTILS]  WITH CHECK ADD  CONSTRAINT [FK_LABORATOIREOUTILS_LABORATOIRE] FOREIGN KEY([Laboratoire_LaboratoireID])
REFERENCES [dbo].[LABORATOIRE] ([LaboratoireID])
GO
ALTER TABLE [dbo].[LABORATOIREOUTILS] CHECK CONSTRAINT [FK_LABORATOIREOUTILS_LABORATOIRE]
GO
ALTER TABLE [dbo].[LABORATOIREOUTILS]  WITH CHECK ADD  CONSTRAINT [FK_LABORATOIREOUTILS_RAYON] FOREIGN KEY([RayonID])
REFERENCES [dbo].[RAYON] ([RayonID])
GO
ALTER TABLE [dbo].[LABORATOIREOUTILS] CHECK CONSTRAINT [FK_LABORATOIREOUTILS_RAYON]
GO
ALTER TABLE [dbo].[LIAISONDOSSIERGROUPECIBLE]  WITH CHECK ADD  CONSTRAINT [FK_LIAISONDOSSIERGROUPECIBLE_DOSSIER] FOREIGN KEY([Dossier_DossierID])
REFERENCES [dbo].[DOSSIER] ([DossierID])
GO
ALTER TABLE [dbo].[LIAISONDOSSIERGROUPECIBLE] CHECK CONSTRAINT [FK_LIAISONDOSSIERGROUPECIBLE_DOSSIER]
GO
ALTER TABLE [dbo].[LIAISONDOSSIERGROUPECIBLE]  WITH CHECK ADD  CONSTRAINT [FK_LIAISONDOSSIERGROUPECIBLE_GROUPECIBLE] FOREIGN KEY([GC_GroupeCibleID])
REFERENCES [dbo].[GROUPECIBLE] ([GroupeCibleID])
GO
ALTER TABLE [dbo].[LIAISONDOSSIERGROUPECIBLE] CHECK CONSTRAINT [FK_LIAISONDOSSIERGROUPECIBLE_GROUPECIBLE]
GO
ALTER TABLE [dbo].[LIVRAISON]  WITH CHECK ADD  CONSTRAINT [FK_LIVRAISON_DOSSIER] FOREIGN KEY([Dossier_DossierD])
REFERENCES [dbo].[DOSSIER] ([DossierID])
GO
ALTER TABLE [dbo].[LIVRAISON] CHECK CONSTRAINT [FK_LIVRAISON_DOSSIER]
GO
ALTER TABLE [dbo].[LIVRAISON]  WITH CHECK ADD  CONSTRAINT [FK_LIVRAISON_FACTURE] FOREIGN KEY([Facture_FactureID])
REFERENCES [dbo].[FACTURE] ([FactureID])
GO
ALTER TABLE [dbo].[LIVRAISON] CHECK CONSTRAINT [FK_LIVRAISON_FACTURE]
GO
ALTER TABLE [dbo].[LIVRAISON]  WITH CHECK ADD  CONSTRAINT [FK_LIVRAISON_FOURNISSEUR] FOREIGN KEY([Fournisseur_FournisseurID])
REFERENCES [dbo].[FOURNISSEUR] ([FournisseurID])
GO
ALTER TABLE [dbo].[LIVRAISON] CHECK CONSTRAINT [FK_LIVRAISON_FOURNISSEUR]
GO
ALTER TABLE [dbo].[LIVRAISON]  WITH CHECK ADD  CONSTRAINT [FK_LIVRAISON_STOCK] FOREIGN KEY([Stock_StockID])
REFERENCES [dbo].[STOCK] ([StockID])
GO
ALTER TABLE [dbo].[LIVRAISON] CHECK CONSTRAINT [FK_LIVRAISON_STOCK]
GO
ALTER TABLE [dbo].[LIVRAISON]  WITH CHECK ADD  CONSTRAINT [FK_LIVRAISON_UTILISATEUR] FOREIGN KEY([Utilisateur_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[LIVRAISON] CHECK CONSTRAINT [FK_LIVRAISON_UTILISATEUR]
GO
ALTER TABLE [dbo].[MALADIE]  WITH CHECK ADD  CONSTRAINT [FK_MALADIE_GROUPEMALADIE] FOREIGN KEY([TypeMaladie_GroupeMaladieID])
REFERENCES [dbo].[GROUPEMALADIE] ([GroupeMaladieID])
GO
ALTER TABLE [dbo].[MALADIE] CHECK CONSTRAINT [FK_MALADIE_GROUPEMALADIE]
GO
ALTER TABLE [dbo].[MODIFICATION]  WITH CHECK ADD  CONSTRAINT [FK_MODIFICATION_DOSSIER] FOREIGN KEY([Dossier_DossierID])
REFERENCES [dbo].[DOSSIER] ([DossierID])
GO
ALTER TABLE [dbo].[MODIFICATION] CHECK CONSTRAINT [FK_MODIFICATION_DOSSIER]
GO
ALTER TABLE [dbo].[MODIFICATIONATTENTE]  WITH CHECK ADD  CONSTRAINT [FK_ModificationAttente_Utilisateur1] FOREIGN KEY([AncienSpecialiste_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[MODIFICATIONATTENTE] CHECK CONSTRAINT [FK_ModificationAttente_Utilisateur1]
GO
ALTER TABLE [dbo].[MODIFICATIONATTENTE]  WITH CHECK ADD  CONSTRAINT [FK_ModificationAttente_Utilisateur2] FOREIGN KEY([NouveauSpecialiste_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[MODIFICATIONATTENTE] CHECK CONSTRAINT [FK_ModificationAttente_Utilisateur2]
GO
ALTER TABLE [dbo].[PARAMETRE]  WITH CHECK ADD  CONSTRAINT [FK_Parametre_Dossier] FOREIGN KEY([Dossier_DossierID])
REFERENCES [dbo].[DOSSIER] ([DossierID])
GO
ALTER TABLE [dbo].[PARAMETRE] CHECK CONSTRAINT [FK_Parametre_Dossier]
GO
ALTER TABLE [dbo].[PRODUIT]  WITH CHECK ADD  CONSTRAINT [FK_PRODUIT_FABRICANT] FOREIGN KEY([Fabricant_FabricantID])
REFERENCES [dbo].[FABRICANT] ([FabricantID])
GO
ALTER TABLE [dbo].[PRODUIT] CHECK CONSTRAINT [FK_PRODUIT_FABRICANT]
GO
ALTER TABLE [dbo].[PRODUIT]  WITH CHECK ADD  CONSTRAINT [FK_PRODUIT_FOURNISSEUR] FOREIGN KEY([Fournisseur_FournisseurID])
REFERENCES [dbo].[FOURNISSEUR] ([FournisseurID])
GO
ALTER TABLE [dbo].[PRODUIT] CHECK CONSTRAINT [FK_PRODUIT_FOURNISSEUR]
GO
ALTER TABLE [dbo].[PRODUIT]  WITH CHECK ADD  CONSTRAINT [FK_PRODUIT_RAYON] FOREIGN KEY([Rayon_RayonID])
REFERENCES [dbo].[RAYON] ([RayonID])
GO
ALTER TABLE [dbo].[PRODUIT] CHECK CONSTRAINT [FK_PRODUIT_RAYON]
GO
ALTER TABLE [dbo].[PRODUIT]  WITH CHECK ADD  CONSTRAINT [FK_PRODUIT_STOCK] FOREIGN KEY([Stock_StockID])
REFERENCES [dbo].[STOCK] ([StockID])
GO
ALTER TABLE [dbo].[PRODUIT] CHECK CONSTRAINT [FK_PRODUIT_STOCK]
GO
ALTER TABLE [dbo].[RAPPELRDV]  WITH CHECK ADD  CONSTRAINT [FK_RappelRDV_RendezVous] FOREIGN KEY([Rdv_RendezVousID])
REFERENCES [dbo].[RENDEZVOUS] ([RendezVousID])
GO
ALTER TABLE [dbo].[RAPPELRDV] CHECK CONSTRAINT [FK_RappelRDV_RendezVous]
GO
ALTER TABLE [dbo].[RAYON]  WITH CHECK ADD  CONSTRAINT [FK_RAYON_STOCK] FOREIGN KEY([Stock_StockId])
REFERENCES [dbo].[STOCK] ([StockID])
GO
ALTER TABLE [dbo].[RAYON] CHECK CONSTRAINT [FK_RAYON_STOCK]
GO
ALTER TABLE [dbo].[REGLEMENT]  WITH CHECK ADD  CONSTRAINT [FK_REGLEMENT_FACTURE] FOREIGN KEY([Facture_FactureID])
REFERENCES [dbo].[FACTURE] ([FactureID])
GO
ALTER TABLE [dbo].[REGLEMENT] CHECK CONSTRAINT [FK_REGLEMENT_FACTURE]
GO
ALTER TABLE [dbo].[REGLEMENT]  WITH CHECK ADD  CONSTRAINT [FK_REGLEMENT_MODEPAIEMENT] FOREIGN KEY([ModePaiement_ModePaiementID])
REFERENCES [dbo].[MODEPAIEMENT] ([ModePaiementID])
GO
ALTER TABLE [dbo].[REGLEMENT] CHECK CONSTRAINT [FK_REGLEMENT_MODEPAIEMENT]
GO
ALTER TABLE [dbo].[RENDEZVOUS]  WITH CHECK ADD  CONSTRAINT [FK_RendezVous_Dossier] FOREIGN KEY([Recepteur_DossierID])
REFERENCES [dbo].[DOSSIER] ([DossierID])
GO
ALTER TABLE [dbo].[RENDEZVOUS] CHECK CONSTRAINT [FK_RendezVous_Dossier]
GO
ALTER TABLE [dbo].[RENDEZVOUS]  WITH CHECK ADD  CONSTRAINT [FK_RendezVous_Utilisateur] FOREIGN KEY([Emetteur_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[RENDEZVOUS] CHECK CONSTRAINT [FK_RendezVous_Utilisateur]
GO
ALTER TABLE [dbo].[RESULTAT]  WITH CHECK ADD  CONSTRAINT [FK_RESULTAT_EXAMEN] FOREIGN KEY([Examen_ExamenID])
REFERENCES [dbo].[EXAMEN] ([ExamenID])
GO
ALTER TABLE [dbo].[RESULTAT] CHECK CONSTRAINT [FK_RESULTAT_EXAMEN]
GO
ALTER TABLE [dbo].[STOCK]  WITH CHECK ADD  CONSTRAINT [FK_STOCK_STOCKTYPE] FOREIGN KEY([StockType_StockTypeID])
REFERENCES [dbo].[STOCKTYPE] ([StockTypeId])
GO
ALTER TABLE [dbo].[STOCK] CHECK CONSTRAINT [FK_STOCK_STOCKTYPE]
GO
ALTER TABLE [dbo].[STOCK]  WITH CHECK ADD  CONSTRAINT [FK_STOCK_UTILISATEUR] FOREIGN KEY([Utilisateur_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[STOCK] CHECK CONSTRAINT [FK_STOCK_UTILISATEUR]
GO
ALTER TABLE [dbo].[STOCKDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_STOCKDETAILS_PRODUIT] FOREIGN KEY([Produit_ProduitID])
REFERENCES [dbo].[PRODUIT] ([ProduitID])
GO
ALTER TABLE [dbo].[STOCKDETAILS] CHECK CONSTRAINT [FK_STOCKDETAILS_PRODUIT]
GO
ALTER TABLE [dbo].[STOCKDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_STOCKDETAILS_STOCK] FOREIGN KEY([Stock_StockID])
REFERENCES [dbo].[STOCK] ([StockID])
GO
ALTER TABLE [dbo].[STOCKDETAILS] CHECK CONSTRAINT [FK_STOCKDETAILS_STOCK]
GO
ALTER TABLE [dbo].[STOCKMOUVEMENT]  WITH CHECK ADD  CONSTRAINT [FK_STOCKMOUVEMENT_STOCK] FOREIGN KEY([Stock_StockID])
REFERENCES [dbo].[STOCK] ([StockID])
GO
ALTER TABLE [dbo].[STOCKMOUVEMENT] CHECK CONSTRAINT [FK_STOCKMOUVEMENT_STOCK]
GO
ALTER TABLE [dbo].[STOCKMOUVEMENTDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_STOCKMOUVEMENTDETAILS_STOCKMOUVEMENTDETAILS] FOREIGN KEY([StockMouvement_StockMouvementID])
REFERENCES [dbo].[STOCKMOUVEMENT] ([StockMouvementID])
GO
ALTER TABLE [dbo].[STOCKMOUVEMENTDETAILS] CHECK CONSTRAINT [FK_STOCKMOUVEMENTDETAILS_STOCKMOUVEMENTDETAILS]
GO
ALTER TABLE [dbo].[STOCKMOUVEMENTDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_STOCKMOUVEMENTDETAILS_STOCKMOUVEMENTDETAILS1] FOREIGN KEY([Produit_ProduitID])
REFERENCES [dbo].[PRODUIT] ([ProduitID])
GO
ALTER TABLE [dbo].[STOCKMOUVEMENTDETAILS] CHECK CONSTRAINT [FK_STOCKMOUVEMENTDETAILS_STOCKMOUVEMENTDETAILS1]
GO
ALTER TABLE [dbo].[STOCKTRANSFERT]  WITH CHECK ADD  CONSTRAINT [FK_STOCKTRANSFERT_STOCK] FOREIGN KEY([Stock_StockTransfertFromID])
REFERENCES [dbo].[STOCK] ([StockID])
GO
ALTER TABLE [dbo].[STOCKTRANSFERT] CHECK CONSTRAINT [FK_STOCKTRANSFERT_STOCK]
GO
ALTER TABLE [dbo].[STOCKTRANSFERTDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_STOCKTRANSFERTDETAILS_PRODUIT] FOREIGN KEY([Produit_ProduitID])
REFERENCES [dbo].[PRODUIT] ([ProduitID])
GO
ALTER TABLE [dbo].[STOCKTRANSFERTDETAILS] CHECK CONSTRAINT [FK_STOCKTRANSFERTDETAILS_PRODUIT]
GO
ALTER TABLE [dbo].[STOCKTRANSFERTDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_STOCKTRANSFERTDETAILS_STOCKTRANSFERT] FOREIGN KEY([StockTransfert_StockTransfertID])
REFERENCES [dbo].[STOCKTRANSFERT] ([StockTransfertID])
GO
ALTER TABLE [dbo].[STOCKTRANSFERTDETAILS] CHECK CONSTRAINT [FK_STOCKTRANSFERTDETAILS_STOCKTRANSFERT]
GO
ALTER TABLE [dbo].[TRAITEMENT]  WITH CHECK ADD  CONSTRAINT [FK_Traitement_Diagnostic] FOREIGN KEY([Diagnostic_DiagnosticID])
REFERENCES [dbo].[DIAGNOSTIC] ([DiagnosticID])
GO
ALTER TABLE [dbo].[TRAITEMENT] CHECK CONSTRAINT [FK_Traitement_Diagnostic]
GO
ALTER TABLE [dbo].[TRAITEMENT]  WITH CHECK ADD  CONSTRAINT [FK_Traitement_Utilisateur] FOREIGN KEY([Specialiste_UtilisateurID])
REFERENCES [dbo].[UTILISATEUR] ([UtilisateurID])
GO
ALTER TABLE [dbo].[TRAITEMENT] CHECK CONSTRAINT [FK_Traitement_Utilisateur]
GO
ALTER TABLE [dbo].[UTILISATEUR]  WITH CHECK ADD  CONSTRAINT [FK_Utilisateur_Personne] FOREIGN KEY([Personne_PersonneID])
REFERENCES [dbo].[PERSONNE] ([PersonneID])
GO
ALTER TABLE [dbo].[UTILISATEUR] CHECK CONSTRAINT [FK_Utilisateur_Personne]
GO
ALTER TABLE [dbo].[UTILISATEUR]  WITH CHECK ADD  CONSTRAINT [FK_UTILISATEUR_ROLE] FOREIGN KEY([Role_RoleID])
REFERENCES [dbo].[ROLE] ([RoleID])
GO
ALTER TABLE [dbo].[UTILISATEUR] CHECK CONSTRAINT [FK_UTILISATEUR_ROLE]
GO
ALTER TABLE [dbo].[VISITEPRENATALE]  WITH CHECK ADD  CONSTRAINT [FK_VISITEPRENATALE_GROSSESSE] FOREIGN KEY([Grossesse_GrossesseID])
REFERENCES [dbo].[GROSSESSE] ([GrossesseID])
GO
ALTER TABLE [dbo].[VISITEPRENATALE] CHECK CONSTRAINT [FK_VISITEPRENATALE_GROSSESSE]
GO
ALTER TABLE [dbo].[VISITEPRENATALE]  WITH CHECK ADD  CONSTRAINT [FK_VISITEPRENATALE_RENDEZVOUS] FOREIGN KEY([Rdv_RendezVousID])
REFERENCES [dbo].[RENDEZVOUS] ([RendezVousID])
GO
ALTER TABLE [dbo].[VISITEPRENATALE] CHECK CONSTRAINT [FK_VISITEPRENATALE_RENDEZVOUS]
GO
ALTER TABLE [dbo].[LIVRAISON]  WITH CHECK ADD  CONSTRAINT [CK_SalesDelivery] CHECK  (([Reference]<>''))
GO
ALTER TABLE [dbo].[LIVRAISON] CHECK CONSTRAINT [CK_SalesDelivery]
GO
ALTER TABLE [dbo].[REGLEMENT]  WITH CHECK ADD  CONSTRAINT [CK_SalesPayment] CHECK  (([Reference]<>''))
GO
ALTER TABLE [dbo].[REGLEMENT] CHECK CONSTRAINT [CK_SalesPayment]
GO
USE [master]
GO
ALTER DATABASE [Sobajo] SET  READ_WRITE 
GO
