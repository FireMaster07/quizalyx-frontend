// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'OYUNA BAŞLA';

  @override
  String get settings => 'Ayarlar';

  @override
  String get offlineTitle => 'İnternet Bağlantısı Yok';

  @override
  String get offlineDesc =>
      'Lütfen internet bağlantınızı kontrol edin. Çevrimdışı oynamaya devam edebilirsiniz, ancak ilerlemeniz cihazınıza misafir olarak kaydedilecektir.';

  @override
  String get playAsGuest => 'Misafir Olarak Oyna';

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get exitTitle => 'QuizAlyx\'ten Çıkılsın mı?';

  @override
  String get exitDesc => 'Oyundan çıkmak istediğinize emin misiniz?';

  @override
  String get cancel => 'İptal';

  @override
  String get exit => 'Çıkış';

  @override
  String get dailyRewardTitle => 'Günlük Ödül';

  @override
  String get dailyRewardDesc =>
      'Bugün giriş yaptığınız için 5 jeton kazandınız!';

  @override
  String get plus5Coins => '+5 JETON';

  @override
  String get collect => 'Topla';

  @override
  String currentStreak(int days) {
    return 'Mevcut seri: $days gün!';
  }

  @override
  String get guestPlayer => 'Misafir Oyuncu';

  @override
  String get notLoggedIn => 'Giriş yapılmadı';

  @override
  String get myAccount => 'Hesabım';

  @override
  String get myStatistics => 'İstatistiklerim';

  @override
  String get loginSignup => 'Giriş Yap / Kayıt Ol';

  @override
  String get logOut => 'Çıkış Yap';

  @override
  String get appSlogan => 'Bilgini Sına';

  @override
  String get missionCompleted => 'GÖREV TAMAMLANDI!';

  @override
  String get leaderboards => 'Liderlik Tablosu';

  @override
  String get leaderboardsOfflineDesc =>
      'Küresel skorları senkronize etmek için internet bağlantısı gereklidir.';

  @override
  String get unexpectedError => 'Beklenmeyen bir hata oluştu.';

  @override
  String get noOnePlayedYet => 'Henüz kimse oynamadı!';

  @override
  String get beTheFirstToPlay =>
      'Şimdi bir quiz çöz ve listeye giren ilk kişi sen ol.';

  @override
  String get topPlayers => 'En İyi Oyuncular';

  @override
  String get challengeThem => 'Yerini almak için onlara meydan oku!';

  @override
  String get pts => 'puan';

  @override
  String get signInWithGoogle => 'Google ile Giriş Yap';

  @override
  String get continueAsGuest => 'Misafir Olarak Devam Et';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins Jeton!';
  }

  @override
  String get mission_global_title => 'Soru Üstadı';

  @override
  String get mission_global_desc => 'Toplamda X soru çöz';

  @override
  String get mission_title_Math => 'Matematik';

  @override
  String get mission_desc_Math => 'Matematik soruları çöz';

  @override
  String get mission_title_Physics => 'Fizik';

  @override
  String get mission_desc_Physics => 'Fizik soruları çöz';

  @override
  String get mission_title_Chemistry => 'Kimya';

  @override
  String get mission_desc_Chemistry => 'Kimya soruları çöz';

  @override
  String get mission_title_Biology => 'Biyoloji';

  @override
  String get mission_desc_Biology => 'Biyoloji soruları çöz';

  @override
  String get mission_title_History => 'Tarih';

  @override
  String get mission_desc_History => 'Tarih soruları çöz';

  @override
  String get mission_title_Geography => 'Coğrafya';

  @override
  String get mission_desc_Geography => 'Coğrafya soruları çöz';

  @override
  String get mission_title_Literature => 'Edebiyat';

  @override
  String get mission_desc_Literature => 'Edebiyat soruları çöz';

  @override
  String get mission_title_Art => 'Sanat';

  @override
  String get mission_desc_Art => 'Sanat soruları çöz';

  @override
  String get mission_title_Music => 'Müzik';

  @override
  String get mission_desc_Music => 'Müzik soruları çöz';

  @override
  String get mission_title_Sports => 'Spor';

  @override
  String get mission_desc_Sports => 'Spor soruları çöz';

  @override
  String get mission_title_Technology => 'Teknoloji';

  @override
  String get mission_desc_Technology => 'Teknoloji soruları çöz';

  @override
  String get mission_title_Software => 'Yazılım';

  @override
  String get mission_desc_Software => 'Yazılım soruları çöz';

  @override
  String get mission_title_Mechanic => 'Mekanik';

  @override
  String get mission_desc_Mechanic => 'Mekanik soruları çöz';

  @override
  String get mission_title_Religion => 'Din Kültürü';

  @override
  String get mission_desc_Religion => 'Din Kültürü soruları çöz';

  @override
  String get careerAchievements => 'Kariyer & Başarılar';

  @override
  String get totalAchievements => 'Toplam Başarılar';

  @override
  String get maxLevel => 'MAKS';

  @override
  String get completed => 'Tamamlandı';

  @override
  String levelProgress(int current, int total) {
    return 'Seviye $current / $total';
  }

  @override
  String get selectGameMode => 'Oyun Modunu Seç';

  @override
  String get modeClassic => 'Klasik';

  @override
  String get modeClassicDesc => 'Sabit sorular, acele etmeden çöz';

  @override
  String get modeTimed => 'Süreli';

  @override
  String get modeTimedDesc => 'Zamana karşı yarış';

  @override
  String get modeEndless => 'Sonsuz';

  @override
  String get modeEndlessDesc => 'Çözebildiğin kadar çok çöz';

  @override
  String get defaultPlayerName => 'QuizAlyx Oyuncusu';

  @override
  String get editProfileName => 'Profili Düzenle';

  @override
  String get enterNewName => 'Yeni adınızı girin';

  @override
  String get save => 'Kaydet';

  @override
  String get nameChangeLimitTitle => 'İsim Değiştirme Sınırı';

  @override
  String get nameChangeLimitDesc =>
      'İsminizi 14 günde sadece 2 kez değiştirebilirsiniz. Lütfen daha sonra tekrar deneyin.';

  @override
  String get ok => 'TAMAM';

  @override
  String get unknownDate => 'Bilinmiyor';

  @override
  String get accountStatus => 'Hesap Durumu';

  @override
  String get verified => 'Doğrulandı';

  @override
  String get guestAccount => 'Misafir Hesabı';

  @override
  String get joinedDate => 'Katılım Tarihi';

  @override
  String get membership => 'Üyelik';

  @override
  String get freeTier => 'Ücretsiz Plan';

  @override
  String daysCount(int count) {
    return '$count Gün';
  }

  @override
  String get dataLoadError => 'Veriler yüklenemedi.';

  @override
  String get totalScore => 'Toplam Skor';

  @override
  String get quizzesPlayed => 'Oynanan Quizler';

  @override
  String get accuracyRate => 'Doğruluk Oranı';

  @override
  String get dailyStreak => 'Günlük Seri';

  @override
  String get enterPlayerNameError => 'Lütfen havalı bir oyuncu adı gir!';

  @override
  String get welcomeToQuizAlyx => 'QuizAlyx\'e Hoş Geldin!';

  @override
  String get chooseAvatarName => 'Oyuncu avatarını ve adını seç.';

  @override
  String get enterPlayerNameHint => 'Oyuncu Adını Gir';

  @override
  String get startJourney => 'Maceraya Başla';

  @override
  String get quitQuizTitle => 'Testten Çıkılsın mı?';

  @override
  String get quitQuizDesc =>
      'İlerlemen kaybolacak. Ana ekrana dönmek istediğine emin misin?';

  @override
  String get quit => 'Çık';

  @override
  String get no5050JokerWarning => 'Hiç 50/50 Jokerin kalmadı!';

  @override
  String get noTimeFreezeWarning => 'Hiç Zaman Dondurucun kalmadı!';

  @override
  String get quiz => 'Quiz';

  @override
  String timeSeconds(int seconds) {
    return 'Süre: $seconds sn';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Soru $current / $total';
  }

  @override
  String get quizCompleted => 'Test Tamamlandı!';

  @override
  String get correct => 'Doğru';

  @override
  String get wrong => 'Yanlış';

  @override
  String get score => 'Puan';

  @override
  String get continueBtn => 'Devam Et';

  @override
  String get whatsNext => 'Sırada Ne Var?';

  @override
  String get playAgain => 'Tekrar Oyna';

  @override
  String get backToHome => 'Ana Ekrana Dön';

  @override
  String get timesUp => 'Süre Doldu!';

  @override
  String get language => 'Dil';

  @override
  String get settingsSaved => 'Ayarlar başarıyla kaydedildi!';

  @override
  String get resetHighScoresTitle => 'Skorlar Sıfırlansın mı?';

  @override
  String get resetHighScoresDesc =>
      'Bu işlem tüm yüksek skorlarını silecek. Bu işlem geri alınamaz.';

  @override
  String get reset => 'Sıfırla';

  @override
  String get highScoresResetSuccess => 'Yüksek skorlar başarıyla sıfırlandı!';

  @override
  String get appearance => 'Görünüm';

  @override
  String get goldTheme => 'Altın Tema';

  @override
  String get premiumGoldLook => 'Premium altın görünüm';

  @override
  String get unlockInStore => 'Mağazadan Kilidi Aç';

  @override
  String get diamondTheme => 'Elmas Tema';

  @override
  String get legendaryDiamondLook => 'Efsanevi elmas görünüm';

  @override
  String get unlockInStore1500 => 'Mağazadan Aç (1500 Jeton)';

  @override
  String get gameplay => 'Oynanış';

  @override
  String get numberOfQuestions => 'Soru Sayısı';

  @override
  String get timedDurationSec => 'Süreli Mod Süresi (sn)';

  @override
  String get endlessDurationSec => 'Sonsuz Mod Süresi (sn)';

  @override
  String get display => 'Görüntü';

  @override
  String get showDifficulty => 'Zorluğu Göster';

  @override
  String get showDifficultyDesc => 'Her soru için zorluk seviyesini göster';

  @override
  String get actions => 'İşlemler';

  @override
  String get saveSettings => 'Ayarları Kaydet';

  @override
  String get resetScores => 'Skorları Sıfırla';

  @override
  String get visitStoreToUnlock => 'Kilidi açmak için Mağazayı ziyaret et!';

  @override
  String get storeTitle => 'Mağaza';

  @override
  String specialBundlePurchased(int remaining) {
    return 'Özel Paket Satın Alındı! (Kalan: $remaining)';
  }

  @override
  String get notEnoughCoins => 'Yeterli jeton yok!';

  @override
  String get exchangeSuccessful => 'Takas başarılı!';

  @override
  String get notEnoughPoints => 'Yeterli puan yok!';

  @override
  String get themeUnlockedSettings => 'Tema Açıldı! Ayarlardan etkinleştirin.';

  @override
  String itemPurchased(String itemName) {
    return '$itemName satın alındı!';
  }

  @override
  String get currencyExchange => 'DÖVİZ BOZDURMA';

  @override
  String get shopItems => 'MAĞAZA ÜRÜNLERİ';

  @override
  String get limitedOffer => 'SINIRLI TEKLİF';

  @override
  String endsInDays(int days) {
    return '$days gün içinde bitiyor';
  }

  @override
  String get megaBoosterPack => 'Mega Güç Paketi';

  @override
  String get boosterPackDesc => '1x 50/50 Joker + 1x Zaman Dondurucu';

  @override
  String remainingLimit(int current, int max) {
    return 'Kalan: $current / $max';
  }

  @override
  String get coinsText => 'Jeton';

  @override
  String get convertBtn => 'Çevir';

  @override
  String get joker5050 => '50/50 Joker';

  @override
  String get joker5050Desc => '2 yanlış seçeneği eler';

  @override
  String get timeFreeze => 'Zaman Dondurucu';

  @override
  String get timeFreezeDesc => 'Süreyi 10 sn durdurur';

  @override
  String get premiumTheme => 'Premium Tema';

  @override
  String get unlockGoldTheme => 'Altın Temayı Aç';

  @override
  String get unlockDiamondInterface => 'Elmas Arayüzü Aç';

  @override
  String get themeUnlocked => 'Tema Açıldı';

  @override
  String get owned => 'SAHİP';

  @override
  String get selectTopic => 'Konu Seç';

  @override
  String topicDifficulty(String topic) {
    return '$topic Zorluğu';
  }

  @override
  String get beginner => 'Başlangıç';

  @override
  String get intermediate => 'Orta';

  @override
  String get advanced => 'İleri';

  @override
  String get dangerZone => 'Tehlikeli Bölge';

  @override
  String get deleteAccountTitle => 'Hesabı ve Verileri Sil';

  @override
  String get deleteAccountSubtitle =>
      'Profilini ve tüm yerel/bulut kayıtlarını kalıcı olarak sil';

  @override
  String get deleteAccountConfirmTitle => 'Hesap ve Veriler Silinsin mi?';

  @override
  String get deleteAccountConfirmDesc =>
      'Bu işlem profilini, yüksek skorlarını, envanterini ve liderlik tablosu verilerini kalıcı olarak siler. Bu işlem GERİ ALINAMAZ.';

  @override
  String get deletePermanently => 'Kalıcı Olarak Sil';

  @override
  String get accountDeletedSuccess =>
      'Hesap ve ilişkili tüm veriler başarıyla silindi!';

  @override
  String deleteAccountError(String error) {
    return 'Hata: $error. Hesabınızı silmek için yeniden giriş yapmanız gerekebilir.';
  }

  @override
  String get securityCheckTitle => 'Güvenlik Kontrolü';

  @override
  String get securityCheckDesc =>
      'Hesabınızı silmek kritik bir işlemdir. Güvenliğiniz için, hesabınızı silmeyi denemeden önce lütfen çıkış yapıp tekrar giriş yapın.';

  @override
  String get logOutAndReLogin => 'Çıkış Yap & Tekrar Gir';
}
