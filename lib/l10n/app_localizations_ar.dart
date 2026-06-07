// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'ابدأ الاختبار';

  @override
  String get settings => 'الإعدادات';

  @override
  String get offlineTitle => 'لا يوجد اتصال بالإنترنت';

  @override
  String get offlineDesc =>
      'يرجى التحقق من اتصالك بالإنترنت. لا يزال بإمكانك اللعب دون اتصال، ولكن سيتم حفظ تقدمك محلياً كضيف.';

  @override
  String get playAsGuest => 'العب كضيف';

  @override
  String get retry => 'حاول مجدداً';

  @override
  String get exitTitle => 'الخروج من QuizAlyx؟';

  @override
  String get exitDesc => 'هل أنت متأكد أنك تريد مغادرة اللعبة؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get exit => 'خروج';

  @override
  String get dailyRewardTitle => 'مكافأة يومية';

  @override
  String get dailyRewardDesc => 'لقد ربحت 5 عملات لتسجيل الدخول اليوم!';

  @override
  String get plus5Coins => '+5 عملات';

  @override
  String get collect => 'جمع';

  @override
  String currentStreak(int days) {
    return 'السلسلة الحالية: $days أيام!';
  }

  @override
  String get guestPlayer => 'لاعب ضيف';

  @override
  String get notLoggedIn => 'لم يتم تسجيل الدخول';

  @override
  String get myAccount => 'حسابي';

  @override
  String get myStatistics => 'إحصائياتي';

  @override
  String get loginSignup => 'تسجيل الدخول / إنشاء حساب';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get appSlogan => 'تحدى معرفتك';

  @override
  String get missionCompleted => 'اكتملت المهمة!';

  @override
  String get leaderboards => 'لوحات الصدارة';

  @override
  String get leaderboardsOfflineDesc =>
      'تتطلب لوحات الصدارة اتصالاً بالإنترنت لمزامنة النتائج العالمية.';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع.';

  @override
  String get noOnePlayedYet => 'لم يلعب أحد بعد!';

  @override
  String get beTheFirstToPlay => 'حل اختباراً الآن وكن أول من يدخل القائمة.';

  @override
  String get topPlayers => 'أفضل اللاعبين';

  @override
  String get challengeThem => 'تحداهم للمطالبة بمكانك!';

  @override
  String get pts => 'نقاط';

  @override
  String get signInWithGoogle => 'تسجيل الدخول باستخدام Google';

  @override
  String get continueAsGuest => 'المتابعة كضيف';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins عملات!';
  }

  @override
  String get mission_global_title => 'سيد الأسئلة';

  @override
  String get mission_global_desc => 'حل إجمالي X سؤال';

  @override
  String get mission_title_Math => 'الرياضيات';

  @override
  String get mission_desc_Math => 'حل أسئلة الرياضيات';

  @override
  String get mission_title_Physics => 'الفيزياء';

  @override
  String get mission_desc_Physics => 'حل أسئلة الفيزياء';

  @override
  String get mission_title_Chemistry => 'الكيمياء';

  @override
  String get mission_desc_Chemistry => 'حل أسئلة الكيمياء';

  @override
  String get mission_title_Biology => 'الأحياء';

  @override
  String get mission_desc_Biology => 'حل أسئلة الأحياء';

  @override
  String get mission_title_History => 'التاريخ';

  @override
  String get mission_desc_History => 'حل أسئلة التاريخ';

  @override
  String get mission_title_Geography => 'الجغرافيا';

  @override
  String get mission_desc_Geography => 'حل أسئلة الجغرافيا';

  @override
  String get mission_title_Literature => 'الأدب';

  @override
  String get mission_desc_Literature => 'حل أسئلة الأدب';

  @override
  String get mission_title_Art => 'الفن';

  @override
  String get mission_desc_Art => 'حل أسئلة الفن';

  @override
  String get mission_title_Music => 'الموسيقى';

  @override
  String get mission_desc_Music => 'حل أسئلة الموسيقى';

  @override
  String get mission_title_Sports => 'الرياضة';

  @override
  String get mission_desc_Sports => 'حل أسئلة الرياضة';

  @override
  String get mission_title_Technology => 'التكنولوجيا';

  @override
  String get mission_desc_Technology => 'حل أسئلة التكنولوجيا';

  @override
  String get mission_title_Software => 'البرمجيات';

  @override
  String get mission_desc_Software => 'حل أسئلة البرمجيات';

  @override
  String get mission_title_Mechanic => 'الميكانيكا';

  @override
  String get mission_desc_Mechanic => 'حل أسئلة الميكانيكا';

  @override
  String get mission_title_Religion => 'الدين';

  @override
  String get mission_desc_Religion => 'حل أسئلة الدين';

  @override
  String get careerAchievements => 'المهنة والإنجازات';

  @override
  String get totalAchievements => 'إجمالي الإنجازات';

  @override
  String get maxLevel => 'الحد الأقصى';

  @override
  String get completed => 'مكتمل';

  @override
  String levelProgress(int current, int total) {
    return 'مستوى $current / $total';
  }

  @override
  String get selectGameMode => 'اختر وضع اللعب';

  @override
  String get modeClassic => 'كلاسيكي';

  @override
  String get modeClassicDesc => 'أسئلة ثابتة، خذ وقتك';

  @override
  String get modeTimed => 'موقت';

  @override
  String get modeTimedDesc => 'سباق مع الزمن';

  @override
  String get modeEndless => 'لا نهائي';

  @override
  String get modeEndlessDesc => 'أجب على أكبر عدد ممكن';

  @override
  String get defaultPlayerName => 'لاعب QuizAlyx';

  @override
  String get editProfileName => 'تعديل اسم الملف الشخصي';

  @override
  String get enterNewName => 'أدخل اسمك الجديد';

  @override
  String get save => 'حفظ';

  @override
  String get nameChangeLimitTitle => 'حد تغيير الاسم';

  @override
  String get nameChangeLimitDesc =>
      'يمكنك تغيير اسمك مرتين فقط كل 14 يومًا. يرجى المحاولة مرة أخرى لاحقًا.';

  @override
  String get ok => 'موافق';

  @override
  String get unknownDate => 'غير معروف';

  @override
  String get accountStatus => 'حالة الحساب';

  @override
  String get verified => 'تم التحقق';

  @override
  String get guestAccount => 'حساب ضيف';

  @override
  String get joinedDate => 'تاريخ الانضمام';

  @override
  String get membership => 'العضوية';

  @override
  String get freeTier => 'مجاني';

  @override
  String daysCount(int count) {
    return '$count أيام';
  }

  @override
  String get dataLoadError => 'تعذر تحميل البيانات.';

  @override
  String get totalScore => 'إجمالي النقاط';

  @override
  String get quizzesPlayed => 'الاختبارات الملعوبة';

  @override
  String get accuracyRate => 'معدل الدقة';

  @override
  String get dailyStreak => 'السلسلة اليومية';

  @override
  String get enterPlayerNameError => 'الرجاء إدخال اسم لاعب رائع!';

  @override
  String get welcomeToQuizAlyx => 'مرحباً بك في QuizAlyx!';

  @override
  String get chooseAvatarName => 'اختر صورة اللاعب الرمزية واسمك.';

  @override
  String get enterPlayerNameHint => 'أدخل اسم اللاعب';

  @override
  String get startJourney => 'ابدأ الرحلة';

  @override
  String get quitQuizTitle => 'الخروج من الاختبار؟';

  @override
  String get quitQuizDesc =>
      'سيتم فقدان تقدمك. هل أنت متأكد أنك تريد العودة إلى الرئيسية؟';

  @override
  String get quit => 'خروج';

  @override
  String get no5050JokerWarning => 'ليس لديك أي وسيلة مساعدة 50/50!';

  @override
  String get noTimeFreezeWarning => 'ليس لديك أي تجميد للوقت!';

  @override
  String get quiz => 'اختبار';

  @override
  String timeSeconds(int seconds) {
    return 'الوقت: $seconds ث';
  }

  @override
  String questionCounter(int current, int total) {
    return 'سؤال $current / $total';
  }

  @override
  String get quizCompleted => 'اكتمل الاختبار!';

  @override
  String get correct => 'صحيح';

  @override
  String get wrong => 'خطأ';

  @override
  String get score => 'النتيجة';

  @override
  String get continueBtn => 'متابعة';

  @override
  String get whatsNext => 'ماذا بعد؟';

  @override
  String get playAgain => 'العب مرة أخرى';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get timesUp => 'انتهى الوقت!';

  @override
  String get language => 'اللغة';

  @override
  String get settingsSaved => 'تم حفظ الإعدادات بنجاح!';

  @override
  String get resetHighScoresTitle => 'إعادة تعيين أعلى النتائج؟';

  @override
  String get resetHighScoresDesc =>
      'سيؤدي هذا إلى حذف جميع درجاتك العالية. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get highScoresResetSuccess => 'تم إعادة تعيين الدرجات بنجاح!';

  @override
  String get appearance => 'المظهر';

  @override
  String get goldTheme => 'المظهر الذهبي';

  @override
  String get premiumGoldLook => 'مظهر ذهبي مميز';

  @override
  String get unlockInStore => 'افتح من المتجر';

  @override
  String get diamondTheme => 'المظهر الماسي';

  @override
  String get legendaryDiamondLook => 'مظهر ماسي أسطوري';

  @override
  String get unlockInStore1500 => 'افتح من المتجر (1500 عملة)';

  @override
  String get gameplay => 'أسلوب اللعب';

  @override
  String get numberOfQuestions => 'عدد الأسئلة';

  @override
  String get timedDurationSec => 'المدة المحددة (ثانية)';

  @override
  String get endlessDurationSec => 'المدة اللانهائية (ثانية)';

  @override
  String get display => 'العرض';

  @override
  String get showDifficulty => 'إظهار الصعوبة';

  @override
  String get showDifficultyDesc => 'عرض مستوى الصعوبة لكل سؤال';

  @override
  String get actions => 'الإجراءات';

  @override
  String get saveSettings => 'حفظ الإعدادات';

  @override
  String get resetScores => 'إعادة تعيين النتائج';

  @override
  String get visitStoreToUnlock => 'قم بزيارة المتجر لفتح القفل!';

  @override
  String get storeTitle => 'المتجر';

  @override
  String specialBundlePurchased(int remaining) {
    return 'تم شراء الحزمة الخاصة! (المتبقي: $remaining)';
  }

  @override
  String get notEnoughCoins => 'عملات غير كافية!';

  @override
  String get exchangeSuccessful => 'تم التبادل بنجاح!';

  @override
  String get notEnoughPoints => 'نقاط غير كافية!';

  @override
  String get themeUnlockedSettings => 'تم فتح المظهر! قم بتفعيله في الإعدادات.';

  @override
  String itemPurchased(String itemName) {
    return 'تم شراء $itemName!';
  }

  @override
  String get currencyExchange => 'تحويل العملات';

  @override
  String get shopItems => 'عناصر المتجر';

  @override
  String get limitedOffer => 'عرض محدود';

  @override
  String endsInDays(int days) {
    return 'ينتهي خلال $days أيام';
  }

  @override
  String get megaBoosterPack => 'حزمة التعزيز الضخمة';

  @override
  String get boosterPackDesc => '1x مساعدة 50/50 + 1x تجميد الوقت';

  @override
  String remainingLimit(int current, int max) {
    return 'المتبقي: $current / $max';
  }

  @override
  String get coinsText => 'العملات';

  @override
  String get convertBtn => 'تحويل';

  @override
  String get joker5050 => 'مساعدة 50/50';

  @override
  String get joker5050Desc => 'يزيل إجابتين خاطئتين';

  @override
  String get timeFreeze => 'تجميد الوقت';

  @override
  String get timeFreezeDesc => 'يوقف الموقت لـ 10 ثوانٍ';

  @override
  String get premiumTheme => 'المظهر المتميز';

  @override
  String get unlockGoldTheme => 'فتح المظهر الذهبي';

  @override
  String get unlockDiamondInterface => 'فتح الواجهة الماسية';

  @override
  String get themeUnlocked => 'تم فتح المظهر';

  @override
  String get owned => 'مملوك';

  @override
  String get selectTopic => 'اختر الموضوع';

  @override
  String topicDifficulty(String topic) {
    return 'صعوبة $topic';
  }

  @override
  String get beginner => 'مبتدئ';

  @override
  String get intermediate => 'متوسط';

  @override
  String get advanced => 'متقدم';
}
