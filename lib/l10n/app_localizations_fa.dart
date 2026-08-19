// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'شروع آزمون';

  @override
  String get settings => 'تنظیمات';

  @override
  String get offlineTitle => 'بدون اینترنت';

  @override
  String get offlineDesc =>
      'لطفاً اتصال اینترنت خود را بررسی کنید. شما هنوز می‌توانید آفلاین بازی کنید، اما پیشرفت شما به صورت محلی به عنوان مهمان ذخیره می‌شود.';

  @override
  String get playAsGuest => 'بازی به عنوان مهمان';

  @override
  String get retry => 'تلاش مجدد';

  @override
  String get exitTitle => 'خروج از QuizAlyx؟';

  @override
  String get exitDesc => 'آیا مطمئن هستید که می‌خواهید از بازی خارج شوید؟';

  @override
  String get cancel => 'لغو';

  @override
  String get exit => 'خروج';

  @override
  String get dailyRewardTitle => 'جایزه روزانه';

  @override
  String get dailyRewardDesc => 'شما 5 سکه برای ورود امروز خود دریافت کردید!';

  @override
  String get plus5Coins => '+5 سکه';

  @override
  String get collect => 'دریافت';

  @override
  String currentStreak(int days) {
    return 'روند فعلی: $days روز!';
  }

  @override
  String get guestPlayer => 'بازیکن مهمان';

  @override
  String get notLoggedIn => 'وارد نشده‌اید';

  @override
  String get myAccount => 'حساب من';

  @override
  String get myStatistics => 'آمار من';

  @override
  String get loginSignup => 'ورود / ثبت‌نام';

  @override
  String get logOut => 'خروج از حساب';

  @override
  String get appSlogan => 'دانش خود را به چالش بکشید';

  @override
  String get missionCompleted => 'ماموریت انجام شد!';

  @override
  String get leaderboards => 'جدول امتیازات';

  @override
  String get leaderboardsOfflineDesc =>
      'برای همگام‌سازی امتیازات جهانی به اینترنت نیاز است.';

  @override
  String get unexpectedError => 'یک خطای غیرمنتظره رخ داد.';

  @override
  String get noOnePlayedYet => 'هنوز کسی بازی نکرده است!';

  @override
  String get beTheFirstToPlay =>
      'همین الان یک آزمون حل کن و اولین نفر در لیست باش.';

  @override
  String get topPlayers => 'بهترین بازیکنان';

  @override
  String get challengeThem => 'آنها را به چالش بکش تا جایگاهت را بگیری!';

  @override
  String get pts => 'امتیاز';

  @override
  String get signInWithGoogle => 'ورود با گوگل';

  @override
  String get continueAsGuest => 'ادامه به عنوان مهمان';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins سکه!';
  }

  @override
  String get mission_global_title => 'استاد سوالات';

  @override
  String get mission_global_desc => 'در مجموع X سوال را حل کنید';

  @override
  String get mission_title_Math => 'ریاضیات';

  @override
  String get mission_desc_Math => 'سوالات ریاضی را حل کنید';

  @override
  String get mission_title_Physics => 'فیزیک';

  @override
  String get mission_desc_Physics => 'سوالات فیزیک را حل کنید';

  @override
  String get mission_title_Chemistry => 'شیمی';

  @override
  String get mission_desc_Chemistry => 'سوالات شیمی را حل کنید';

  @override
  String get mission_title_Biology => 'زیست‌شناسی';

  @override
  String get mission_desc_Biology => 'سوالات زیست‌شناسی را حل کنید';

  @override
  String get mission_title_History => 'تاریخ';

  @override
  String get mission_desc_History => 'سوالات تاریخ را حل کنید';

  @override
  String get mission_title_Geography => 'جغرافیا';

  @override
  String get mission_desc_Geography => 'سوالات جغرافیا را حل کنید';

  @override
  String get mission_title_Literature => 'ادبیات';

  @override
  String get mission_desc_Literature => 'سوالات ادبیات را حل کنید';

  @override
  String get mission_title_Art => 'هنر';

  @override
  String get mission_desc_Art => 'سوالات هنر را حل کنید';

  @override
  String get mission_title_Music => 'موسیقی';

  @override
  String get mission_desc_Music => 'سوالات موسیقی را حل کنید';

  @override
  String get mission_title_Sports => 'ورزش';

  @override
  String get mission_desc_Sports => 'سوالات ورزشی را حل کنید';

  @override
  String get mission_title_Technology => 'فناوری';

  @override
  String get mission_desc_Technology => 'سوالات فناوری را حل کنید';

  @override
  String get mission_title_Software => 'نرم‌افزار';

  @override
  String get mission_desc_Software => 'سوالات نرم‌افزار را حل کنید';

  @override
  String get mission_title_Mechanic => 'مکانیک';

  @override
  String get mission_desc_Mechanic => 'سوالات مکانیک را حل کنید';

  @override
  String get mission_title_Religion => 'دین';

  @override
  String get mission_desc_Religion => 'سوالات دینی را حل کنید';

  @override
  String get careerAchievements => 'حرفه و دستاوردها';

  @override
  String get totalAchievements => 'کل دستاوردها';

  @override
  String get maxLevel => 'حداکثر';

  @override
  String get completed => 'تکمیل شد';

  @override
  String levelProgress(int current, int total) {
    return 'سطح $current / $total';
  }

  @override
  String get selectGameMode => 'انتخاب حالت بازی';

  @override
  String get modeClassic => 'کلاسیک';

  @override
  String get modeClassicDesc => 'سوالات ثابت، عجله نکنید';

  @override
  String get modeTimed => 'زمان‌دار';

  @override
  String get modeTimedDesc => 'مسابقه با زمان';

  @override
  String get modeEndless => 'بی‌پایان';

  @override
  String get modeEndlessDesc => 'تا می‌توانی پاسخ بده';

  @override
  String get defaultPlayerName => 'بازیکن QuizAlyx';

  @override
  String get editProfileName => 'ویرایش نام پروفایل';

  @override
  String get enterNewName => 'نام جدید خود را وارد کنید';

  @override
  String get save => 'ذخیره';

  @override
  String get nameChangeLimitTitle => 'محدودیت تغییر نام';

  @override
  String get nameChangeLimitDesc =>
      'شما فقط ۲ بار در هر ۱۴ روز می‌توانید نام خود را تغییر دهید. لطفاً بعداً دوباره تلاش کنید.';

  @override
  String get ok => 'باشه';

  @override
  String get unknownDate => 'نامشخص';

  @override
  String get accountStatus => 'وضعیت حساب';

  @override
  String get verified => 'تأیید شده';

  @override
  String get guestAccount => 'حساب مهمان';

  @override
  String get joinedDate => 'تاریخ عضویت';

  @override
  String get membership => 'عضویت';

  @override
  String get freeTier => 'رایگان';

  @override
  String daysCount(int count) {
    return '$count روز';
  }

  @override
  String get dataLoadError => 'داده‌ها بارگیری نشد.';

  @override
  String get totalScore => 'امتیاز کل';

  @override
  String get quizzesPlayed => 'آزمون‌های انجام شده';

  @override
  String get accuracyRate => 'نرخ دقت';

  @override
  String get dailyStreak => 'روند روزانه';

  @override
  String get enterPlayerNameError => 'لطفاً یک نام کاربری جذاب وارد کنید!';

  @override
  String get welcomeToQuizAlyx => 'به QuizAlyx خوش آمدید!';

  @override
  String get chooseAvatarName => 'آواتار و نام بازیکن خود را انتخاب کنید.';

  @override
  String get enterPlayerNameHint => 'نام بازیکن را وارد کنید';

  @override
  String get startJourney => 'شروع ماجراجویی';

  @override
  String get quitQuizTitle => 'خروج از آزمون؟';

  @override
  String get quitQuizDesc =>
      'پیشرفت شما از دست خواهد رفت. مطمئن هستید که می‌خواهید به خانه برگردید؟';

  @override
  String get quit => 'خروج';

  @override
  String get no5050JokerWarning => 'شما هیچ جوکر ۵۰/۵۰ ندارید!';

  @override
  String get noTimeFreezeWarning => 'شما هیچ توقف زمانی ندارید!';

  @override
  String get quiz => 'آزمون';

  @override
  String timeSeconds(int seconds) {
    return 'زمان: $seconds ثانیه';
  }

  @override
  String questionCounter(int current, int total) {
    return 'سوال $current / $total';
  }

  @override
  String get quizCompleted => 'آزمون به پایان رسید!';

  @override
  String get correct => 'درست';

  @override
  String get wrong => 'نادرست';

  @override
  String get score => 'امتیاز';

  @override
  String get continueBtn => 'ادامه';

  @override
  String get whatsNext => 'بعدی چیست؟';

  @override
  String get playAgain => 'دوباره بازی کن';

  @override
  String get backToHome => 'بازگشت به خانه';

  @override
  String get timesUp => 'زمان تمام شد!';

  @override
  String get language => 'زبان';

  @override
  String get settingsSaved => 'تنظیمات با موفقیت ذخیره شد!';

  @override
  String get resetHighScoresTitle => 'بازنشانی رکوردهای بالا؟';

  @override
  String get resetHighScoresDesc =>
      'این کار تمام رکوردهای شما را حذف می‌کند. این عمل قابل بازگشت نیست.';

  @override
  String get reset => 'بازنشانی';

  @override
  String get highScoresResetSuccess => 'رکوردها با موفقیت بازنشانی شدند!';

  @override
  String get appearance => 'ظاهر';

  @override
  String get goldTheme => 'تم طلایی';

  @override
  String get premiumGoldLook => 'ظاهر طلایی پرمیوم';

  @override
  String get unlockInStore => 'باز کردن در فروشگاه';

  @override
  String get diamondTheme => 'تم الماسی';

  @override
  String get legendaryDiamondLook => 'ظاهر افسانه‌ای الماسی';

  @override
  String get unlockInStore1500 => 'باز کردن در فروشگاه (۱۵۰۰ سکه)';

  @override
  String get gameplay => 'گیم‌پلی';

  @override
  String get numberOfQuestions => 'تعداد سوالات';

  @override
  String get timedDurationSec => 'مدت زمان‌دار (ثانیه)';

  @override
  String get endlessDurationSec => 'مدت بی‌پایان (ثانیه)';

  @override
  String get display => 'نمایش';

  @override
  String get showDifficulty => 'نمایش درجه سختی';

  @override
  String get showDifficultyDesc => 'نمایش سطح دشواری برای هر سوال';

  @override
  String get actions => 'اقدامات';

  @override
  String get saveSettings => 'ذخیره تنظیمات';

  @override
  String get resetScores => 'بازنشانی امتیازها';

  @override
  String get visitStoreToUnlock => 'برای باز کردن قفل از فروشگاه دیدن کنید!';

  @override
  String get storeTitle => 'فروشگاه';

  @override
  String specialBundlePurchased(int remaining) {
    return 'بسته ویژه خریداری شد! (باقیمانده: $remaining)';
  }

  @override
  String get notEnoughCoins => 'سکه کافی نیست!';

  @override
  String get exchangeSuccessful => 'تبدیل با موفقیت انجام شد!';

  @override
  String get notEnoughPoints => 'امتیاز کافی نیست!';

  @override
  String get themeUnlockedSettings => 'تم باز شد! آن را در تنظیمات فعال کنید.';

  @override
  String itemPurchased(String itemName) {
    return '$itemName خریداری شد!';
  }

  @override
  String get currencyExchange => 'تبدیل ارز';

  @override
  String get shopItems => 'آیتم‌های فروشگاه';

  @override
  String get limitedOffer => 'پیشنهاد ویژه';

  @override
  String endsInDays(int days) {
    return 'پایان در $days روز';
  }

  @override
  String get megaBoosterPack => 'بسته تقویتی مگا';

  @override
  String get boosterPackDesc => '1x جوکر ۵۰/۵۰ + 1x توقف زمان';

  @override
  String remainingLimit(int current, int max) {
    return 'باقیمانده: $current / $max';
  }

  @override
  String get coinsText => 'سکه';

  @override
  String get convertBtn => 'تبدیل';

  @override
  String get joker5050 => 'جوکر ۵۰/۵۰';

  @override
  String get joker5050Desc => 'حذف ۲ گزینه اشتباه';

  @override
  String get timeFreeze => 'توقف زمان';

  @override
  String get timeFreezeDesc => 'توقف زمان برای ۱۰ ثانیه';

  @override
  String get premiumTheme => 'تم پرمیوم';

  @override
  String get unlockGoldTheme => 'باز کردن تم طلایی';

  @override
  String get unlockDiamondInterface => 'باز کردن رابط کاربری الماسی';

  @override
  String get themeUnlocked => 'تم باز شد';

  @override
  String get owned => 'خریداری شده';

  @override
  String get selectTopic => 'انتخاب موضوع';

  @override
  String topicDifficulty(String topic) {
    return 'سختی $topic';
  }

  @override
  String get beginner => 'مبتدی';

  @override
  String get intermediate => 'متوسط';

  @override
  String get advanced => 'پیشرفته';

  @override
  String get dangerZone => 'منطقه خطر';

  @override
  String get deleteAccountTitle => 'حذف حساب و پاک کردن داده‌ها';

  @override
  String get deleteAccountSubtitle =>
      'پروفایل و سوابق ابری/محلی خود را برای همیشه حذف کنید';

  @override
  String get deleteAccountConfirmTitle => 'حذف حساب و داده‌ها؟';

  @override
  String get deleteAccountConfirmDesc =>
      'این کار پروفایل، رکوردهای بالا، موجودی و داده‌های جدول امتیازات شما را برای همیشه حذف می‌کند. این عمل قابل بازگشت نیست.';

  @override
  String get deletePermanently => 'حذف برای همیشه';

  @override
  String get accountDeletedSuccess => 'حساب با موفقیت حذف شد!';

  @override
  String deleteAccountError(String error) {
    return 'خطا: $error. ممکن است لازم باشد برای حذف حساب کاربری خود دوباره وارد شوید.';
  }

  @override
  String get securityCheckTitle => 'بررسی امنیتی';

  @override
  String get securityCheckDesc =>
      'حذف حساب کاربری شما یک عملیات حساس است. برای امنیت خود، لطفاً قبل از تلاش برای حذف حساب، از سیستم خارج شوید و دوباره وارد شوید.';

  @override
  String get logOutAndReLogin => 'خروج و ورود مجدد';

  @override
  String get adNotReady => 'تبلیغ هنوز آماده نیست، لطفاً یک لحظه صبر کنید.';

  @override
  String get rewardEarned => 'تبریک! شما سکه‌های رایگان به دست آوردید.';

  @override
  String get freeRewards => 'جوایز رایگان';

  @override
  String get watchAd => 'تماشای ویدیو';

  @override
  String get watchAdDesc => 'کسب سکه رایگان';

  @override
  String get videoCannotBePlayed => 'ویدیو پخش نمی‌شود!';

  @override
  String get noInternetMessage =>
      'شما به اینترنت متصل نیستید. لطفاً اتصال خود را بررسی کرده و دوباره تلاش کنید.';

  @override
  String get okButton => 'باشه';

  @override
  String get continueOffline => 'ادامه آفلاین';

  @override
  String get unknownUser => 'کاربر ناشناس';

  @override
  String get noEmail => 'بدون ایمیل';

  @override
  String get offlineModeDataFromDevice =>
      'حالت آفلاین: داده‌ها از دستگاه خوانده می‌شوند.';

  @override
  String get questionsLoadError =>
      'سوالات بارگیری نشدند. لطفاً اتصال اینترنت خود را بررسی کنید.';

  @override
  String get points => 'امتیاز';

  @override
  String get createWord => 'ساخت کلمه...';

  @override
  String get clear => 'پاک کردن';

  @override
  String get submit => 'ارسال';

  @override
  String get checking => 'در حال بررسی...';

  @override
  String get chooseYourGame => 'بازی خود را انتخاب کنید';

  @override
  String get wordTooShort => 'کلمه باید حداقل ۳ حرف داشته باشد!';

  @override
  String get wordAlreadyFound => 'شما قبلاً این کلمه را پیدا کرده‌اید!';

  @override
  String pointsEarned(int points) {
    return '+$points امتیاز!';
  }

  @override
  String get invalidWord => 'کلمه نامعتبر!';

  @override
  String get startFindingWords => 'شروع به پیدا کردن کلمات کنید!';

  @override
  String get gameOver => 'پایان بازی';

  @override
  String get yourScore => 'امتیاز شما:';

  @override
  String get exitWordAlyxTitle => 'خروج از WordAlyx؟';

  @override
  String get exitWordAlyxDesc =>
      'آیا مطمئن هستید که می خواهید بازی را ترک کنید؟ پیشرفت شما از بین خواهد رفت.';

  @override
  String get legal => 'حقوقی';

  @override
  String get privacyPolicy => 'سیاست حفظ حریم خصوصی';

  @override
  String get privacyWelcomeTitle => 'به QuizAlyx خوش آمدید!';

  @override
  String get privacyWelcomeDesc =>
      'قبل از شروع، لطفاً سیاست حفظ حریم خصوصی ما را بخوانید و بپذیرید تا متوجه شوید چگونه از داده‌های شما محافظت می‌کنیم.';

  @override
  String get readPrivacyPolicy => 'خواندن سیاست حفظ حریم خصوصی';

  @override
  String get acceptAndContinue => 'پذیرش و ادامه';

  @override
  String get creditsPlayStorePublisher => 'ناشر Play Store';

  @override
  String get creditsAppStorePublisher => 'ناشر App Store';

  @override
  String get creditsIDEAndroid => 'IDE (Android)';

  @override
  String get creditsIDEiOS => 'IDE (iOS)';

  @override
  String get creditsDatabase => 'پایگاه داده';

  @override
  String get creditsFrontend => 'توسعه فرانت‌اند';

  @override
  String get creditsBackend => 'بک‌اند';

  @override
  String get creditsProduction => 'تولید و بروزرسانی‌ها';

  @override
  String get creditsWordAlyxUpdate => 'بروزرسانی WordAlyx (2026)';

  @override
  String get creditsProducer => 'تهیه‌کننده';

  @override
  String get tapToSkip => 'برای رد شدن هر جایی ضربه بزنید';

  @override
  String get selectCurrentAccountError =>
      'لطفاً حساب فعلی خود را برای حذف انتخاب کنید!';
}
