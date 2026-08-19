// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'QUIZ STARTEN';

  @override
  String get settings => 'Einstellungen';

  @override
  String get offlineTitle => 'Keine Internetverbindung';

  @override
  String get offlineDesc =>
      'Bitte überprüfe deine Internetverbindung. Du kannst weiterhin offline spielen, aber dein Fortschritt wird lokal als Gast gespeichert.';

  @override
  String get playAsGuest => 'Als Gast spielen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get exitTitle => 'QuizAlyx beenden?';

  @override
  String get exitDesc =>
      'Bist du sicher, dass du das Spiel verlassen möchtest?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get exit => 'Beenden';

  @override
  String get dailyRewardTitle => 'Tägliche Belohnung';

  @override
  String get dailyRewardDesc =>
      'Du hast 5 Münzen fürs heutige Einloggen erhalten!';

  @override
  String get plus5Coins => '+5 MÜNZEN';

  @override
  String get collect => 'Sammeln';

  @override
  String currentStreak(int days) {
    return 'Aktuelle Serie: $days Tage!';
  }

  @override
  String get guestPlayer => 'Gastspieler';

  @override
  String get notLoggedIn => 'Nicht eingeloggt';

  @override
  String get myAccount => 'Mein Konto';

  @override
  String get myStatistics => 'Meine Statistiken';

  @override
  String get loginSignup => 'Anmelden / Registrieren';

  @override
  String get logOut => 'Abmelden';

  @override
  String get appSlogan => 'Teste dein Wissen';

  @override
  String get missionCompleted => 'MISSION ABGESCHLOSSEN!';

  @override
  String get leaderboards => 'Bestenlisten';

  @override
  String get leaderboardsOfflineDesc =>
      'Für die Synchronisierung der globalen Punktzahlen ist eine Internetverbindung erforderlich.';

  @override
  String get unexpectedError => 'Ein unerwarteter Fehler ist aufgetreten.';

  @override
  String get noOnePlayedYet => 'Noch hat niemand gespielt!';

  @override
  String get beTheFirstToPlay =>
      'Löse jetzt ein Quiz und trage dich als Erster in die Liste ein.';

  @override
  String get topPlayers => 'Top-Spieler';

  @override
  String get challengeThem =>
      'Fordere sie heraus, um deinen Platz zu beanspruchen!';

  @override
  String get pts => 'Pkt.';

  @override
  String get signInWithGoogle => 'Mit Google anmelden';

  @override
  String get continueAsGuest => 'Als Gast fortfahren';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins Münzen!';
  }

  @override
  String get mission_global_title => 'Fragen-Meister';

  @override
  String get mission_global_desc => 'Löse insgesamt X Fragen';

  @override
  String get mission_title_Math => 'Mathematik';

  @override
  String get mission_desc_Math => 'Löse Mathematik-Fragen';

  @override
  String get mission_title_Physics => 'Physik';

  @override
  String get mission_desc_Physics => 'Löse Physik-Fragen';

  @override
  String get mission_title_Chemistry => 'Chemie';

  @override
  String get mission_desc_Chemistry => 'Löse Chemie-Fragen';

  @override
  String get mission_title_Biology => 'Biologie';

  @override
  String get mission_desc_Biology => 'Löse Biologie-Fragen';

  @override
  String get mission_title_History => 'Geschichte';

  @override
  String get mission_desc_History => 'Löse Geschichte-Fragen';

  @override
  String get mission_title_Geography => 'Geografie';

  @override
  String get mission_desc_Geography => 'Löse Geografie-Fragen';

  @override
  String get mission_title_Literature => 'Literatur';

  @override
  String get mission_desc_Literature => 'Löse Literatur-Fragen';

  @override
  String get mission_title_Art => 'Kunst';

  @override
  String get mission_desc_Art => 'Löse Kunst-Fragen';

  @override
  String get mission_title_Music => 'Musik';

  @override
  String get mission_desc_Music => 'Löse Musik-Fragen';

  @override
  String get mission_title_Sports => 'Sport';

  @override
  String get mission_desc_Sports => 'Löse Sport-Fragen';

  @override
  String get mission_title_Technology => 'Technologie';

  @override
  String get mission_desc_Technology => 'Löse Technologie-Fragen';

  @override
  String get mission_title_Software => 'Software';

  @override
  String get mission_desc_Software => 'Löse Software-Fragen';

  @override
  String get mission_title_Mechanic => 'Mechanik';

  @override
  String get mission_desc_Mechanic => 'Löse Mechanik-Fragen';

  @override
  String get mission_title_Religion => 'Religion';

  @override
  String get mission_desc_Religion => 'Löse Religion-Fragen';

  @override
  String get careerAchievements => 'Karriere & Erfolge';

  @override
  String get totalAchievements => 'Gesamte Erfolge';

  @override
  String get maxLevel => 'MAX';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String levelProgress(int current, int total) {
    return 'Level $current / $total';
  }

  @override
  String get selectGameMode => 'Spielmodus wählen';

  @override
  String get modeClassic => 'Klassisch';

  @override
  String get modeClassicDesc => 'Feste Fragen, lass dir Zeit';

  @override
  String get modeTimed => 'Auf Zeit';

  @override
  String get modeTimedDesc => 'Rennen gegen die Uhr';

  @override
  String get modeEndless => 'Endlos';

  @override
  String get modeEndlessDesc => 'Beantworte so viele wie möglich';

  @override
  String get defaultPlayerName => 'QuizAlyx-Spieler';

  @override
  String get editProfileName => 'Profilname bearbeiten';

  @override
  String get enterNewName => 'Neuen Namen eingeben';

  @override
  String get save => 'Speichern';

  @override
  String get nameChangeLimitTitle => 'Namensänderungslimit';

  @override
  String get nameChangeLimitDesc =>
      'Du kannst deinen Namen nur 2 Mal alle 14 Tage ändern. Bitte versuche es später noch einmal.';

  @override
  String get ok => 'OK';

  @override
  String get unknownDate => 'Unbekannt';

  @override
  String get accountStatus => 'Kontostatus';

  @override
  String get verified => 'Verifiziert';

  @override
  String get guestAccount => 'Gastkonto';

  @override
  String get joinedDate => 'Beigetreten am';

  @override
  String get membership => 'Mitgliedschaft';

  @override
  String get freeTier => 'Kostenlos';

  @override
  String daysCount(int count) {
    return '$count Tage';
  }

  @override
  String get dataLoadError => 'Daten konnten nicht geladen werden.';

  @override
  String get totalScore => 'Gesamtpunktzahl';

  @override
  String get quizzesPlayed => 'Gespielte Quizze';

  @override
  String get accuracyRate => 'Genauigkeitsrate';

  @override
  String get dailyStreak => 'Tägliche Serie';

  @override
  String get enterPlayerNameError => 'Bitte gib einen coolen Spielernamen ein!';

  @override
  String get welcomeToQuizAlyx => 'Willkommen bei QuizAlyx!';

  @override
  String get chooseAvatarName => 'Wähle deinen Spieler-Avatar und Namen.';

  @override
  String get enterPlayerNameHint => 'Spielername eingeben';

  @override
  String get startJourney => 'Reise beginnen';

  @override
  String get quitQuizTitle => 'Quiz beenden?';

  @override
  String get quitQuizDesc =>
      'Dein Fortschritt geht verloren. Willst du wirklich zur Startseite zurückkehren?';

  @override
  String get quit => 'Beenden';

  @override
  String get no5050JokerWarning => 'Du hast keine 50/50-Joker mehr!';

  @override
  String get noTimeFreezeWarning => 'Du hast keinen Zeitstopp mehr!';

  @override
  String get quiz => 'Quiz';

  @override
  String timeSeconds(int seconds) {
    return 'Zeit: $seconds s';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Frage $current / $total';
  }

  @override
  String get quizCompleted => 'Quiz abgeschlossen!';

  @override
  String get correct => 'Richtig';

  @override
  String get wrong => 'Falsch';

  @override
  String get score => 'Punktzahl';

  @override
  String get continueBtn => 'Weiter';

  @override
  String get whatsNext => 'Wie geht\'s weiter?';

  @override
  String get playAgain => 'Nochmal spielen';

  @override
  String get backToHome => 'Zurück zur Startseite';

  @override
  String get timesUp => 'Zeit abgelaufen!';

  @override
  String get language => 'Sprache';

  @override
  String get settingsSaved => 'Einstellungen erfolgreich gespeichert!';

  @override
  String get resetHighScoresTitle => 'Highscores zurücksetzen?';

  @override
  String get resetHighScoresDesc =>
      'Dadurch werden alle Highscores gelöscht. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get highScoresResetSuccess => 'Highscores erfolgreich zurückgesetzt!';

  @override
  String get appearance => 'Aussehen';

  @override
  String get goldTheme => 'Gold-Design';

  @override
  String get premiumGoldLook => 'Premium-Gold-Look';

  @override
  String get unlockInStore => 'Im Shop freischalten';

  @override
  String get diamondTheme => 'Diamant-Design';

  @override
  String get legendaryDiamondLook => 'Legendärer Diamant-Look';

  @override
  String get unlockInStore1500 => 'Im Shop freischalten (1500 Münzen)';

  @override
  String get gameplay => 'Spielablauf';

  @override
  String get numberOfQuestions => 'Anzahl der Fragen';

  @override
  String get timedDurationSec => 'Zeitlimit (Sek)';

  @override
  String get endlessDurationSec => 'Endlos-Dauer (Sek)';

  @override
  String get display => 'Anzeige';

  @override
  String get showDifficulty => 'Schwierigkeit anzeigen';

  @override
  String get showDifficultyDesc => 'Schwierigkeitsgrad für jede Frage anzeigen';

  @override
  String get actions => 'Aktionen';

  @override
  String get saveSettings => 'Einstellungen speichern';

  @override
  String get resetScores => 'Punkte zurücksetzen';

  @override
  String get visitStoreToUnlock => 'Besuche den Shop zum Freischalten!';

  @override
  String get storeTitle => 'Shop';

  @override
  String specialBundlePurchased(int remaining) {
    return 'Sonderpaket gekauft! (Übrig: $remaining)';
  }

  @override
  String get notEnoughCoins => 'Nicht genug Münzen!';

  @override
  String get exchangeSuccessful => 'Umtausch erfolgreich!';

  @override
  String get notEnoughPoints => 'Nicht genug Punkte!';

  @override
  String get themeUnlockedSettings =>
      'Design freigeschaltet! In den Einstellungen aktivieren.';

  @override
  String itemPurchased(String itemName) {
    return '$itemName gekauft!';
  }

  @override
  String get currencyExchange => 'WÄHRUNGSWECHSEL';

  @override
  String get shopItems => 'SHOP-ARTIKEL';

  @override
  String get limitedOffer => 'BEFRISTETES ANGEBOT';

  @override
  String endsInDays(int days) {
    return 'Endet in $days Tagen';
  }

  @override
  String get megaBoosterPack => 'Mega-Booster-Paket';

  @override
  String get boosterPackDesc => '1x 50/50-Joker + 1x Zeitstopp';

  @override
  String remainingLimit(int current, int max) {
    return 'Verbleibend: $current / $max';
  }

  @override
  String get coinsText => 'Münzen';

  @override
  String get convertBtn => 'Umwandeln';

  @override
  String get joker5050 => '50/50-Joker';

  @override
  String get joker5050Desc => 'Entfernt 2 falsche Optionen';

  @override
  String get timeFreeze => 'Zeitstopp';

  @override
  String get timeFreezeDesc => 'Stoppt den Timer für 10s';

  @override
  String get premiumTheme => 'Premium-Design';

  @override
  String get unlockGoldTheme => 'Gold-Design freischalten';

  @override
  String get unlockDiamondInterface => 'Diamant-Oberfläche freischalten';

  @override
  String get themeUnlocked => 'Design freigeschaltet';

  @override
  String get owned => 'IM BESITZ';

  @override
  String get selectTopic => 'Thema wählen';

  @override
  String topicDifficulty(String topic) {
    return '$topic Schwierigkeit';
  }

  @override
  String get beginner => 'Anfänger';

  @override
  String get intermediate => 'Mittel';

  @override
  String get advanced => 'Fortgeschritten';

  @override
  String get dangerZone => 'Gefahrenzone';

  @override
  String get deleteAccountTitle => 'Konto & Daten löschen';

  @override
  String get deleteAccountSubtitle =>
      'Dein Profil und alle Cloud/lokalen Datensätze dauerhaft löschen';

  @override
  String get deleteAccountConfirmTitle => 'Konto & Daten löschen?';

  @override
  String get deleteAccountConfirmDesc =>
      'Dies wird dein Profil, deine Highscores, dein Inventar und deine Bestenlisten-Daten dauerhaft löschen. Diese Aktion KANN NICHT rückgängig gemacht werden.';

  @override
  String get deletePermanently => 'Dauerhaft löschen';

  @override
  String get accountDeletedSuccess => 'Konto erfolgreich gelöscht!';

  @override
  String deleteAccountError(String error) {
    return 'Fehler: $error. Möglicherweise musst du dich erneut anmelden, um dein Konto zu löschen.';
  }

  @override
  String get securityCheckTitle => 'Sicherheitsprüfung';

  @override
  String get securityCheckDesc =>
      'Das Löschen Ihres Kontos ist ein sensibler Vorgang. Zu Ihrer Sicherheit melden Sie sich bitte ab und wieder an, bevor Sie versuchen, Ihr Konto zu löschen.';

  @override
  String get logOutAndReLogin => 'Abmelden & Neu anmelden';

  @override
  String get adNotReady =>
      'Anzeige ist noch nicht bereit, bitte warte einen Moment.';

  @override
  String get rewardEarned =>
      'Herzlichen Glückwunsch! Du hast kostenlose Münzen verdient.';

  @override
  String get freeRewards => 'KOSTENLOSE BELOHNUNGEN';

  @override
  String get watchAd => 'Video ansehen';

  @override
  String get watchAdDesc => 'Verdiene kostenlose Münzen';

  @override
  String get videoCannotBePlayed => 'Video kann nicht abgespielt werden!';

  @override
  String get noInternetMessage =>
      'Sie sind nicht mit dem Internet verbunden. Bitte überprüfen Sie Ihre Verbindung und versuchen Sie es erneut.';

  @override
  String get okButton => 'OK';

  @override
  String get continueOffline => 'Offline fortfahren';

  @override
  String get unknownUser => 'Unbekannter Benutzer';

  @override
  String get noEmail => 'Keine E-Mail';

  @override
  String get offlineModeDataFromDevice =>
      'Offline-Modus: Daten werden vom Gerät gelesen.';

  @override
  String get questionsLoadError =>
      'Fragen konnten nicht geladen werden. Bitte überprüfen Sie Ihre Internetverbindung.';

  @override
  String get points => 'Punkte';

  @override
  String get createWord => 'Wort erstellen...';

  @override
  String get clear => 'Löschen';

  @override
  String get submit => 'SENDEN';

  @override
  String get checking => 'wird geprüft...';

  @override
  String get chooseYourGame => 'Wähle dein Spiel';

  @override
  String get wordTooShort => 'Wort muss aus mindestens 3 Buchstaben bestehen!';

  @override
  String get wordAlreadyFound => 'Du hast dieses Wort bereits gefunden!';

  @override
  String pointsEarned(int points) {
    return '+$points Punkte!';
  }

  @override
  String get invalidWord => 'Ungültiges Wort!';

  @override
  String get startFindingWords => 'Fange an, Wörter zu finden!';

  @override
  String get gameOver => 'Spiel beendet';

  @override
  String get yourScore => 'Deine Punktzahl:';

  @override
  String get exitWordAlyxTitle => 'WordAlyx beenden?';

  @override
  String get exitWordAlyxDesc =>
      'Bist du sicher, dass du das Spiel verlassen möchtest? Dein Fortschritt geht verloren.';

  @override
  String get legal => 'Rechtliches';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get privacyWelcomeTitle => 'Willkommen bei QuizAlyx!';

  @override
  String get privacyWelcomeDesc =>
      'Bevor du beginnst, lies und akzeptiere bitte unsere Datenschutzrichtlinie, um zu verstehen, wie wir deine Daten schützen.';

  @override
  String get readPrivacyPolicy => 'Datenschutzrichtlinie lesen';

  @override
  String get acceptAndContinue => 'Akzeptieren & Weiter';

  @override
  String get creditsPlayStorePublisher => 'Play Store Herausgeber';

  @override
  String get creditsAppStorePublisher => 'App Store Herausgeber';

  @override
  String get creditsIDEAndroid => 'IDE (Android)';

  @override
  String get creditsIDEiOS => 'IDE (iOS)';

  @override
  String get creditsDatabase => 'Datenbank';

  @override
  String get creditsFrontend => 'Frontend-Entwicklung';

  @override
  String get creditsBackend => 'Backend';

  @override
  String get creditsProduction => 'Produktion & Updates';

  @override
  String get creditsWordAlyxUpdate => 'WordAlyx Update (2026)';

  @override
  String get creditsProducer => 'Produzent';

  @override
  String get tapToSkip => 'Tippen Sie auf den Bildschirm, um zu überspringen';

  @override
  String get selectCurrentAccountError =>
      'Bitte wählen Sie Ihr aktuelles Konto aus, um es zu löschen!';
}
