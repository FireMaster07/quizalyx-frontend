// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'START QUIZ';

  @override
  String get settings => 'Settings';

  @override
  String get offlineTitle => 'No Internet Connection';

  @override
  String get offlineDesc =>
      'Please check your internet connection. You can still play offline, but your progress will be saved locally as a guest.';

  @override
  String get playAsGuest => 'Play as Guest';

  @override
  String get retry => 'Retry';

  @override
  String get exitTitle => 'Exit QuizAlyx?';

  @override
  String get exitDesc => 'Are you sure you want to leave the game?';

  @override
  String get cancel => 'Cancel';

  @override
  String get exit => 'Exit';

  @override
  String get dailyRewardTitle => 'Daily Reward';

  @override
  String get dailyRewardDesc => 'You earned 5 coins for logging in today!';

  @override
  String get plus5Coins => '+5 COINS';

  @override
  String get collect => 'Collect';

  @override
  String currentStreak(int days) {
    return 'Current streak: $days days!';
  }

  @override
  String get guestPlayer => 'Guest Player';

  @override
  String get notLoggedIn => 'Not logged in';

  @override
  String get myAccount => 'My Account';

  @override
  String get myStatistics => 'My Statistics';

  @override
  String get loginSignup => 'Log In / Sign Up';

  @override
  String get logOut => 'Log Out';

  @override
  String get appSlogan => 'Challenge Your Knowledge';

  @override
  String get missionCompleted => 'MISSION COMPLETED!';

  @override
  String get leaderboards => 'Leaderboards';

  @override
  String get leaderboardsOfflineDesc =>
      'Leaderboards require an active internet connection to sync global scores.';

  @override
  String get unexpectedError => 'An unexpected error occurred.';

  @override
  String get noOnePlayedYet => 'No one has played yet!';

  @override
  String get beTheFirstToPlay =>
      'Solve a quiz now and be the first to enter the list.';

  @override
  String get topPlayers => 'Top Players';

  @override
  String get challengeThem => 'Challenge them to claim your spot!';

  @override
  String get pts => 'pts';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins Coins!';
  }

  @override
  String get mission_global_title => 'Question Master';

  @override
  String get mission_global_desc => 'Solve a total of X questions';

  @override
  String get mission_title_Math => 'Math';

  @override
  String get mission_desc_Math => 'Solve Math questions';

  @override
  String get mission_title_Physics => 'Physics';

  @override
  String get mission_desc_Physics => 'Solve Physics questions';

  @override
  String get mission_title_Chemistry => 'Chemistry';

  @override
  String get mission_desc_Chemistry => 'Solve Chemistry questions';

  @override
  String get mission_title_Biology => 'Biology';

  @override
  String get mission_desc_Biology => 'Solve Biology questions';

  @override
  String get mission_title_History => 'History';

  @override
  String get mission_desc_History => 'Solve History questions';

  @override
  String get mission_title_Geography => 'Geography';

  @override
  String get mission_desc_Geography => 'Solve Geography questions';

  @override
  String get mission_title_Literature => 'Literature';

  @override
  String get mission_desc_Literature => 'Solve Literature questions';

  @override
  String get mission_title_Art => 'Art';

  @override
  String get mission_desc_Art => 'Solve Art questions';

  @override
  String get mission_title_Music => 'Music';

  @override
  String get mission_desc_Music => 'Solve Music questions';

  @override
  String get mission_title_Sports => 'Sports';

  @override
  String get mission_desc_Sports => 'Solve Sports questions';

  @override
  String get mission_title_Technology => 'Technology';

  @override
  String get mission_desc_Technology => 'Solve Technology questions';

  @override
  String get mission_title_Software => 'Software';

  @override
  String get mission_desc_Software => 'Solve Software questions';

  @override
  String get mission_title_Mechanic => 'Mechanic';

  @override
  String get mission_desc_Mechanic => 'Solve Mechanic questions';

  @override
  String get mission_title_Religion => 'Religion';

  @override
  String get mission_desc_Religion => 'Solve Religion questions';

  @override
  String get careerAchievements => 'Career & Achievements';

  @override
  String get totalAchievements => 'Total Achievements';

  @override
  String get maxLevel => 'MAX';

  @override
  String get completed => 'Completed';

  @override
  String levelProgress(int current, int total) {
    return 'Level $current / $total';
  }

  @override
  String get selectGameMode => 'Select Game Mode';

  @override
  String get modeClassic => 'Classic';

  @override
  String get modeClassicDesc => 'Fixed questions, take your time';

  @override
  String get modeTimed => 'Timed';

  @override
  String get modeTimedDesc => 'Race against the clock';

  @override
  String get modeEndless => 'Endless';

  @override
  String get modeEndlessDesc => 'Answer as many as you can';

  @override
  String get defaultPlayerName => 'QuizAlyx Player';

  @override
  String get editProfileName => 'Edit Profile Name';

  @override
  String get enterNewName => 'Enter your new name';

  @override
  String get save => 'Save';

  @override
  String get nameChangeLimitTitle => 'Name Change Limit';

  @override
  String get nameChangeLimitDesc =>
      'You can only change your name 2 times every 14 days. Please try again later.';

  @override
  String get ok => 'OK';

  @override
  String get unknownDate => 'Unknown';

  @override
  String get accountStatus => 'Account Status';

  @override
  String get verified => 'Verified';

  @override
  String get guestAccount => 'Guest Account';

  @override
  String get joinedDate => 'Joined Date';

  @override
  String get membership => 'Membership';

  @override
  String get freeTier => 'Free Tier';

  @override
  String daysCount(int count) {
    return '$count Days';
  }

  @override
  String get dataLoadError => 'Data could not be loaded.';

  @override
  String get totalScore => 'Total Score';

  @override
  String get quizzesPlayed => 'Quizzes Played';

  @override
  String get accuracyRate => 'Accuracy Rate';

  @override
  String get dailyStreak => 'Daily Streak';

  @override
  String get enterPlayerNameError => 'Please enter a cool player name!';

  @override
  String get welcomeToQuizAlyx => 'Welcome to QuizAlyx!';

  @override
  String get chooseAvatarName => 'Choose your player avatar and name.';

  @override
  String get enterPlayerNameHint => 'Enter Player Name';

  @override
  String get startJourney => 'Start Journey';

  @override
  String get quitQuizTitle => 'Quit Quiz?';

  @override
  String get quitQuizDesc =>
      'Your progress will be lost. Are you sure you want to go back to Home?';

  @override
  String get quit => 'Quit';

  @override
  String get no5050JokerWarning => 'You don\'t have any 50/50 Joker!';

  @override
  String get noTimeFreezeWarning => 'You don\'t have any Time Freeze!';

  @override
  String get quiz => 'Quiz';

  @override
  String timeSeconds(int seconds) {
    return 'Time: $seconds s';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Question $current / $total';
  }

  @override
  String get quizCompleted => 'Quiz Completed!';

  @override
  String get correct => 'Correct';

  @override
  String get wrong => 'Wrong';

  @override
  String get score => 'Score';

  @override
  String get continueBtn => 'Continue';

  @override
  String get whatsNext => 'What\'s Next?';

  @override
  String get playAgain => 'Play Again';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get timesUp => 'Time\'s Up!';

  @override
  String get language => 'Language';

  @override
  String get settingsSaved => 'Settings saved successfully!';

  @override
  String get resetHighScoresTitle => 'Reset High Scores?';

  @override
  String get resetHighScoresDesc =>
      'This will delete all your high scores. This action cannot be undone.';

  @override
  String get reset => 'Reset';

  @override
  String get highScoresResetSuccess => 'High scores reset successfully!';

  @override
  String get appearance => 'Appearance';

  @override
  String get goldTheme => 'Gold Theme';

  @override
  String get premiumGoldLook => 'Premium gold look';

  @override
  String get unlockInStore => 'Unlock in Store';

  @override
  String get diamondTheme => 'Diamond Theme';

  @override
  String get legendaryDiamondLook => 'Legendary diamond look';

  @override
  String get unlockInStore1500 => 'Unlock in Store (1500 Coins)';

  @override
  String get gameplay => 'Gameplay';

  @override
  String get numberOfQuestions => 'Number of Questions';

  @override
  String get timedDurationSec => 'Timed duration (sec)';

  @override
  String get endlessDurationSec => 'Endless Duration (sec)';

  @override
  String get display => 'Display';

  @override
  String get showDifficulty => 'Show Difficulty';

  @override
  String get showDifficultyDesc => 'Display difficulty level for each question';

  @override
  String get actions => 'Actions';

  @override
  String get saveSettings => 'Save Settings';

  @override
  String get resetScores => 'Reset Scores';

  @override
  String get visitStoreToUnlock => 'Visit the Store to unlock!';

  @override
  String get storeTitle => 'Store';

  @override
  String specialBundlePurchased(int remaining) {
    return 'Special Bundle Purchased! (Remaining: $remaining)';
  }

  @override
  String get notEnoughCoins => 'Not enough coins!';

  @override
  String get exchangeSuccessful => 'Exchange successful!';

  @override
  String get notEnoughPoints => 'Not enough points!';

  @override
  String get themeUnlockedSettings => 'Theme Unlocked! Enable it in Settings.';

  @override
  String itemPurchased(String itemName) {
    return '$itemName purchased!';
  }

  @override
  String get currencyExchange => 'CURRENCY EXCHANGE';

  @override
  String get shopItems => 'SHOP ITEMS';

  @override
  String get limitedOffer => 'LIMITED OFFER';

  @override
  String endsInDays(int days) {
    return 'Ends in $days days';
  }

  @override
  String get megaBoosterPack => 'Mega Booster Pack';

  @override
  String get boosterPackDesc => '1x 50/50 Joker + 1x Time Freeze';

  @override
  String remainingLimit(int current, int max) {
    return 'Remaining: $current / $max';
  }

  @override
  String get coinsText => 'Coins';

  @override
  String get convertBtn => 'Convert';

  @override
  String get joker5050 => '50/50 Joker';

  @override
  String get joker5050Desc => 'Removes 2 wrong options';

  @override
  String get timeFreeze => 'Time Freeze';

  @override
  String get timeFreezeDesc => 'Stops timer for 10s';

  @override
  String get premiumTheme => 'Premium Theme';

  @override
  String get unlockGoldTheme => 'Unlock Gold Theme';

  @override
  String get unlockDiamondInterface => 'Unlock Diamond Interface';

  @override
  String get themeUnlocked => 'Theme Unlocked';

  @override
  String get owned => 'OWNED';

  @override
  String get selectTopic => 'Select Topic';

  @override
  String topicDifficulty(String topic) {
    return '$topic Difficulty';
  }

  @override
  String get beginner => 'Beginner';

  @override
  String get intermediate => 'Intermediate';

  @override
  String get advanced => 'Advanced';
}
