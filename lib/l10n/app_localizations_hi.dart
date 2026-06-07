// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'क्विज़ शुरू करें';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get offlineTitle => 'कोई इंटरनेट नहीं';

  @override
  String get offlineDesc =>
      'कृपया अपना कनेक्शन जांचें। आप अभी भी खेल सकते हैं, लेकिन आपकी प्रगति स्थानीय रूप से अतिथि के रूप में सहेजी जाएगी।';

  @override
  String get playAsGuest => 'अतिथि के रूप में खेलें';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get exitTitle => 'QuizAlyx से बाहर निकलें?';

  @override
  String get exitDesc => 'क्या आप वाकई गेम छोड़ना चाहते हैं?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get exit => 'बाहर निकलें';

  @override
  String get dailyRewardTitle => 'दैनिक इनाम';

  @override
  String get dailyRewardDesc =>
      'आज लॉग इन करने के लिए आपने 5 सिक्के अर्जित किए!';

  @override
  String get plus5Coins => '+5 सिक्के';

  @override
  String get collect => 'प्राप्त करें';

  @override
  String currentStreak(int days) {
    return 'वर्तमान स्ट्रीक: $days दिन!';
  }

  @override
  String get guestPlayer => 'अतिथि खिलाड़ी';

  @override
  String get notLoggedIn => 'लॉग इन नहीं है';

  @override
  String get myAccount => 'मेरा खाता';

  @override
  String get myStatistics => 'मेरे आँकड़े';

  @override
  String get loginSignup => 'लॉग इन / साइन अप';

  @override
  String get logOut => 'लॉग आउट';

  @override
  String get appSlogan => 'अपने ज्ञान को चुनौती दें';

  @override
  String get missionCompleted => 'मिशन पूरा हुआ!';

  @override
  String get leaderboards => 'लीडरबोर्ड';

  @override
  String get leaderboardsOfflineDesc =>
      'वैश्विक स्कोर को सिंक करने के लिए लीडरबोर्ड को इंटरनेट कनेक्शन की आवश्यकता होती है।';

  @override
  String get unexpectedError => 'एक अप्रत्याशित त्रुटि हुई।';

  @override
  String get noOnePlayedYet => 'अभी तक किसी ने नहीं खेला है!';

  @override
  String get beTheFirstToPlay =>
      'अभी एक क्विज़ हल करें और सूची में आने वाले पहले व्यक्ति बनें।';

  @override
  String get topPlayers => 'शीर्ष खिलाड़ी';

  @override
  String get challengeThem => 'अपनी जगह का दावा करने के लिए उन्हें चुनौती दें!';

  @override
  String get pts => 'अंक';

  @override
  String get signInWithGoogle => 'Google के साथ साइन इन करें';

  @override
  String get continueAsGuest => 'अतिथि के रूप में जारी रखें';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins सिक्के!';
  }

  @override
  String get mission_global_title => 'प्रश्नों का मास्टर';

  @override
  String get mission_global_desc => 'कुल X प्रश्न हल करें';

  @override
  String get mission_title_Math => 'गणित';

  @override
  String get mission_desc_Math => 'गणित के प्रश्न हल करें';

  @override
  String get mission_title_Physics => 'भौतिकी';

  @override
  String get mission_desc_Physics => 'भौतिकी के प्रश्न हल करें';

  @override
  String get mission_title_Chemistry => 'रसायन विज्ञान';

  @override
  String get mission_desc_Chemistry => 'रसायन विज्ञान के प्रश्न हल करें';

  @override
  String get mission_title_Biology => 'जीव विज्ञान';

  @override
  String get mission_desc_Biology => 'जीव विज्ञान के प्रश्न हल करें';

  @override
  String get mission_title_History => 'इतिहास';

  @override
  String get mission_desc_History => 'इतिहास के प्रश्न हल करें';

  @override
  String get mission_title_Geography => 'भूगोल';

  @override
  String get mission_desc_Geography => 'भूगोल के प्रश्न हल करें';

  @override
  String get mission_title_Literature => 'साहित्य';

  @override
  String get mission_desc_Literature => 'साहित्य के प्रश्न हल करें';

  @override
  String get mission_title_Art => 'कला';

  @override
  String get mission_desc_Art => 'कला के प्रश्न हल करें';

  @override
  String get mission_title_Music => 'संगीत';

  @override
  String get mission_desc_Music => 'संगीत के प्रश्न हल करें';

  @override
  String get mission_title_Sports => 'खेल';

  @override
  String get mission_desc_Sports => 'खेल के प्रश्न हल करें';

  @override
  String get mission_title_Technology => 'प्रौद्योगिकी';

  @override
  String get mission_desc_Technology => 'प्रौद्योगिकी के प्रश्न हल करें';

  @override
  String get mission_title_Software => 'सॉफ्टवेयर';

  @override
  String get mission_desc_Software => 'सॉफ्टवेयर के प्रश्न हल करें';

  @override
  String get mission_title_Mechanic => 'यांत्रिकी';

  @override
  String get mission_desc_Mechanic => 'यांत्रिकी के प्रश्न हल करें';

  @override
  String get mission_title_Religion => 'धर्म';

  @override
  String get mission_desc_Religion => 'धर्म के प्रश्न हल करें';

  @override
  String get careerAchievements => 'कैरियर और उपलब्धियां';

  @override
  String get totalAchievements => 'कुल उपलब्धियां';

  @override
  String get maxLevel => 'अधिकतम';

  @override
  String get completed => 'पूरा हुआ';

  @override
  String levelProgress(int current, int total) {
    return 'स्तर $current / $total';
  }

  @override
  String get selectGameMode => 'गेम मोड चुनें';

  @override
  String get modeClassic => 'क्लासिक';

  @override
  String get modeClassicDesc => 'निश्चित प्रश्न, अपना समय लें';

  @override
  String get modeTimed => 'समयबद्ध';

  @override
  String get modeTimedDesc => 'समय के खिलाफ दौड़';

  @override
  String get modeEndless => 'अंतहीन';

  @override
  String get modeEndlessDesc => 'जितने हो सके उतने उत्तर दें';

  @override
  String get defaultPlayerName => 'QuizAlyx खिलाड़ी';

  @override
  String get editProfileName => 'प्रोफ़ाइल नाम बदलें';

  @override
  String get enterNewName => 'अपना नया नाम दर्ज करें';

  @override
  String get save => 'सहेजें';

  @override
  String get nameChangeLimitTitle => 'नाम बदलने की सीमा';

  @override
  String get nameChangeLimitDesc =>
      'आप 14 दिनों में केवल 2 बार अपना नाम बदल सकते हैं। कृपया बाद में पुनः प्रयास करें।';

  @override
  String get ok => 'ठीक है';

  @override
  String get unknownDate => 'अज्ञात';

  @override
  String get accountStatus => 'खाता स्थिति';

  @override
  String get verified => 'सत्यापित';

  @override
  String get guestAccount => 'अतिथि खाता';

  @override
  String get joinedDate => 'शामिल होने की तिथि';

  @override
  String get membership => 'सदस्यता';

  @override
  String get freeTier => 'निःशुल्क';

  @override
  String daysCount(int count) {
    return '$count दिन';
  }

  @override
  String get dataLoadError => 'डेटा लोड नहीं किया जा सका।';

  @override
  String get totalScore => 'कुल स्कोर';

  @override
  String get quizzesPlayed => 'खेले गए क्विज़';

  @override
  String get accuracyRate => 'सटीकता दर';

  @override
  String get dailyStreak => 'दैनिक स्ट्रीक';

  @override
  String get enterPlayerNameError => 'कृपया एक शानदार खिलाड़ी नाम दर्ज करें!';

  @override
  String get welcomeToQuizAlyx => 'QuizAlyx में आपका स्वागत है!';

  @override
  String get chooseAvatarName => 'अपना खिलाड़ी अवतार और नाम चुनें।';

  @override
  String get enterPlayerNameHint => 'खिलाड़ी का नाम दर्ज करें';

  @override
  String get startJourney => 'यात्रा शुरू करें';

  @override
  String get quitQuizTitle => 'क्विज़ छोड़ें?';

  @override
  String get quitQuizDesc =>
      'आपकी प्रगति खो जाएगी। क्या आप वाकई होम पर वापस जाना चाहते हैं?';

  @override
  String get quit => 'छोड़ें';

  @override
  String get no5050JokerWarning => 'आपके पास कोई 50/50 जोकर नहीं है!';

  @override
  String get noTimeFreezeWarning => 'आपके पास कोई टाइम फ़्रीज़ नहीं है!';

  @override
  String get quiz => 'क्विज़';

  @override
  String timeSeconds(int seconds) {
    return 'समय: $seconds सेकंड';
  }

  @override
  String questionCounter(int current, int total) {
    return 'प्रश्न $current / $total';
  }

  @override
  String get quizCompleted => 'क्विज़ पूरा हुआ!';

  @override
  String get correct => 'सही';

  @override
  String get wrong => 'गलत';

  @override
  String get score => 'स्कोर';

  @override
  String get continueBtn => 'जारी रखें';

  @override
  String get whatsNext => 'आगे क्या?';

  @override
  String get playAgain => 'फिर से खेलें';

  @override
  String get backToHome => 'होम पर वापस जाएँ';

  @override
  String get timesUp => 'समय समाप्त!';

  @override
  String get language => 'भाषा';

  @override
  String get settingsSaved => 'सेटिंग्स सफलतापूर्वक सहेजी गईं!';

  @override
  String get resetHighScoresTitle => 'उच्च स्कोर रीसेट करें?';

  @override
  String get resetHighScoresDesc =>
      'इससे आपके सभी उच्च स्कोर हटा दिए जाएंगे। इस कार्रवाई को पूर्ववत नहीं किया जा सकता।';

  @override
  String get reset => 'रीसेट';

  @override
  String get highScoresResetSuccess => 'उच्च स्कोर सफलतापूर्वक रीसेट किए गए!';

  @override
  String get appearance => 'दिखावट';

  @override
  String get goldTheme => 'गोल्ड थीम';

  @override
  String get premiumGoldLook => 'प्रीमियम गोल्ड लुक';

  @override
  String get unlockInStore => 'स्टोर में अनलॉक करें';

  @override
  String get diamondTheme => 'डायमंड थीम';

  @override
  String get legendaryDiamondLook => 'पौराणिक डायमंड लुक';

  @override
  String get unlockInStore1500 => 'स्टोर में अनलॉक करें (1500 सिक्के)';

  @override
  String get gameplay => 'गेमप्ले';

  @override
  String get numberOfQuestions => 'प्रश्नों की संख्या';

  @override
  String get timedDurationSec => 'समयबद्ध अवधि (सेकंड)';

  @override
  String get endlessDurationSec => 'अंतहीन अवधि (सेकंड)';

  @override
  String get display => 'प्रदर्शन';

  @override
  String get showDifficulty => 'कठिनाई दिखाएं';

  @override
  String get showDifficultyDesc =>
      'प्रत्येक प्रश्न के लिए कठिनाई स्तर प्रदर्शित करें';

  @override
  String get actions => 'कार्रवाइयां';

  @override
  String get saveSettings => 'सेटिंग्स सहेजें';

  @override
  String get resetScores => 'स्कोर रीसेट करें';

  @override
  String get visitStoreToUnlock => 'अनलॉक करने के लिए स्टोर पर जाएँ!';

  @override
  String get storeTitle => 'स्टोर';

  @override
  String specialBundlePurchased(int remaining) {
    return 'विशेष बंडल खरीदा गया! (शेष: $remaining)';
  }

  @override
  String get notEnoughCoins => 'पर्याप्त सिक्के नहीं!';

  @override
  String get exchangeSuccessful => 'विनिमय सफल!';

  @override
  String get notEnoughPoints => 'पर्याप्त अंक नहीं!';

  @override
  String get themeUnlockedSettings =>
      'थीम अनलॉक की गई! इसे सेटिंग्स में सक्षम करें।';

  @override
  String itemPurchased(String itemName) {
    return '$itemName खरीदा गया!';
  }

  @override
  String get currencyExchange => 'मुद्रा विनिमय';

  @override
  String get shopItems => 'स्टोर के आइटम';

  @override
  String get limitedOffer => 'सीमित प्रस्ताव';

  @override
  String endsInDays(int days) {
    return '$days दिनों में समाप्त';
  }

  @override
  String get megaBoosterPack => 'मेगा बूस्टर पैक';

  @override
  String get boosterPackDesc => '1x 50/50 जोकर + 1x टाइम फ़्रीज़';

  @override
  String remainingLimit(int current, int max) {
    return 'शेष: $current / $max';
  }

  @override
  String get coinsText => 'सिक्के';

  @override
  String get convertBtn => 'बदलें';

  @override
  String get joker5050 => '50/50 जोकर';

  @override
  String get joker5050Desc => '2 गलत विकल्प हटाता है';

  @override
  String get timeFreeze => 'टाइम फ़्रीज़';

  @override
  String get timeFreezeDesc => 'टाइमर को 10s के लिए रोकता है';

  @override
  String get premiumTheme => 'प्रीमियम थीम';

  @override
  String get unlockGoldTheme => 'गोल्ड थीम अनलॉक करें';

  @override
  String get unlockDiamondInterface => 'डायमंड इंटरफ़ेस अनलॉक करें';

  @override
  String get themeUnlocked => 'थीम अनलॉक की गई';

  @override
  String get owned => 'स्वामित्व';

  @override
  String get selectTopic => 'विषय चुनें';

  @override
  String topicDifficulty(String topic) {
    return '$topic कठिनाई';
  }

  @override
  String get beginner => 'शुरुआती';

  @override
  String get intermediate => 'मध्यम';

  @override
  String get advanced => 'उन्नत';
}
