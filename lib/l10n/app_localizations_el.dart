// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'ΕΝΑΡΞΗ ΚΟΥΙΖ';

  @override
  String get settings => 'Ρυθμίσεις';

  @override
  String get offlineTitle => 'Χωρίς σύνδεση';

  @override
  String get offlineDesc =>
      'Ελέγξτε τη σύνδεσή σας. Μπορείτε να παίξετε εκτός σύνδεσης, αλλά η πρόοδός σας θα αποθηκευτεί τοπικά ως επισκέπτης.';

  @override
  String get playAsGuest => 'Παίξτε ως Επισκέπτης';

  @override
  String get retry => 'Δοκιμάστε ξανά';

  @override
  String get exitTitle => 'Έξοδος από το QuizAlyx;';

  @override
  String get exitDesc =>
      'Είστε σίγουροι ότι θέλετε να εγκαταλείψετε το παιχνίδι;';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get exit => 'Έξοδος';

  @override
  String get dailyRewardTitle => 'Ημερήσια Ανταμοιβή';

  @override
  String get dailyRewardDesc =>
      'Κερδίσατε 5 νομίσματα για τη σημερινή σας είσοδο!';

  @override
  String get plus5Coins => '+5 ΝΟΜΙΣΜΑΤΑ';

  @override
  String get collect => 'Συλλογή';

  @override
  String currentStreak(int days) {
    return 'Τρέχον σερί: $days ημέρες!';
  }

  @override
  String get guestPlayer => 'Επισκέπτης';

  @override
  String get notLoggedIn => 'Δεν έχετε συνδεθεί';

  @override
  String get myAccount => 'Ο Λογαριασμός μου';

  @override
  String get myStatistics => 'Τα Στατιστικά μου';

  @override
  String get loginSignup => 'Σύνδεση / Εγγραφή';

  @override
  String get logOut => 'Αποσύνδεση';

  @override
  String get appSlogan => 'Προκάλεσε τις γνώσεις σου';

  @override
  String get missionCompleted => 'Η ΑΠΟΣΤΟΛΗ ΟΛΟΚΛΗΡΩΘΗΚΕ!';

  @override
  String get leaderboards => 'Πίνακες Κατάταξης';

  @override
  String get leaderboardsOfflineDesc =>
      'Οι πίνακες κατάταξης απαιτούν σύνδεση στο διαδίκτυο για συγχρονισμό.';

  @override
  String get unexpectedError => 'Παρουσιάστηκε μη αναμενόμενο σφάλμα.';

  @override
  String get noOnePlayedYet => 'Κανείς δεν έχει παίξει ακόμα!';

  @override
  String get beTheFirstToPlay =>
      'Λύσε ένα κουίζ τώρα και γίνε ο πρώτος στη λίστα.';

  @override
  String get topPlayers => 'Κορυφαίοι Παίκτες';

  @override
  String get challengeThem => 'Προκάλεσέ τους για να πάρεις τη θέση σου!';

  @override
  String get pts => 'π.';

  @override
  String get signInWithGoogle => 'Σύνδεση με Google';

  @override
  String get continueAsGuest => 'Συνέχεια ως επισκέπτης';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins Νομίσματα!';
  }

  @override
  String get mission_global_title => 'Κυρίαρχος Ερωτήσεων';

  @override
  String get mission_global_desc => 'Λύστε συνολικά X ερωτήσεις';

  @override
  String get mission_title_Math => 'Μαθηματικά';

  @override
  String get mission_desc_Math => 'Λύστε ερωτήσεις μαθηματικών';

  @override
  String get mission_title_Physics => 'Φυσική';

  @override
  String get mission_desc_Physics => 'Λύστε ερωτήσεις φυσικής';

  @override
  String get mission_title_Chemistry => 'Χημεία';

  @override
  String get mission_desc_Chemistry => 'Λύστε ερωτήσεις χημείας';

  @override
  String get mission_title_Biology => 'Βιολογία';

  @override
  String get mission_desc_Biology => 'Λύστε ερωτήσεις βιολογίας';

  @override
  String get mission_title_History => 'Ιστορία';

  @override
  String get mission_desc_History => 'Λύστε ερωτήσεις ιστορίας';

  @override
  String get mission_title_Geography => 'Γεωγραφία';

  @override
  String get mission_desc_Geography => 'Λύστε ερωτήσεις γεωγραφίας';

  @override
  String get mission_title_Literature => 'Λογοτεχνία';

  @override
  String get mission_desc_Literature => 'Λύστε ερωτήσεις λογοτεχνίας';

  @override
  String get mission_title_Art => 'Τέχνη';

  @override
  String get mission_desc_Art => 'Λύστε ερωτήσεις τέχνης';

  @override
  String get mission_title_Music => 'Μουσική';

  @override
  String get mission_desc_Music => 'Λύστε ερωτήσεις μουσικής';

  @override
  String get mission_title_Sports => 'Αθλητισμός';

  @override
  String get mission_desc_Sports => 'Λύστε ερωτήσεις αθλητισμού';

  @override
  String get mission_title_Technology => 'Τεχνολογία';

  @override
  String get mission_desc_Technology => 'Λύστε ερωτήσεις τεχνολογίας';

  @override
  String get mission_title_Software => 'Λογισμικό';

  @override
  String get mission_desc_Software => 'Λύστε ερωτήσεις λογισμικού';

  @override
  String get mission_title_Mechanic => 'Μηχανική';

  @override
  String get mission_desc_Mechanic => 'Λύστε ερωτήσεις μηχανικής';

  @override
  String get mission_title_Religion => 'Θρησκεία';

  @override
  String get mission_desc_Religion => 'Λύστε ερωτήσεις θρησκείας';

  @override
  String get careerAchievements => 'Καριέρα & Επιτεύγματα';

  @override
  String get totalAchievements => 'Συνολικά Επιτεύγματα';

  @override
  String get maxLevel => 'ΜΕΓ';

  @override
  String get completed => 'Ολοκληρώθηκε';

  @override
  String levelProgress(int current, int total) {
    return 'Επίπεδο $current / $total';
  }

  @override
  String get selectGameMode => 'Επιλογή Λειτουργίας';

  @override
  String get modeClassic => 'Κλασική';

  @override
  String get modeClassicDesc => 'Σταθερές ερωτήσεις, πάρτε το χρόνο σας';

  @override
  String get modeTimed => 'Με χρόνο';

  @override
  String get modeTimedDesc => 'Αγώνας ενάντια στο χρόνο';

  @override
  String get modeEndless => 'Ατελείωτη';

  @override
  String get modeEndlessDesc => 'Απαντήστε σε όσες περισσότερες μπορείτε';

  @override
  String get defaultPlayerName => 'Παίκτης QuizAlyx';

  @override
  String get editProfileName => 'Επεξεργασία Ονόματος';

  @override
  String get enterNewName => 'Εισαγάγετε το νέο σας όνομα';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get nameChangeLimitTitle => 'Όριο Αλλαγής Ονόματος';

  @override
  String get nameChangeLimitDesc =>
      'Μπορείτε να αλλάξετε το όνομά σας μόνο 2 φορές κάθε 14 ημέρες. Προσπαθήστε ξανά αργότερα.';

  @override
  String get ok => 'ΟΚ';

  @override
  String get unknownDate => 'Άγνωστο';

  @override
  String get accountStatus => 'Κατάσταση Λογαριασμού';

  @override
  String get verified => 'Επαληθεύτηκε';

  @override
  String get guestAccount => 'Λογαριασμός Επισκέπτη';

  @override
  String get joinedDate => 'Ημερομηνία Εγγραφής';

  @override
  String get membership => 'Συνδρομή';

  @override
  String get freeTier => 'Δωρεάν';

  @override
  String daysCount(int count) {
    return '$count Ημέρες';
  }

  @override
  String get dataLoadError => 'Δεν ήταν δυνατή η φόρτωση των δεδομένων.';

  @override
  String get totalScore => 'Συνολική Βαθμολογία';

  @override
  String get quizzesPlayed => 'Κουίζ που παίχτηκαν';

  @override
  String get accuracyRate => 'Ποσοστό Ακρίβειας';

  @override
  String get dailyStreak => 'Ημερήσιο Σερί';

  @override
  String get enterPlayerNameError =>
      'Παρακαλώ εισαγάγετε ένα ωραίο όνομα παίκτη!';

  @override
  String get welcomeToQuizAlyx => 'Καλώς ήρθατε στο QuizAlyx!';

  @override
  String get chooseAvatarName => 'Επιλέξτε το άβαταρ και το όνομά σας.';

  @override
  String get enterPlayerNameHint => 'Εισαγωγή Ονόματος Παίκτη';

  @override
  String get startJourney => 'Έναρξη Ταξιδιού';

  @override
  String get quitQuizTitle => 'Έξοδος από το κουίζ;';

  @override
  String get quitQuizDesc =>
      'Η πρόοδός σας θα χαθεί. Είστε σίγουροι ότι θέλετε να επιστρέψετε στην Αρχική;';

  @override
  String get quit => 'Έξοδος';

  @override
  String get no5050JokerWarning => 'Δεν έχετε άλλα Τζόκερ 50/50!';

  @override
  String get noTimeFreezeWarning => 'Δεν έχετε άλλη Παύση Χρόνου!';

  @override
  String get quiz => 'Κουίζ';

  @override
  String timeSeconds(int seconds) {
    return 'Χρόνος: $seconds δ';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Ερώτηση $current / $total';
  }

  @override
  String get quizCompleted => 'Το Κουίζ Ολοκληρώθηκε!';

  @override
  String get correct => 'Σωστό';

  @override
  String get wrong => 'Λάθος';

  @override
  String get score => 'Βαθμολογία';

  @override
  String get continueBtn => 'Συνέχεια';

  @override
  String get whatsNext => 'Τι ακολουθεί;';

  @override
  String get playAgain => 'Παίξτε Ξανά';

  @override
  String get backToHome => 'Επιστροφή στην Αρχική';

  @override
  String get timesUp => 'Τέλος Χρόνου!';

  @override
  String get language => 'Γλώσσα';

  @override
  String get settingsSaved => 'Οι ρυθμίσεις αποθηκεύτηκαν επιτυχώς!';

  @override
  String get resetHighScoresTitle => 'Επαναφορά Υψηλών Βαθμολογιών;';

  @override
  String get resetHighScoresDesc =>
      'Αυτό θα διαγράψει όλες τις υψηλές βαθμολογίες σας. Αυτή η ενέργεια δεν μπορεί να αναιρεθεί.';

  @override
  String get reset => 'Επαναφορά';

  @override
  String get highScoresResetSuccess =>
      'Οι υψηλές βαθμολογίες επαναφέρθηκαν επιτυχώς!';

  @override
  String get appearance => 'Εμφάνιση';

  @override
  String get goldTheme => 'Χρυσό Θέμα';

  @override
  String get premiumGoldLook => 'Premium χρυσή εμφάνιση';

  @override
  String get unlockInStore => 'Ξεκλείδωμα στο Κατάστημα';

  @override
  String get diamondTheme => 'Θέμα Διαμάντι';

  @override
  String get legendaryDiamondLook => 'Θρυλική εμφάνιση διαμαντιού';

  @override
  String get unlockInStore1500 => 'Ξεκλείδωμα στο Κατάστημα (1500 Νομίσματα)';

  @override
  String get gameplay => 'Παιχνίδι';

  @override
  String get numberOfQuestions => 'Αριθμός Ερωτήσεων';

  @override
  String get timedDurationSec => 'Διάρκεια με χρόνο (δευτ.)';

  @override
  String get endlessDurationSec => 'Ατελείωτη Διάρκεια (δευτ.)';

  @override
  String get display => 'Οθόνη';

  @override
  String get showDifficulty => 'Εμφάνιση Δυσκολίας';

  @override
  String get showDifficultyDesc =>
      'Εμφάνιση επιπέδου δυσκολίας για κάθε ερώτηση';

  @override
  String get actions => 'Ενέργειες';

  @override
  String get saveSettings => 'Αποθήκευση Ρυθμίσεων';

  @override
  String get resetScores => 'Επαναφορά Βαθμολογιών';

  @override
  String get visitStoreToUnlock => 'Επισκεφθείτε το Κατάστημα για ξεκλείδωμα!';

  @override
  String get storeTitle => 'Κατάστημα';

  @override
  String specialBundlePurchased(int remaining) {
    return 'Το Ειδικό Πακέτο Αγοράστηκε! (Απομένουν: $remaining)';
  }

  @override
  String get notEnoughCoins => 'Δεν έχετε αρκετά νομίσματα!';

  @override
  String get exchangeSuccessful => 'Η ανταλλαγή ήταν επιτυχής!';

  @override
  String get notEnoughPoints => 'Δεν έχετε αρκετούς πόντους!';

  @override
  String get themeUnlockedSettings =>
      'Το Θέμα Ξεκλειδώθηκε! Ενεργοποιήστε το στις Ρυθμίσεις.';

  @override
  String itemPurchased(String itemName) {
    return 'Το $itemName αγοράστηκε!';
  }

  @override
  String get currencyExchange => 'ΑΝΤΑΛΛΑΓΗ ΝΟΜΙΣΜΑΤΩΝ';

  @override
  String get shopItems => 'ΑΝΤΙΚΕΙΜΕΝΑ ΚΑΤΑΣΤΗΜΑΤΟΣ';

  @override
  String get limitedOffer => 'ΠΕΡΙΟΡΙΣΜΕΝΗ ΠΡΟΣΦΟΡΑ';

  @override
  String endsInDays(int days) {
    return 'Λήγει σε $days ημέρες';
  }

  @override
  String get megaBoosterPack => 'Μέγα Πακέτο Ενίσχυσης';

  @override
  String get boosterPackDesc => '1x Τζόκερ 50/50 + 1x Παύση Χρόνου';

  @override
  String remainingLimit(int current, int max) {
    return 'Υπόλοιπο: $current / $max';
  }

  @override
  String get coinsText => 'Νομίσματα';

  @override
  String get convertBtn => 'Μετατροπή';

  @override
  String get joker5050 => 'Τζόκερ 50/50';

  @override
  String get joker5050Desc => 'Αφαιρεί 2 λάθος επιλογές';

  @override
  String get timeFreeze => 'Παύση Χρόνου';

  @override
  String get timeFreezeDesc => 'Σταματά τον χρόνο για 10δ';

  @override
  String get premiumTheme => 'Premium Θέμα';

  @override
  String get unlockGoldTheme => 'Ξεκλείδωμα Χρυσού Θέματος';

  @override
  String get unlockDiamondInterface => 'Ξεκλείδωμα Διεπαφής Διαμαντιού';

  @override
  String get themeUnlocked => 'Το Θέμα Ξεκλειδώθηκε';

  @override
  String get owned => 'ΑΠΟΚΤΗΘΗΚΕ';

  @override
  String get selectTopic => 'Επιλογή Θέματος';

  @override
  String topicDifficulty(String topic) {
    return 'Δυσκολία: $topic';
  }

  @override
  String get beginner => 'Αρχάριος';

  @override
  String get intermediate => 'Μεσαίος';

  @override
  String get advanced => 'Προχωρημένος';

  @override
  String get dangerZone => 'Επικίνδυνη Ζώνη';

  @override
  String get deleteAccountTitle => 'Διαγραφή Λογαριασμού & Δεδομένων';

  @override
  String get deleteAccountSubtitle =>
      'Οριστική διαγραφή του προφίλ σας και των τοπικών/cloud αρχείων';

  @override
  String get deleteAccountConfirmTitle => 'Διαγραφή Λογαριασμού & Δεδομένων;';

  @override
  String get deleteAccountConfirmDesc =>
      'Αυτό θα διαγράψει οριστικά το προφίλ σας, τις υψηλές βαθμολογίες, το απόθεμα και τα δεδομένα του πίνακα κατάταξης. Αυτή η ενέργεια ΔΕΝ μπορεί να αναιρεθεί.';

  @override
  String get deletePermanently => 'Οριστική Διαγραφή';

  @override
  String get accountDeletedSuccess =>
      'Ο λογαριασμός και όλα τα σχετικά δεδομένα διαγράφηκαν επιτυχώς!';

  @override
  String deleteAccountError(String error) {
    return 'Σφάλμα: $error. Ίσως χρειαστεί να συνδεθείτε ξανά για να διαγράψετε τον λογαριασμό σας.';
  }

  @override
  String get securityCheckTitle => 'Έλεγχος Ασφαλείας';

  @override
  String get securityCheckDesc =>
      'Η διαγραφή του λογαριασμού σας είναι μια ευαίσθητη διαδικασία. Για την ασφάλειά σας, αποσυνδεθείτε και συνδεθείτε ξανά πριν προσπαθήσετε να διαγράψετε τον λογαριασμό σας.';

  @override
  String get logOutAndReLogin => 'Αποσύνδεση & Επανασύνδεση';
}
