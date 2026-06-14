// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'НАЧАТЬ';

  @override
  String get settings => 'Настройки';

  @override
  String get offlineTitle => 'Нет подключения';

  @override
  String get offlineDesc =>
      'Проверьте подключение к интернету. Вы можете играть офлайн, но ваш прогресс будет сохранен локально как гость.';

  @override
  String get playAsGuest => 'Играть как гость';

  @override
  String get retry => 'Повторить';

  @override
  String get exitTitle => 'Выйти из QuizAlyx?';

  @override
  String get exitDesc => 'Вы уверены, что хотите покинуть игру?';

  @override
  String get cancel => 'Отмена';

  @override
  String get exit => 'Выход';

  @override
  String get dailyRewardTitle => 'Ежедневная награда';

  @override
  String get dailyRewardDesc => 'Вы заработали 5 монет за вход сегодня!';

  @override
  String get plus5Coins => '+5 МОНЕТ';

  @override
  String get collect => 'Забрать';

  @override
  String currentStreak(int days) {
    return 'Текущая серия: $days дн.!';
  }

  @override
  String get guestPlayer => 'Гость';

  @override
  String get notLoggedIn => 'Не в сети';

  @override
  String get myAccount => 'Мой аккаунт';

  @override
  String get myStatistics => 'Моя статистика';

  @override
  String get loginSignup => 'Войти / Регистрация';

  @override
  String get logOut => 'Выйти';

  @override
  String get appSlogan => 'Испытай свои знания';

  @override
  String get missionCompleted => 'МИССИЯ ВЫПОЛНЕНА!';

  @override
  String get leaderboards => 'Таблицы лидеров';

  @override
  String get leaderboardsOfflineDesc =>
      'Для синхронизации глобальных результатов требуется подключение к интернету.';

  @override
  String get unexpectedError => 'Произошла непредвиденная ошибка.';

  @override
  String get noOnePlayedYet => 'Еще никто не играл!';

  @override
  String get beTheFirstToPlay =>
      'Пройдите квиз сейчас и станьте первым в списке.';

  @override
  String get topPlayers => 'Лучшие игроки';

  @override
  String get challengeThem => 'Бросьте им вызов, чтобы занять свое место!';

  @override
  String get pts => 'очков';

  @override
  String get signInWithGoogle => 'Войти через Google';

  @override
  String get continueAsGuest => 'Продолжить как гость';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins Монет!';
  }

  @override
  String get mission_global_title => 'Мастер Вопросов';

  @override
  String get mission_global_desc => 'Решите в общей сложности X вопросов';

  @override
  String get mission_title_Math => 'Математика';

  @override
  String get mission_desc_Math => 'Решайте математические вопросы';

  @override
  String get mission_title_Physics => 'Физика';

  @override
  String get mission_desc_Physics => 'Решайте вопросы по физике';

  @override
  String get mission_title_Chemistry => 'Химия';

  @override
  String get mission_desc_Chemistry => 'Решайте вопросы по химии';

  @override
  String get mission_title_Biology => 'Биология';

  @override
  String get mission_desc_Biology => 'Решайте вопросы по биологии';

  @override
  String get mission_title_History => 'История';

  @override
  String get mission_desc_History => 'Решайте вопросы по истории';

  @override
  String get mission_title_Geography => 'География';

  @override
  String get mission_desc_Geography => 'Решайте вопросы по географии';

  @override
  String get mission_title_Literature => 'Литература';

  @override
  String get mission_desc_Literature => 'Решайте вопросы по литературе';

  @override
  String get mission_title_Art => 'Искусство';

  @override
  String get mission_desc_Art => 'Решайте вопросы по искусству';

  @override
  String get mission_title_Music => 'Музыка';

  @override
  String get mission_desc_Music => 'Решайте вопросы по музыке';

  @override
  String get mission_title_Sports => 'Спорт';

  @override
  String get mission_desc_Sports => 'Решайте вопросы о спорте';

  @override
  String get mission_title_Technology => 'Технологии';

  @override
  String get mission_desc_Technology => 'Решайте вопросы о технологиях';

  @override
  String get mission_title_Software => 'Программирование';

  @override
  String get mission_desc_Software => 'Решайте вопросы по программированию';

  @override
  String get mission_title_Mechanic => 'Механика';

  @override
  String get mission_desc_Mechanic => 'Решайте вопросы по механике';

  @override
  String get mission_title_Religion => 'Религия';

  @override
  String get mission_desc_Religion => 'Решайте вопросы по религии';

  @override
  String get careerAchievements => 'Карьера и Достижения';

  @override
  String get totalAchievements => 'Всего достижений';

  @override
  String get maxLevel => 'МАКС';

  @override
  String get completed => 'Завершено';

  @override
  String levelProgress(int current, int total) {
    return 'Уровень $current / $total';
  }

  @override
  String get selectGameMode => 'Выберите режим';

  @override
  String get modeClassic => 'Классический';

  @override
  String get modeClassicDesc => 'Фиксированные вопросы, не торопитесь';

  @override
  String get modeTimed => 'На время';

  @override
  String get modeTimedDesc => 'Гонка со временем';

  @override
  String get modeEndless => 'Бесконечный';

  @override
  String get modeEndlessDesc => 'Ответьте на как можно больше вопросов';

  @override
  String get defaultPlayerName => 'Игрок QuizAlyx';

  @override
  String get editProfileName => 'Изменить имя';

  @override
  String get enterNewName => 'Введите новое имя';

  @override
  String get save => 'Сохранить';

  @override
  String get nameChangeLimitTitle => 'Лимит смены имени';

  @override
  String get nameChangeLimitDesc =>
      'Вы можете изменить имя только 2 раза за 14 дней. Пожалуйста, попробуйте позже.';

  @override
  String get ok => 'ОК';

  @override
  String get unknownDate => 'Неизвестно';

  @override
  String get accountStatus => 'Статус аккаунта';

  @override
  String get verified => 'Подтвержден';

  @override
  String get guestAccount => 'Гостевой аккаунт';

  @override
  String get joinedDate => 'Дата регистрации';

  @override
  String get membership => 'Подписка';

  @override
  String get freeTier => 'Бесплатно';

  @override
  String daysCount(int count) {
    return '$count Дней';
  }

  @override
  String get dataLoadError => 'Не удалось загрузить данные.';

  @override
  String get totalScore => 'Общий счет';

  @override
  String get quizzesPlayed => 'Пройдено квизов';

  @override
  String get accuracyRate => 'Точность';

  @override
  String get dailyStreak => 'Ежедневная серия';

  @override
  String get enterPlayerNameError => 'Пожалуйста, введите крутое имя игрока!';

  @override
  String get welcomeToQuizAlyx => 'Добро пожаловать в QuizAlyx!';

  @override
  String get chooseAvatarName => 'Выберите аватар и имя игрока.';

  @override
  String get enterPlayerNameHint => 'Введите имя игрока';

  @override
  String get startJourney => 'Начать путешествие';

  @override
  String get quitQuizTitle => 'Выйти из квиза?';

  @override
  String get quitQuizDesc =>
      'Ваш прогресс будет утерян. Вы уверены, что хотите вернуться на главную?';

  @override
  String get quit => 'Выйти';

  @override
  String get no5050JokerWarning => 'У вас нет подсказок 50/50!';

  @override
  String get noTimeFreezeWarning => 'У вас нет заморозки времени!';

  @override
  String get quiz => 'Квиз';

  @override
  String timeSeconds(int seconds) {
    return 'Время: $seconds с';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Вопрос $current / $total';
  }

  @override
  String get quizCompleted => 'Квиз завершен!';

  @override
  String get correct => 'Верно';

  @override
  String get wrong => 'Неверно';

  @override
  String get score => 'Счет';

  @override
  String get continueBtn => 'Продолжить';

  @override
  String get whatsNext => 'Что дальше?';

  @override
  String get playAgain => 'Играть снова';

  @override
  String get backToHome => 'На главную';

  @override
  String get timesUp => 'Время вышло!';

  @override
  String get language => 'Язык';

  @override
  String get settingsSaved => 'Настройки успешно сохранены!';

  @override
  String get resetHighScoresTitle => 'Сбросить рекорды?';

  @override
  String get resetHighScoresDesc =>
      'Это удалит все ваши рекорды. Это действие нельзя отменить.';

  @override
  String get reset => 'Сбросить';

  @override
  String get highScoresResetSuccess => 'Рекорды успешно сброшены!';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get goldTheme => 'Золотая тема';

  @override
  String get premiumGoldLook => 'Премиальный золотой вид';

  @override
  String get unlockInStore => 'Разблокировать в магазине';

  @override
  String get diamondTheme => 'Бриллиантовая тема';

  @override
  String get legendaryDiamondLook => 'Легендарный бриллиантовый вид';

  @override
  String get unlockInStore1500 => 'Открыть в магазине (1500 монет)';

  @override
  String get gameplay => 'Игровой процесс';

  @override
  String get numberOfQuestions => 'Количество вопросов';

  @override
  String get timedDurationSec => 'Время таймера (сек)';

  @override
  String get endlessDurationSec => 'Бесконечное время (сек)';

  @override
  String get display => 'Отображение';

  @override
  String get showDifficulty => 'Показывать сложность';

  @override
  String get showDifficultyDesc =>
      'Отображать уровень сложности для каждого вопроса';

  @override
  String get actions => 'Действия';

  @override
  String get saveSettings => 'Сохранить настройки';

  @override
  String get resetScores => 'Сбросить очки';

  @override
  String get visitStoreToUnlock => 'Посетите магазин, чтобы разблокировать!';

  @override
  String get storeTitle => 'Магазин';

  @override
  String specialBundlePurchased(int remaining) {
    return 'Особый набор куплен! (Осталось: $remaining)';
  }

  @override
  String get notEnoughCoins => 'Недостаточно монет!';

  @override
  String get exchangeSuccessful => 'Обмен успешен!';

  @override
  String get notEnoughPoints => 'Недостаточно очков!';

  @override
  String get themeUnlockedSettings =>
      'Тема разблокирована! Включите ее в настройках.';

  @override
  String itemPurchased(String itemName) {
    return '$itemName куплено!';
  }

  @override
  String get currencyExchange => 'ОБМЕН ВАЛЮТЫ';

  @override
  String get shopItems => 'ТОВАРЫ В МАГАЗИНЕ';

  @override
  String get limitedOffer => 'ОГРАНИЧЕННОЕ ПРЕДЛОЖЕНИЕ';

  @override
  String endsInDays(int days) {
    return 'Заканчивается через $days дн.';
  }

  @override
  String get megaBoosterPack => 'Мега Пак Бустеров';

  @override
  String get boosterPackDesc => '1x Подсказка 50/50 + 1x Заморозка времени';

  @override
  String remainingLimit(int current, int max) {
    return 'Осталось: $current / $max';
  }

  @override
  String get coinsText => 'Монеты';

  @override
  String get convertBtn => 'Обменять';

  @override
  String get joker5050 => 'Подсказка 50/50';

  @override
  String get joker5050Desc => 'Убирает 2 неверных варианта';

  @override
  String get timeFreeze => 'Заморозка времени';

  @override
  String get timeFreezeDesc => 'Останавливает время на 10 сек';

  @override
  String get premiumTheme => 'Премиум тема';

  @override
  String get unlockGoldTheme => 'Разблокировать золотую тему';

  @override
  String get unlockDiamondInterface => 'Разблокировать бриллиантовый интерфейс';

  @override
  String get themeUnlocked => 'Тема разблокирована';

  @override
  String get owned => 'ПРИОБРЕТЕНО';

  @override
  String get selectTopic => 'Выберите тему';

  @override
  String topicDifficulty(String topic) {
    return 'Сложность: $topic';
  }

  @override
  String get beginner => 'Новичок';

  @override
  String get intermediate => 'Средний';

  @override
  String get advanced => 'Продвинутый';

  @override
  String get dangerZone => 'Опасная зона';

  @override
  String get deleteAccountTitle => 'Удалить аккаунт и стереть данные';

  @override
  String get deleteAccountSubtitle =>
      'Навсегда удалить ваш профиль и локальные/облачные записи';

  @override
  String get deleteAccountConfirmTitle => 'Удалить аккаунт и данные?';

  @override
  String get deleteAccountConfirmDesc =>
      'Это навсегда удалит ваш профиль, рекорды, инвентарь и данные таблицы лидеров. Это действие НЕЛЬЗЯ отменить.';

  @override
  String get deletePermanently => 'Удалить навсегда';

  @override
  String get accountDeletedSuccess =>
      'Аккаунт и все связанные с ним данные успешно удалены!';

  @override
  String deleteAccountError(String error) {
    return 'Ошибка: $error. Возможно, вам придется войти снова, чтобы удалить аккаунт.';
  }

  @override
  String get securityCheckTitle => 'Проверка безопасности';

  @override
  String get securityCheckDesc =>
      'Удаление учетной записи — это конфиденциальная операция. В целях безопасности выйдите из системы и войдите снова, прежде чем пытаться удалить свою учетную запись.';

  @override
  String get logOutAndReLogin => 'Выйти и войти снова';
}
