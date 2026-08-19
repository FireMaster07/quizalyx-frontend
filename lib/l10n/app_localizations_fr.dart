// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'COMMENCER';

  @override
  String get settings => 'Paramètres';

  @override
  String get offlineTitle => 'Pas de connexion Internet';

  @override
  String get offlineDesc =>
      'Veuillez vérifier votre connexion. Vous pouvez jouer hors ligne, mais votre progression sera sauvegardée localement en tant qu\'invité.';

  @override
  String get playAsGuest => 'Jouer en tant qu\'invité';

  @override
  String get retry => 'Réessayer';

  @override
  String get exitTitle => 'Quitter QuizAlyx ?';

  @override
  String get exitDesc => 'Êtes-vous sûr de vouloir quitter le jeu ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get exit => 'Quitter';

  @override
  String get dailyRewardTitle => 'Récompense Quotidienne';

  @override
  String get dailyRewardDesc =>
      'Vous avez gagné 5 pièces pour votre connexion d\'aujourd\'hui !';

  @override
  String get plus5Coins => '+5 PIÈCES';

  @override
  String get collect => 'Récupérer';

  @override
  String currentStreak(int days) {
    return 'Série actuelle : $days jours !';
  }

  @override
  String get guestPlayer => 'Joueur Invité';

  @override
  String get notLoggedIn => 'Non connecté';

  @override
  String get myAccount => 'Mon Compte';

  @override
  String get myStatistics => 'Mes Statistiques';

  @override
  String get loginSignup => 'Se connecter / S\'inscrire';

  @override
  String get logOut => 'Se déconnecter';

  @override
  String get appSlogan => 'Défiez vos connaissances';

  @override
  String get missionCompleted => 'MISSION TERMINÉE !';

  @override
  String get leaderboards => 'Classements';

  @override
  String get leaderboardsOfflineDesc =>
      'Les classements nécessitent une connexion Internet pour synchroniser les scores mondiaux.';

  @override
  String get unexpectedError => 'Une erreur inattendue s\'est produite.';

  @override
  String get noOnePlayedYet => 'Personne n\'a encore joué !';

  @override
  String get beTheFirstToPlay =>
      'Répondez à un quiz maintenant et soyez le premier sur la liste.';

  @override
  String get topPlayers => 'Meilleurs Joueurs';

  @override
  String get challengeThem => 'Défiez-les pour prendre votre place !';

  @override
  String get pts => 'pts';

  @override
  String get signInWithGoogle => 'Se connecter avec Google';

  @override
  String get continueAsGuest => 'Continuer en tant qu\'invité';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins Pièces !';
  }

  @override
  String get mission_global_title => 'Maître des Questions';

  @override
  String get mission_global_desc => 'Résolvez un total de X questions';

  @override
  String get mission_title_Math => 'Mathématiques';

  @override
  String get mission_desc_Math => 'Résolvez des questions de mathématiques';

  @override
  String get mission_title_Physics => 'Physique';

  @override
  String get mission_desc_Physics => 'Résolvez des questions de physique';

  @override
  String get mission_title_Chemistry => 'Chimie';

  @override
  String get mission_desc_Chemistry => 'Résolvez des questions de chimie';

  @override
  String get mission_title_Biology => 'Biologie';

  @override
  String get mission_desc_Biology => 'Résolvez des questions de biologie';

  @override
  String get mission_title_History => 'Histoire';

  @override
  String get mission_desc_History => 'Résolvez des questions d\'histoire';

  @override
  String get mission_title_Geography => 'Géographie';

  @override
  String get mission_desc_Geography => 'Résolvez des questions de géographie';

  @override
  String get mission_title_Literature => 'Littérature';

  @override
  String get mission_desc_Literature => 'Résolvez des questions de littérature';

  @override
  String get mission_title_Art => 'Art';

  @override
  String get mission_desc_Art => 'Résolvez des questions d\'art';

  @override
  String get mission_title_Music => 'Musique';

  @override
  String get mission_desc_Music => 'Résolvez des questions de musique';

  @override
  String get mission_title_Sports => 'Sports';

  @override
  String get mission_desc_Sports => 'Résolvez des questions de sport';

  @override
  String get mission_title_Technology => 'Technologie';

  @override
  String get mission_desc_Technology => 'Résolvez des questions de technologie';

  @override
  String get mission_title_Software => 'Logiciel';

  @override
  String get mission_desc_Software => 'Résolvez des questions de logiciel';

  @override
  String get mission_title_Mechanic => 'Mécanique';

  @override
  String get mission_desc_Mechanic => 'Résolvez des questions de mécanique';

  @override
  String get mission_title_Religion => 'Religion';

  @override
  String get mission_desc_Religion => 'Résolvez des questions de religion';

  @override
  String get careerAchievements => 'Carrière & Succès';

  @override
  String get totalAchievements => 'Succès Totaux';

  @override
  String get maxLevel => 'MAX';

  @override
  String get completed => 'Terminé';

  @override
  String levelProgress(int current, int total) {
    return 'Niveau $current / $total';
  }

  @override
  String get selectGameMode => 'Sélectionner le mode';

  @override
  String get modeClassic => 'Classique';

  @override
  String get modeClassicDesc => 'Questions fixes, prenez votre temps';

  @override
  String get modeTimed => 'Chronométré';

  @override
  String get modeTimedDesc => 'Course contre la montre';

  @override
  String get modeEndless => 'Infini';

  @override
  String get modeEndlessDesc => 'Répondez à un maximum de questions';

  @override
  String get defaultPlayerName => 'Joueur QuizAlyx';

  @override
  String get editProfileName => 'Modifier le nom';

  @override
  String get enterNewName => 'Entrez votre nouveau nom';

  @override
  String get save => 'Enregistrer';

  @override
  String get nameChangeLimitTitle => 'Limite de changement de nom';

  @override
  String get nameChangeLimitDesc =>
      'Vous ne pouvez changer de nom que 2 fois tous les 14 jours. Veuillez réessayer plus tard.';

  @override
  String get ok => 'OK';

  @override
  String get unknownDate => 'Inconnu';

  @override
  String get accountStatus => 'Statut du compte';

  @override
  String get verified => 'Vérifié';

  @override
  String get guestAccount => 'Compte invité';

  @override
  String get joinedDate => 'Date d\'inscription';

  @override
  String get membership => 'Abonnement';

  @override
  String get freeTier => 'Gratuit';

  @override
  String daysCount(int count) {
    return '$count Jours';
  }

  @override
  String get dataLoadError => 'Impossible de charger les données.';

  @override
  String get totalScore => 'Score Total';

  @override
  String get quizzesPlayed => 'Quiz Joués';

  @override
  String get accuracyRate => 'Taux de Précision';

  @override
  String get dailyStreak => 'Série Quotidienne';

  @override
  String get enterPlayerNameError =>
      'Veuillez entrer un pseudo de joueur sympa !';

  @override
  String get welcomeToQuizAlyx => 'Bienvenue sur QuizAlyx !';

  @override
  String get chooseAvatarName => 'Choisissez votre avatar et votre nom.';

  @override
  String get enterPlayerNameHint => 'Entrez le nom du joueur';

  @override
  String get startJourney => 'Commencer l\'aventure';

  @override
  String get quitQuizTitle => 'Quitter le Quiz ?';

  @override
  String get quitQuizDesc =>
      'Votre progression sera perdue. Êtes-vous sûr de vouloir retourner à l\'accueil ?';

  @override
  String get quit => 'Quitter';

  @override
  String get no5050JokerWarning => 'Vous n\'avez plus de joker 50/50 !';

  @override
  String get noTimeFreezeWarning => 'Vous n\'avez plus de Gel de Temps !';

  @override
  String get quiz => 'Quiz';

  @override
  String timeSeconds(int seconds) {
    return 'Temps: $seconds s';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Question $current / $total';
  }

  @override
  String get quizCompleted => 'Quiz Terminé !';

  @override
  String get correct => 'Correct';

  @override
  String get wrong => 'Faux';

  @override
  String get score => 'Score';

  @override
  String get continueBtn => 'Continuer';

  @override
  String get whatsNext => 'Et maintenant ?';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get backToHome => 'Retour à l\'accueil';

  @override
  String get timesUp => 'Temps Écoulé !';

  @override
  String get language => 'Langue';

  @override
  String get settingsSaved => 'Paramètres enregistrés avec succès !';

  @override
  String get resetHighScoresTitle => 'Réinitialiser les scores ?';

  @override
  String get resetHighScoresDesc =>
      'Cela supprimera tous vos meilleurs scores. Cette action est irréversible.';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get highScoresResetSuccess =>
      'Meilleurs scores réinitialisés avec succès !';

  @override
  String get appearance => 'Apparence';

  @override
  String get goldTheme => 'Thème Or';

  @override
  String get premiumGoldLook => 'Look or premium';

  @override
  String get unlockInStore => 'Débloquer dans la boutique';

  @override
  String get diamondTheme => 'Thème Diamant';

  @override
  String get legendaryDiamondLook => 'Look diamant légendaire';

  @override
  String get unlockInStore1500 => 'Débloquer dans la boutique (1500 Pièces)';

  @override
  String get gameplay => 'Jouabilité';

  @override
  String get numberOfQuestions => 'Nombre de questions';

  @override
  String get timedDurationSec => 'Durée chronométrée (sec)';

  @override
  String get endlessDurationSec => 'Durée infinie (sec)';

  @override
  String get display => 'Affichage';

  @override
  String get showDifficulty => 'Afficher la difficulté';

  @override
  String get showDifficultyDesc =>
      'Afficher le niveau de difficulté pour chaque question';

  @override
  String get actions => 'Actions';

  @override
  String get saveSettings => 'Enregistrer les paramètres';

  @override
  String get resetScores => 'Réinitialiser les scores';

  @override
  String get visitStoreToUnlock => 'Visitez la boutique pour débloquer !';

  @override
  String get storeTitle => 'Boutique';

  @override
  String specialBundlePurchased(int remaining) {
    return 'Pack Spécial Acheté ! (Restant : $remaining)';
  }

  @override
  String get notEnoughCoins => 'Pas assez de pièces !';

  @override
  String get exchangeSuccessful => 'Échange réussi !';

  @override
  String get notEnoughPoints => 'Pas assez de points !';

  @override
  String get themeUnlockedSettings =>
      'Thème débloqué ! Activez-le dans les paramètres.';

  @override
  String itemPurchased(String itemName) {
    return '$itemName acheté !';
  }

  @override
  String get currencyExchange => 'ÉCHANGE DE DEVISES';

  @override
  String get shopItems => 'ARTICLES DE BOUTIQUE';

  @override
  String get limitedOffer => 'OFFRE LIMITÉE';

  @override
  String endsInDays(int days) {
    return 'Se termine dans $days jours';
  }

  @override
  String get megaBoosterPack => 'Méga Pack Booster';

  @override
  String get boosterPackDesc => '1x Joker 50/50 + 1x Gel de Temps';

  @override
  String remainingLimit(int current, int max) {
    return 'Restant : $current / $max';
  }

  @override
  String get coinsText => 'Pièces';

  @override
  String get convertBtn => 'Convertir';

  @override
  String get joker5050 => 'Joker 50/50';

  @override
  String get joker5050Desc => 'Supprime 2 mauvaises options';

  @override
  String get timeFreeze => 'Gel de Temps';

  @override
  String get timeFreezeDesc => 'Arrête le temps pendant 10s';

  @override
  String get premiumTheme => 'Thème Premium';

  @override
  String get unlockGoldTheme => 'Débloquer le Thème Or';

  @override
  String get unlockDiamondInterface => 'Débloquer l\'Interface Diamant';

  @override
  String get themeUnlocked => 'Thème Débloqué';

  @override
  String get owned => 'POSSÉDÉ';

  @override
  String get selectTopic => 'Sélectionner un sujet';

  @override
  String topicDifficulty(String topic) {
    return 'Difficulté : $topic';
  }

  @override
  String get beginner => 'Débutant';

  @override
  String get intermediate => 'Intermédiaire';

  @override
  String get advanced => 'Avancé';

  @override
  String get dangerZone => 'Zone de danger';

  @override
  String get deleteAccountTitle => 'Supprimer le compte et les données';

  @override
  String get deleteAccountSubtitle =>
      'Supprimer définitivement votre profil et vos enregistrements locaux/cloud';

  @override
  String get deleteAccountConfirmTitle =>
      'Supprimer le compte et les données ?';

  @override
  String get deleteAccountConfirmDesc =>
      'Cela supprimera définitivement votre profil, vos meilleurs scores, votre inventaire et vos données de classement. Cette action est IRRÉVERSIBLE.';

  @override
  String get deletePermanently => 'Supprimer définitivement';

  @override
  String get accountDeletedSuccess => 'Compte supprimé avec succès !';

  @override
  String deleteAccountError(String error) {
    return 'Erreur : $error. Vous devrez peut-être vous reconnecter pour supprimer votre compte.';
  }

  @override
  String get securityCheckTitle => 'Contrôle de sécurité';

  @override
  String get securityCheckDesc =>
      'La suppression de votre compte est une opération sensible. Pour votre sécurité, veuillez vous déconnecter et vous reconnecter avant d\'essayer de supprimer votre compte.';

  @override
  String get logOutAndReLogin => 'Se déconnecter et se reconnecter';

  @override
  String get adNotReady =>
      'La publicité n\'est pas encore prête, veuillez patienter un moment.';

  @override
  String get rewardEarned =>
      'Félicitations ! Vous avez gagné des pièces gratuites.';

  @override
  String get freeRewards => 'RÉCOMPENSES GRATUITES';

  @override
  String get watchAd => 'Regarder la vidéo';

  @override
  String get watchAdDesc => 'Gagnez des pièces gratuites';

  @override
  String get videoCannotBePlayed => 'La vidéo ne peut pas être lue !';

  @override
  String get noInternetMessage =>
      'Vous n\'êtes pas connecté à Internet. Veuillez vérifier votre connexion et réessayer.';

  @override
  String get okButton => 'OK';

  @override
  String get continueOffline => 'Continuer hors ligne';

  @override
  String get unknownUser => 'Utilisateur inconnu';

  @override
  String get noEmail => 'Aucun e-mail';

  @override
  String get offlineModeDataFromDevice =>
      'Mode hors ligne : Données lues depuis l\'appareil.';

  @override
  String get questionsLoadError =>
      'Impossible de charger les questions. Veuillez vérifier votre connexion internet.';

  @override
  String get points => 'Points';

  @override
  String get createWord => 'Créer un mot...';

  @override
  String get clear => 'Effacer';

  @override
  String get submit => 'ENVOYER';

  @override
  String get checking => 'est en cours de vérification...';

  @override
  String get chooseYourGame => 'Choisis ton jeu';

  @override
  String get wordTooShort => 'Le mot doit contenir au moins 3 lettres !';

  @override
  String get wordAlreadyFound => 'Vous avez déjà trouvé ce mot !';

  @override
  String pointsEarned(int points) {
    return '+$points Points !';
  }

  @override
  String get invalidWord => 'Mot invalide !';

  @override
  String get startFindingWords => 'Commencez à chercher des mots !';

  @override
  String get gameOver => 'Partie terminée';

  @override
  String get yourScore => 'Ton score :';

  @override
  String get exitWordAlyxTitle => 'Quitter WordAlyx ?';

  @override
  String get exitWordAlyxDesc =>
      'Es-tu sûr de vouloir quitter le jeu ? Ta progression sera perdue.';

  @override
  String get legal => 'Légal';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get privacyWelcomeTitle => 'Bienvenue sur QuizAlyx !';

  @override
  String get privacyWelcomeDesc =>
      'Avant de commencer, veuillez lire et accepter notre Politique de confidentialité pour comprendre comment nous protégeons vos données.';

  @override
  String get readPrivacyPolicy => 'Lire la Politique de confidentialité';

  @override
  String get acceptAndContinue => 'Accepter et continuer';

  @override
  String get creditsPlayStorePublisher => 'Éditeur Play Store';

  @override
  String get creditsAppStorePublisher => 'Éditeur App Store';

  @override
  String get creditsIDEAndroid => 'IDE (Android)';

  @override
  String get creditsIDEiOS => 'IDE (iOS)';

  @override
  String get creditsDatabase => 'Base de données';

  @override
  String get creditsFrontend => 'Développement Frontend';

  @override
  String get creditsBackend => 'Backend';

  @override
  String get creditsProduction => 'Production et Mises à jour';

  @override
  String get creditsWordAlyxUpdate => 'Mise à jour WordAlyx (2026)';

  @override
  String get creditsProducer => 'Producteur';

  @override
  String get tapToSkip => 'Appuyez n\'importe où pour passer';

  @override
  String get selectCurrentAccountError =>
      'Veuillez sélectionner votre compte actuel pour le supprimer !';
}
