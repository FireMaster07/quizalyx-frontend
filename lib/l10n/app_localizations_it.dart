// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'INIZIA QUIZ';

  @override
  String get settings => 'Impostazioni';

  @override
  String get offlineTitle => 'Nessuna connessione Internet';

  @override
  String get offlineDesc =>
      'Controlla la tua connessione Internet. Puoi ancora giocare offline, ma i tuoi progressi verranno salvati localmente come ospite.';

  @override
  String get playAsGuest => 'Gioca come Ospite';

  @override
  String get retry => 'Riprova';

  @override
  String get exitTitle => 'Uscire da QuizAlyx?';

  @override
  String get exitDesc => 'Sei sicuro di voler uscire dal gioco?';

  @override
  String get cancel => 'Annulla';

  @override
  String get exit => 'Esci';

  @override
  String get dailyRewardTitle => 'Ricompensa Giornaliera';

  @override
  String get dailyRewardDesc =>
      'Hai guadagnato 5 monete per aver effettuato l\'accesso oggi!';

  @override
  String get plus5Coins => '+5 MONETE';

  @override
  String get collect => 'Riscatta';

  @override
  String currentStreak(int days) {
    return 'Serie attuale: $days giorni!';
  }

  @override
  String get guestPlayer => 'Giocatore Ospite';

  @override
  String get notLoggedIn => 'Non loggato';

  @override
  String get myAccount => 'Il Mio Account';

  @override
  String get myStatistics => 'Le Mie Statistiche';

  @override
  String get loginSignup => 'Accedi / Registrati';

  @override
  String get logOut => 'Esci';

  @override
  String get appSlogan => 'Sfida le tue conoscenze';

  @override
  String get missionCompleted => 'MISSIONE COMPLETATA!';

  @override
  String get leaderboards => 'Classifiche';

  @override
  String get leaderboardsOfflineDesc =>
      'Le classifiche richiedono una connessione Internet per sincronizzare i punteggi globali.';

  @override
  String get unexpectedError => 'Si è verificato un errore imprevisto.';

  @override
  String get noOnePlayedYet => 'Nessuno ha ancora giocato!';

  @override
  String get beTheFirstToPlay =>
      'Risolvi un quiz ora e sii il primo a entrare nella lista.';

  @override
  String get topPlayers => 'Migliori Giocatori';

  @override
  String get challengeThem => 'Sfidali per rivendicare il tuo posto!';

  @override
  String get pts => 'pti';

  @override
  String get signInWithGoogle => 'Accedi con Google';

  @override
  String get continueAsGuest => 'Continua come ospite';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins Monete!';
  }

  @override
  String get mission_global_title => 'Maestro delle Domande';

  @override
  String get mission_global_desc => 'Risolvi un totale di X domande';

  @override
  String get mission_title_Math => 'Matematica';

  @override
  String get mission_desc_Math => 'Risolvi domande di matematica';

  @override
  String get mission_title_Physics => 'Fisica';

  @override
  String get mission_desc_Physics => 'Risolvi domande di fisica';

  @override
  String get mission_title_Chemistry => 'Chimica';

  @override
  String get mission_desc_Chemistry => 'Risolvi domande di chimica';

  @override
  String get mission_title_Biology => 'Biologia';

  @override
  String get mission_desc_Biology => 'Risolvi domande di biologia';

  @override
  String get mission_title_History => 'Storia';

  @override
  String get mission_desc_History => 'Risolvi domande di storia';

  @override
  String get mission_title_Geography => 'Geografia';

  @override
  String get mission_desc_Geography => 'Risolvi domande di geografia';

  @override
  String get mission_title_Literature => 'Letteratura';

  @override
  String get mission_desc_Literature => 'Risolvi domande di letteratura';

  @override
  String get mission_title_Art => 'Arte';

  @override
  String get mission_desc_Art => 'Risolvi domande d\'arte';

  @override
  String get mission_title_Music => 'Musica';

  @override
  String get mission_desc_Music => 'Risolvi domande di musica';

  @override
  String get mission_title_Sports => 'Sport';

  @override
  String get mission_desc_Sports => 'Risolvi domande di sport';

  @override
  String get mission_title_Technology => 'Tecnologia';

  @override
  String get mission_desc_Technology => 'Risolvi domande di tecnologia';

  @override
  String get mission_title_Software => 'Software';

  @override
  String get mission_desc_Software => 'Risolvi domande di software';

  @override
  String get mission_title_Mechanic => 'Meccanica';

  @override
  String get mission_desc_Mechanic => 'Risolvi domande di meccanica';

  @override
  String get mission_title_Religion => 'Religione';

  @override
  String get mission_desc_Religion => 'Risolvi domande di religione';

  @override
  String get careerAchievements => 'Carriera e Risultati';

  @override
  String get totalAchievements => 'Risultati Totali';

  @override
  String get maxLevel => 'MAX';

  @override
  String get completed => 'Completato';

  @override
  String levelProgress(int current, int total) {
    return 'Livello $current / $total';
  }

  @override
  String get selectGameMode => 'Seleziona Modalità';

  @override
  String get modeClassic => 'Classica';

  @override
  String get modeClassicDesc => 'Domande fisse, prenditi il tuo tempo';

  @override
  String get modeTimed => 'A Tempo';

  @override
  String get modeTimedDesc => 'Gara contro il tempo';

  @override
  String get modeEndless => 'Infinita';

  @override
  String get modeEndlessDesc => 'Rispondi al maggior numero possibile';

  @override
  String get defaultPlayerName => 'Giocatore QuizAlyx';

  @override
  String get editProfileName => 'Modifica il nome';

  @override
  String get enterNewName => 'Inserisci il tuo nuovo nome';

  @override
  String get save => 'Salva';

  @override
  String get nameChangeLimitTitle => 'Limite Cambio Nome';

  @override
  String get nameChangeLimitDesc =>
      'Puoi cambiare il tuo nome solo 2 volte ogni 14 giorni. Riprova più tardi.';

  @override
  String get ok => 'OK';

  @override
  String get unknownDate => 'Sconosciuto';

  @override
  String get accountStatus => 'Stato Account';

  @override
  String get verified => 'Verificato';

  @override
  String get guestAccount => 'Account Ospite';

  @override
  String get joinedDate => 'Data di iscrizione';

  @override
  String get membership => 'Abbonamento';

  @override
  String get freeTier => 'Gratuito';

  @override
  String daysCount(int count) {
    return '$count Giorni';
  }

  @override
  String get dataLoadError => 'Impossibile caricare i dati.';

  @override
  String get totalScore => 'Punteggio Totale';

  @override
  String get quizzesPlayed => 'Quiz Giocati';

  @override
  String get accuracyRate => 'Tasso di Precisione';

  @override
  String get dailyStreak => 'Serie Giornaliera';

  @override
  String get enterPlayerNameError => 'Inserisci un nome giocatore fantastico!';

  @override
  String get welcomeToQuizAlyx => 'Benvenuto in QuizAlyx!';

  @override
  String get chooseAvatarName => 'Scegli il tuo avatar e il tuo nome.';

  @override
  String get enterPlayerNameHint => 'Inserisci il Nome Giocatore';

  @override
  String get startJourney => 'Inizia l\'Avventura';

  @override
  String get quitQuizTitle => 'Uscire dal Quiz?';

  @override
  String get quitQuizDesc =>
      'I tuoi progressi andranno persi. Sei sicuro di voler tornare alla Home?';

  @override
  String get quit => 'Esci';

  @override
  String get no5050JokerWarning => 'Non hai più Joker 50/50!';

  @override
  String get noTimeFreezeWarning => 'Non hai più Blocca Tempo!';

  @override
  String get quiz => 'Quiz';

  @override
  String timeSeconds(int seconds) {
    return 'Tempo: $seconds s';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Domanda $current / $total';
  }

  @override
  String get quizCompleted => 'Quiz Completato!';

  @override
  String get correct => 'Corretto';

  @override
  String get wrong => 'Sbagliato';

  @override
  String get score => 'Punteggio';

  @override
  String get continueBtn => 'Continua';

  @override
  String get whatsNext => 'E adesso?';

  @override
  String get playAgain => 'Gioca Ancora';

  @override
  String get backToHome => 'Torna alla Home';

  @override
  String get timesUp => 'Tempo Scaduto!';

  @override
  String get language => 'Lingua';

  @override
  String get settingsSaved => 'Impostazioni salvate con successo!';

  @override
  String get resetHighScoresTitle => 'Azzera Punteggi?';

  @override
  String get resetHighScoresDesc =>
      'Questo eliminerà tutti i tuoi record. Questa azione non può essere annullata.';

  @override
  String get reset => 'Azzera';

  @override
  String get highScoresResetSuccess => 'Punteggi azzerati con successo!';

  @override
  String get appearance => 'Aspetto';

  @override
  String get goldTheme => 'Tema Oro';

  @override
  String get premiumGoldLook => 'Look oro premium';

  @override
  String get unlockInStore => 'Sblocca nel Negozio';

  @override
  String get diamondTheme => 'Tema Diamante';

  @override
  String get legendaryDiamondLook => 'Look diamante leggendario';

  @override
  String get unlockInStore1500 => 'Sblocca nel Negozio (1500 Monete)';

  @override
  String get gameplay => 'Dinamica di Gioco';

  @override
  String get numberOfQuestions => 'Numero di Domande';

  @override
  String get timedDurationSec => 'Durata a tempo (sec)';

  @override
  String get endlessDurationSec => 'Durata infinita (sec)';

  @override
  String get display => 'Schermo';

  @override
  String get showDifficulty => 'Mostra Difficoltà';

  @override
  String get showDifficultyDesc =>
      'Mostra il livello di difficoltà per ogni domanda';

  @override
  String get actions => 'Azioni';

  @override
  String get saveSettings => 'Salva Impostazioni';

  @override
  String get resetScores => 'Azzera Punteggi';

  @override
  String get visitStoreToUnlock => 'Visita il Negozio per sbloccare!';

  @override
  String get storeTitle => 'Negozio';

  @override
  String specialBundlePurchased(int remaining) {
    return 'Pacchetto Speciale Acquistato! (Rimanenti: $remaining)';
  }

  @override
  String get notEnoughCoins => 'Non hai abbastanza monete!';

  @override
  String get exchangeSuccessful => 'Scambio riuscito!';

  @override
  String get notEnoughPoints => 'Non hai abbastanza punti!';

  @override
  String get themeUnlockedSettings =>
      'Tema Sbloccato! Attivalo nelle Impostazioni.';

  @override
  String itemPurchased(String itemName) {
    return '$itemName acquistato!';
  }

  @override
  String get currencyExchange => 'CAMBIO VALUTA';

  @override
  String get shopItems => 'OGGETTI NEGOZIO';

  @override
  String get limitedOffer => 'OFFERTA LIMITATA';

  @override
  String endsInDays(int days) {
    return 'Scade in $days giorni';
  }

  @override
  String get megaBoosterPack => 'Mega Pacchetto Booster';

  @override
  String get boosterPackDesc => '1x Joker 50/50 + 1x Blocca Tempo';

  @override
  String remainingLimit(int current, int max) {
    return 'Rimanenti: $current / $max';
  }

  @override
  String get coinsText => 'Monete';

  @override
  String get convertBtn => 'Converti';

  @override
  String get joker5050 => 'Joker 50/50';

  @override
  String get joker5050Desc => 'Rimuove 2 opzioni errate';

  @override
  String get timeFreeze => 'Blocca Tempo';

  @override
  String get timeFreezeDesc => 'Ferma il timer per 10s';

  @override
  String get premiumTheme => 'Tema Premium';

  @override
  String get unlockGoldTheme => 'Sblocca Tema Oro';

  @override
  String get unlockDiamondInterface => 'Sblocca Interfaccia Diamante';

  @override
  String get themeUnlocked => 'Tema Sbloccato';

  @override
  String get owned => 'POSSEDUTO';

  @override
  String get selectTopic => 'Seleziona Argomento';

  @override
  String topicDifficulty(String topic) {
    return 'Difficoltà: $topic';
  }

  @override
  String get beginner => 'Principiante';

  @override
  String get intermediate => 'Intermedio';

  @override
  String get advanced => 'Avanzato';

  @override
  String get dangerZone => 'Zona di pericolo';

  @override
  String get deleteAccountTitle => 'Elimina account e cancella i dati';

  @override
  String get deleteAccountSubtitle =>
      'Elimina in modo permanente il tuo profilo e i record locali/cloud';

  @override
  String get deleteAccountConfirmTitle => 'Eliminare account e dati?';

  @override
  String get deleteAccountConfirmDesc =>
      'Questo eliminerà in modo permanente il tuo profilo, i record, l\'inventario e i dati della classifica. Questa azione NON può essere annullata.';

  @override
  String get deletePermanently => 'Elimina definitivamente';

  @override
  String get accountDeletedSuccess =>
      'Account e tutti i dati associati cancellati con successo!';

  @override
  String deleteAccountError(String error) {
    return 'Errore: $error. Potrebbe essere necessario autenticarsi di nuovo per eliminare l\'account.';
  }

  @override
  String get securityCheckTitle => 'Controllo di sicurezza';

  @override
  String get securityCheckDesc =>
      'L\'eliminazione del tuo account è un\'operazione delicata. Per la tua sicurezza, disconnettiti e accedi nuovamente prima di tentare di eliminare il tuo account.';

  @override
  String get logOutAndReLogin => 'Disconnetti e accedi di nuovo';
}
