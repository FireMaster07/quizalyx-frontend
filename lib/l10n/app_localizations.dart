import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'QuizAlyx'**
  String get appTitle;

  /// No description provided for @startQuiz.
  ///
  /// In en, this message translates to:
  /// **'START QUIZ'**
  String get startQuiz;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @offlineTitle.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get offlineTitle;

  /// No description provided for @offlineDesc.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection. You can still play offline, but your progress will be saved locally as a guest.'**
  String get offlineDesc;

  /// No description provided for @playAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Play as Guest'**
  String get playAsGuest;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @exitTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit QuizAlyx?'**
  String get exitTitle;

  /// No description provided for @exitDesc.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to leave the game?'**
  String get exitDesc;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @dailyRewardTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Reward'**
  String get dailyRewardTitle;

  /// No description provided for @dailyRewardDesc.
  ///
  /// In en, this message translates to:
  /// **'You earned 5 coins for logging in today!'**
  String get dailyRewardDesc;

  /// No description provided for @plus5Coins.
  ///
  /// In en, this message translates to:
  /// **'+5 COINS'**
  String get plus5Coins;

  /// No description provided for @collect.
  ///
  /// In en, this message translates to:
  /// **'Collect'**
  String get collect;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current streak: {days} days!'**
  String currentStreak(int days);

  /// No description provided for @guestPlayer.
  ///
  /// In en, this message translates to:
  /// **'Guest Player'**
  String get guestPlayer;

  /// No description provided for @notLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Not logged in'**
  String get notLoggedIn;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @myStatistics.
  ///
  /// In en, this message translates to:
  /// **'My Statistics'**
  String get myStatistics;

  /// No description provided for @loginSignup.
  ///
  /// In en, this message translates to:
  /// **'Log In / Sign Up'**
  String get loginSignup;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @appSlogan.
  ///
  /// In en, this message translates to:
  /// **'Challenge Your Knowledge'**
  String get appSlogan;

  /// No description provided for @missionCompleted.
  ///
  /// In en, this message translates to:
  /// **'MISSION COMPLETED!'**
  String get missionCompleted;

  /// No description provided for @leaderboards.
  ///
  /// In en, this message translates to:
  /// **'Leaderboards'**
  String get leaderboards;

  /// No description provided for @leaderboardsOfflineDesc.
  ///
  /// In en, this message translates to:
  /// **'Leaderboards require an active internet connection to sync global scores.'**
  String get leaderboardsOfflineDesc;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get unexpectedError;

  /// No description provided for @noOnePlayedYet.
  ///
  /// In en, this message translates to:
  /// **'No one has played yet!'**
  String get noOnePlayedYet;

  /// No description provided for @beTheFirstToPlay.
  ///
  /// In en, this message translates to:
  /// **'Solve a quiz now and be the first to enter the list.'**
  String get beTheFirstToPlay;

  /// No description provided for @topPlayers.
  ///
  /// In en, this message translates to:
  /// **'Top Players'**
  String get topPlayers;

  /// No description provided for @challengeThem.
  ///
  /// In en, this message translates to:
  /// **'Challenge them to claim your spot!'**
  String get challengeThem;

  /// No description provided for @pts.
  ///
  /// In en, this message translates to:
  /// **'pts'**
  String get pts;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get continueAsGuest;

  /// No description provided for @plusCoinsEarned.
  ///
  /// In en, this message translates to:
  /// **'+{coins} Coins!'**
  String plusCoinsEarned(int coins);

  /// No description provided for @mission_global_title.
  ///
  /// In en, this message translates to:
  /// **'Question Master'**
  String get mission_global_title;

  /// No description provided for @mission_global_desc.
  ///
  /// In en, this message translates to:
  /// **'Solve a total of X questions'**
  String get mission_global_desc;

  /// No description provided for @mission_title_Math.
  ///
  /// In en, this message translates to:
  /// **'Math'**
  String get mission_title_Math;

  /// No description provided for @mission_desc_Math.
  ///
  /// In en, this message translates to:
  /// **'Solve Math questions'**
  String get mission_desc_Math;

  /// No description provided for @mission_title_Physics.
  ///
  /// In en, this message translates to:
  /// **'Physics'**
  String get mission_title_Physics;

  /// No description provided for @mission_desc_Physics.
  ///
  /// In en, this message translates to:
  /// **'Solve Physics questions'**
  String get mission_desc_Physics;

  /// No description provided for @mission_title_Chemistry.
  ///
  /// In en, this message translates to:
  /// **'Chemistry'**
  String get mission_title_Chemistry;

  /// No description provided for @mission_desc_Chemistry.
  ///
  /// In en, this message translates to:
  /// **'Solve Chemistry questions'**
  String get mission_desc_Chemistry;

  /// No description provided for @mission_title_Biology.
  ///
  /// In en, this message translates to:
  /// **'Biology'**
  String get mission_title_Biology;

  /// No description provided for @mission_desc_Biology.
  ///
  /// In en, this message translates to:
  /// **'Solve Biology questions'**
  String get mission_desc_Biology;

  /// No description provided for @mission_title_History.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get mission_title_History;

  /// No description provided for @mission_desc_History.
  ///
  /// In en, this message translates to:
  /// **'Solve History questions'**
  String get mission_desc_History;

  /// No description provided for @mission_title_Geography.
  ///
  /// In en, this message translates to:
  /// **'Geography'**
  String get mission_title_Geography;

  /// No description provided for @mission_desc_Geography.
  ///
  /// In en, this message translates to:
  /// **'Solve Geography questions'**
  String get mission_desc_Geography;

  /// No description provided for @mission_title_Literature.
  ///
  /// In en, this message translates to:
  /// **'Literature'**
  String get mission_title_Literature;

  /// No description provided for @mission_desc_Literature.
  ///
  /// In en, this message translates to:
  /// **'Solve Literature questions'**
  String get mission_desc_Literature;

  /// No description provided for @mission_title_Art.
  ///
  /// In en, this message translates to:
  /// **'Art'**
  String get mission_title_Art;

  /// No description provided for @mission_desc_Art.
  ///
  /// In en, this message translates to:
  /// **'Solve Art questions'**
  String get mission_desc_Art;

  /// No description provided for @mission_title_Music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get mission_title_Music;

  /// No description provided for @mission_desc_Music.
  ///
  /// In en, this message translates to:
  /// **'Solve Music questions'**
  String get mission_desc_Music;

  /// No description provided for @mission_title_Sports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get mission_title_Sports;

  /// No description provided for @mission_desc_Sports.
  ///
  /// In en, this message translates to:
  /// **'Solve Sports questions'**
  String get mission_desc_Sports;

  /// No description provided for @mission_title_Technology.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get mission_title_Technology;

  /// No description provided for @mission_desc_Technology.
  ///
  /// In en, this message translates to:
  /// **'Solve Technology questions'**
  String get mission_desc_Technology;

  /// No description provided for @mission_title_Software.
  ///
  /// In en, this message translates to:
  /// **'Software'**
  String get mission_title_Software;

  /// No description provided for @mission_desc_Software.
  ///
  /// In en, this message translates to:
  /// **'Solve Software questions'**
  String get mission_desc_Software;

  /// No description provided for @mission_title_Mechanic.
  ///
  /// In en, this message translates to:
  /// **'Mechanic'**
  String get mission_title_Mechanic;

  /// No description provided for @mission_desc_Mechanic.
  ///
  /// In en, this message translates to:
  /// **'Solve Mechanic questions'**
  String get mission_desc_Mechanic;

  /// No description provided for @mission_title_Religion.
  ///
  /// In en, this message translates to:
  /// **'Religion'**
  String get mission_title_Religion;

  /// No description provided for @mission_desc_Religion.
  ///
  /// In en, this message translates to:
  /// **'Solve Religion questions'**
  String get mission_desc_Religion;

  /// No description provided for @careerAchievements.
  ///
  /// In en, this message translates to:
  /// **'Career & Achievements'**
  String get careerAchievements;

  /// No description provided for @totalAchievements.
  ///
  /// In en, this message translates to:
  /// **'Total Achievements'**
  String get totalAchievements;

  /// No description provided for @maxLevel.
  ///
  /// In en, this message translates to:
  /// **'MAX'**
  String get maxLevel;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @levelProgress.
  ///
  /// In en, this message translates to:
  /// **'Level {current} / {total}'**
  String levelProgress(int current, int total);

  /// No description provided for @selectGameMode.
  ///
  /// In en, this message translates to:
  /// **'Select Game Mode'**
  String get selectGameMode;

  /// No description provided for @modeClassic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get modeClassic;

  /// No description provided for @modeClassicDesc.
  ///
  /// In en, this message translates to:
  /// **'Fixed questions, take your time'**
  String get modeClassicDesc;

  /// No description provided for @modeTimed.
  ///
  /// In en, this message translates to:
  /// **'Timed'**
  String get modeTimed;

  /// No description provided for @modeTimedDesc.
  ///
  /// In en, this message translates to:
  /// **'Race against the clock'**
  String get modeTimedDesc;

  /// No description provided for @modeEndless.
  ///
  /// In en, this message translates to:
  /// **'Endless'**
  String get modeEndless;

  /// No description provided for @modeEndlessDesc.
  ///
  /// In en, this message translates to:
  /// **'Answer as many as you can'**
  String get modeEndlessDesc;

  /// No description provided for @defaultPlayerName.
  ///
  /// In en, this message translates to:
  /// **'QuizAlyx Player'**
  String get defaultPlayerName;

  /// No description provided for @editProfileName.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile Name'**
  String get editProfileName;

  /// No description provided for @enterNewName.
  ///
  /// In en, this message translates to:
  /// **'Enter your new name'**
  String get enterNewName;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @nameChangeLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Name Change Limit'**
  String get nameChangeLimitTitle;

  /// No description provided for @nameChangeLimitDesc.
  ///
  /// In en, this message translates to:
  /// **'You can only change your name 2 times every 14 days. Please try again later.'**
  String get nameChangeLimitDesc;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @unknownDate.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownDate;

  /// No description provided for @accountStatus.
  ///
  /// In en, this message translates to:
  /// **'Account Status'**
  String get accountStatus;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @guestAccount.
  ///
  /// In en, this message translates to:
  /// **'Guest Account'**
  String get guestAccount;

  /// No description provided for @joinedDate.
  ///
  /// In en, this message translates to:
  /// **'Joined Date'**
  String get joinedDate;

  /// No description provided for @membership.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get membership;

  /// No description provided for @freeTier.
  ///
  /// In en, this message translates to:
  /// **'Free Tier'**
  String get freeTier;

  /// No description provided for @daysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Days'**
  String daysCount(int count);

  /// No description provided for @dataLoadError.
  ///
  /// In en, this message translates to:
  /// **'Data could not be loaded.'**
  String get dataLoadError;

  /// No description provided for @totalScore.
  ///
  /// In en, this message translates to:
  /// **'Total Score'**
  String get totalScore;

  /// No description provided for @quizzesPlayed.
  ///
  /// In en, this message translates to:
  /// **'Quizzes Played'**
  String get quizzesPlayed;

  /// No description provided for @accuracyRate.
  ///
  /// In en, this message translates to:
  /// **'Accuracy Rate'**
  String get accuracyRate;

  /// No description provided for @dailyStreak.
  ///
  /// In en, this message translates to:
  /// **'Daily Streak'**
  String get dailyStreak;

  /// No description provided for @enterPlayerNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a cool player name!'**
  String get enterPlayerNameError;

  /// No description provided for @welcomeToQuizAlyx.
  ///
  /// In en, this message translates to:
  /// **'Welcome to QuizAlyx!'**
  String get welcomeToQuizAlyx;

  /// No description provided for @chooseAvatarName.
  ///
  /// In en, this message translates to:
  /// **'Choose your player avatar and name.'**
  String get chooseAvatarName;

  /// No description provided for @enterPlayerNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Player Name'**
  String get enterPlayerNameHint;

  /// No description provided for @startJourney.
  ///
  /// In en, this message translates to:
  /// **'Start Journey'**
  String get startJourney;

  /// No description provided for @quitQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Quit Quiz?'**
  String get quitQuizTitle;

  /// No description provided for @quitQuizDesc.
  ///
  /// In en, this message translates to:
  /// **'Your progress will be lost. Are you sure you want to go back to Home?'**
  String get quitQuizDesc;

  /// No description provided for @quit.
  ///
  /// In en, this message translates to:
  /// **'Quit'**
  String get quit;

  /// No description provided for @no5050JokerWarning.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any 50/50 Joker!'**
  String get no5050JokerWarning;

  /// No description provided for @noTimeFreezeWarning.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any Time Freeze!'**
  String get noTimeFreezeWarning;

  /// No description provided for @quiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quiz;

  /// No description provided for @timeSeconds.
  ///
  /// In en, this message translates to:
  /// **'Time: {seconds} s'**
  String timeSeconds(int seconds);

  /// No description provided for @questionCounter.
  ///
  /// In en, this message translates to:
  /// **'Question {current} / {total}'**
  String questionCounter(int current, int total);

  /// No description provided for @quizCompleted.
  ///
  /// In en, this message translates to:
  /// **'Quiz Completed!'**
  String get quizCompleted;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correct;

  /// No description provided for @wrong.
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get wrong;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @whatsNext.
  ///
  /// In en, this message translates to:
  /// **'What\'s Next?'**
  String get whatsNext;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @timesUp.
  ///
  /// In en, this message translates to:
  /// **'Time\'s Up!'**
  String get timesUp;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully!'**
  String get settingsSaved;

  /// No description provided for @resetHighScoresTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset High Scores?'**
  String get resetHighScoresTitle;

  /// No description provided for @resetHighScoresDesc.
  ///
  /// In en, this message translates to:
  /// **'This will delete all your high scores. This action cannot be undone.'**
  String get resetHighScoresDesc;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @highScoresResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'High scores reset successfully!'**
  String get highScoresResetSuccess;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @goldTheme.
  ///
  /// In en, this message translates to:
  /// **'Gold Theme'**
  String get goldTheme;

  /// No description provided for @premiumGoldLook.
  ///
  /// In en, this message translates to:
  /// **'Premium gold look'**
  String get premiumGoldLook;

  /// No description provided for @unlockInStore.
  ///
  /// In en, this message translates to:
  /// **'Unlock in Store'**
  String get unlockInStore;

  /// No description provided for @diamondTheme.
  ///
  /// In en, this message translates to:
  /// **'Diamond Theme'**
  String get diamondTheme;

  /// No description provided for @legendaryDiamondLook.
  ///
  /// In en, this message translates to:
  /// **'Legendary diamond look'**
  String get legendaryDiamondLook;

  /// No description provided for @unlockInStore1500.
  ///
  /// In en, this message translates to:
  /// **'Unlock in Store (1500 Coins)'**
  String get unlockInStore1500;

  /// No description provided for @gameplay.
  ///
  /// In en, this message translates to:
  /// **'Gameplay'**
  String get gameplay;

  /// No description provided for @numberOfQuestions.
  ///
  /// In en, this message translates to:
  /// **'Number of Questions'**
  String get numberOfQuestions;

  /// No description provided for @timedDurationSec.
  ///
  /// In en, this message translates to:
  /// **'Timed duration (sec)'**
  String get timedDurationSec;

  /// No description provided for @endlessDurationSec.
  ///
  /// In en, this message translates to:
  /// **'Endless Duration (sec)'**
  String get endlessDurationSec;

  /// No description provided for @display.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get display;

  /// No description provided for @showDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Show Difficulty'**
  String get showDifficulty;

  /// No description provided for @showDifficultyDesc.
  ///
  /// In en, this message translates to:
  /// **'Display difficulty level for each question'**
  String get showDifficultyDesc;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @saveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get saveSettings;

  /// No description provided for @resetScores.
  ///
  /// In en, this message translates to:
  /// **'Reset Scores'**
  String get resetScores;

  /// No description provided for @visitStoreToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Visit the Store to unlock!'**
  String get visitStoreToUnlock;

  /// No description provided for @storeTitle.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get storeTitle;

  /// No description provided for @specialBundlePurchased.
  ///
  /// In en, this message translates to:
  /// **'Special Bundle Purchased! (Remaining: {remaining})'**
  String specialBundlePurchased(int remaining);

  /// No description provided for @notEnoughCoins.
  ///
  /// In en, this message translates to:
  /// **'Not enough coins!'**
  String get notEnoughCoins;

  /// No description provided for @exchangeSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Exchange successful!'**
  String get exchangeSuccessful;

  /// No description provided for @notEnoughPoints.
  ///
  /// In en, this message translates to:
  /// **'Not enough points!'**
  String get notEnoughPoints;

  /// No description provided for @themeUnlockedSettings.
  ///
  /// In en, this message translates to:
  /// **'Theme Unlocked! Enable it in Settings.'**
  String get themeUnlockedSettings;

  /// No description provided for @itemPurchased.
  ///
  /// In en, this message translates to:
  /// **'{itemName} purchased!'**
  String itemPurchased(String itemName);

  /// No description provided for @currencyExchange.
  ///
  /// In en, this message translates to:
  /// **'CURRENCY EXCHANGE'**
  String get currencyExchange;

  /// No description provided for @shopItems.
  ///
  /// In en, this message translates to:
  /// **'SHOP ITEMS'**
  String get shopItems;

  /// No description provided for @limitedOffer.
  ///
  /// In en, this message translates to:
  /// **'LIMITED OFFER'**
  String get limitedOffer;

  /// No description provided for @endsInDays.
  ///
  /// In en, this message translates to:
  /// **'Ends in {days} days'**
  String endsInDays(int days);

  /// No description provided for @megaBoosterPack.
  ///
  /// In en, this message translates to:
  /// **'Mega Booster Pack'**
  String get megaBoosterPack;

  /// No description provided for @boosterPackDesc.
  ///
  /// In en, this message translates to:
  /// **'1x 50/50 Joker + 1x Time Freeze'**
  String get boosterPackDesc;

  /// No description provided for @remainingLimit.
  ///
  /// In en, this message translates to:
  /// **'Remaining: {current} / {max}'**
  String remainingLimit(int current, int max);

  /// No description provided for @coinsText.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coinsText;

  /// No description provided for @convertBtn.
  ///
  /// In en, this message translates to:
  /// **'Convert'**
  String get convertBtn;

  /// No description provided for @joker5050.
  ///
  /// In en, this message translates to:
  /// **'50/50 Joker'**
  String get joker5050;

  /// No description provided for @joker5050Desc.
  ///
  /// In en, this message translates to:
  /// **'Removes 2 wrong options'**
  String get joker5050Desc;

  /// No description provided for @timeFreeze.
  ///
  /// In en, this message translates to:
  /// **'Time Freeze'**
  String get timeFreeze;

  /// No description provided for @timeFreezeDesc.
  ///
  /// In en, this message translates to:
  /// **'Stops timer for 10s'**
  String get timeFreezeDesc;

  /// No description provided for @premiumTheme.
  ///
  /// In en, this message translates to:
  /// **'Premium Theme'**
  String get premiumTheme;

  /// No description provided for @unlockGoldTheme.
  ///
  /// In en, this message translates to:
  /// **'Unlock Gold Theme'**
  String get unlockGoldTheme;

  /// No description provided for @unlockDiamondInterface.
  ///
  /// In en, this message translates to:
  /// **'Unlock Diamond Interface'**
  String get unlockDiamondInterface;

  /// No description provided for @themeUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Theme Unlocked'**
  String get themeUnlocked;

  /// No description provided for @owned.
  ///
  /// In en, this message translates to:
  /// **'OWNED'**
  String get owned;

  /// No description provided for @selectTopic.
  ///
  /// In en, this message translates to:
  /// **'Select Topic'**
  String get selectTopic;

  /// No description provided for @topicDifficulty.
  ///
  /// In en, this message translates to:
  /// **'{topic} Difficulty'**
  String topicDifficulty(String topic);

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @dangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account & Wipe Data'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your profile and cloud/local records'**
  String get deleteAccountSubtitle;

  /// No description provided for @deleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account & Data?'**
  String get deleteAccountConfirmTitle;

  /// No description provided for @deleteAccountConfirmDesc.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your profile, high scores, inventory, and leaderboard data. This action CANNOT be undone.'**
  String get deleteAccountConfirmDesc;

  /// No description provided for @deletePermanently.
  ///
  /// In en, this message translates to:
  /// **'Delete Permanently'**
  String get deletePermanently;

  /// No description provided for @accountDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account and all associated data successfully wiped!'**
  String get accountDeletedSuccess;

  /// No description provided for @deleteAccountError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}. You might need to re-authenticate to delete your account.'**
  String deleteAccountError(String error);

  /// No description provided for @securityCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Security Check'**
  String get securityCheckTitle;

  /// No description provided for @securityCheckDesc.
  ///
  /// In en, this message translates to:
  /// **'Deleting your account is a sensitive operation. For your security, please log out and log in again before trying to delete your account.'**
  String get securityCheckDesc;

  /// No description provided for @logOutAndReLogin.
  ///
  /// In en, this message translates to:
  /// **'Log Out & Re-Login'**
  String get logOutAndReLogin;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'el',
    'en',
    'es',
    'fa',
    'fr',
    'hi',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
