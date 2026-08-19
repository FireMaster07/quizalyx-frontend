// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => '开始测试';

  @override
  String get settings => '设置';

  @override
  String get offlineTitle => '无网络连接';

  @override
  String get offlineDesc => '请检查您的网络连接。您仍然可以离线游玩，但进度将作为访客保存在本地。';

  @override
  String get playAsGuest => '作为访客游玩';

  @override
  String get retry => '重试';

  @override
  String get exitTitle => '退出 QuizAlyx？';

  @override
  String get exitDesc => '您确定要离开游戏吗？';

  @override
  String get cancel => '取消';

  @override
  String get exit => '退出';

  @override
  String get dailyRewardTitle => '每日奖励';

  @override
  String get dailyRewardDesc => '您今天登录获得了 5 个金币！';

  @override
  String get plus5Coins => '+5 金币';

  @override
  String get collect => '领取';

  @override
  String currentStreak(int days) {
    return '当前连续签到：$days 天！';
  }

  @override
  String get guestPlayer => '访客玩家';

  @override
  String get notLoggedIn => '未登录';

  @override
  String get myAccount => '我的账户';

  @override
  String get myStatistics => '我的统计';

  @override
  String get loginSignup => '登录 / 注册';

  @override
  String get logOut => '登出';

  @override
  String get appSlogan => '挑战你的知识';

  @override
  String get missionCompleted => '任务完成！';

  @override
  String get leaderboards => '排行榜';

  @override
  String get leaderboardsOfflineDesc => '排行榜需要互联网连接以同步全球分数。';

  @override
  String get unexpectedError => '发生意外错误。';

  @override
  String get noOnePlayedYet => '还没有人玩过！';

  @override
  String get beTheFirstToPlay => '现在完成测验，成为第一个进入列表的人。';

  @override
  String get topPlayers => '顶级玩家';

  @override
  String get challengeThem => '挑战他们，争夺你的名次！';

  @override
  String get pts => '分';

  @override
  String get signInWithGoogle => '通过 Google 登录';

  @override
  String get continueAsGuest => '以访客身份继续';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins 金币！';
  }

  @override
  String get mission_global_title => '答题大师';

  @override
  String get mission_global_desc => '总共解决 X 个问题';

  @override
  String get mission_title_Math => '数学';

  @override
  String get mission_desc_Math => '解决数学问题';

  @override
  String get mission_title_Physics => '物理';

  @override
  String get mission_desc_Physics => '解决物理问题';

  @override
  String get mission_title_Chemistry => '化学';

  @override
  String get mission_desc_Chemistry => '解决化学问题';

  @override
  String get mission_title_Biology => '生物';

  @override
  String get mission_desc_Biology => '解决生物问题';

  @override
  String get mission_title_History => '历史';

  @override
  String get mission_desc_History => '解决历史问题';

  @override
  String get mission_title_Geography => '地理';

  @override
  String get mission_desc_Geography => '解决地理问题';

  @override
  String get mission_title_Literature => '文学';

  @override
  String get mission_desc_Literature => '解决文学问题';

  @override
  String get mission_title_Art => '艺术';

  @override
  String get mission_desc_Art => '解决艺术问题';

  @override
  String get mission_title_Music => '音乐';

  @override
  String get mission_desc_Music => '解决音乐问题';

  @override
  String get mission_title_Sports => '体育';

  @override
  String get mission_desc_Sports => '解决体育问题';

  @override
  String get mission_title_Technology => '技术';

  @override
  String get mission_desc_Technology => '解决技术问题';

  @override
  String get mission_title_Software => '软件';

  @override
  String get mission_desc_Software => '解决软件问题';

  @override
  String get mission_title_Mechanic => '机械';

  @override
  String get mission_desc_Mechanic => '解决机械问题';

  @override
  String get mission_title_Religion => '宗教';

  @override
  String get mission_desc_Religion => '解决宗教问题';

  @override
  String get careerAchievements => '职业与成就';

  @override
  String get totalAchievements => '总成就';

  @override
  String get maxLevel => '最大';

  @override
  String get completed => '已完成';

  @override
  String levelProgress(int current, int total) {
    return '等级 $current / $total';
  }

  @override
  String get selectGameMode => '选择游戏模式';

  @override
  String get modeClassic => '经典模式';

  @override
  String get modeClassicDesc => '固定问题，不用着急';

  @override
  String get modeTimed => '限时模式';

  @override
  String get modeTimedDesc => '与时间赛跑';

  @override
  String get modeEndless => '无尽模式';

  @override
  String get modeEndlessDesc => '尽可能多回答';

  @override
  String get defaultPlayerName => 'QuizAlyx 玩家';

  @override
  String get editProfileName => '编辑资料名称';

  @override
  String get enterNewName => '输入你的新名字';

  @override
  String get save => '保存';

  @override
  String get nameChangeLimitTitle => '改名限制';

  @override
  String get nameChangeLimitDesc => '每 14 天只能更改名字 2 次。请稍后再试。';

  @override
  String get ok => '确定';

  @override
  String get unknownDate => '未知';

  @override
  String get accountStatus => '账户状态';

  @override
  String get verified => '已验证';

  @override
  String get guestAccount => '访客账户';

  @override
  String get joinedDate => '加入日期';

  @override
  String get membership => '会员资格';

  @override
  String get freeTier => '免费方案';

  @override
  String daysCount(int count) {
    return '$count 天';
  }

  @override
  String get dataLoadError => '无法加载数据。';

  @override
  String get totalScore => '总分';

  @override
  String get quizzesPlayed => '已玩测验';

  @override
  String get accuracyRate => '准确率';

  @override
  String get dailyStreak => '每日连胜';

  @override
  String get enterPlayerNameError => '请输入一个酷炫的玩家名称！';

  @override
  String get welcomeToQuizAlyx => '欢迎来到 QuizAlyx！';

  @override
  String get chooseAvatarName => '选择你的玩家头像和名称。';

  @override
  String get enterPlayerNameHint => '输入玩家名称';

  @override
  String get startJourney => '开始旅程';

  @override
  String get quitQuizTitle => '退出测验？';

  @override
  String get quitQuizDesc => '您的进度将会丢失。确定要返回主页吗？';

  @override
  String get quit => '退出';

  @override
  String get no5050JokerWarning => '您没有 50/50 提示卡了！';

  @override
  String get noTimeFreezeWarning => '您没有时间冻结卡了！';

  @override
  String get quiz => '测验';

  @override
  String timeSeconds(int seconds) {
    return '时间: $seconds 秒';
  }

  @override
  String questionCounter(int current, int total) {
    return '问题 $current / $total';
  }

  @override
  String get quizCompleted => '测验完成！';

  @override
  String get correct => '正确';

  @override
  String get wrong => '错误';

  @override
  String get score => '得分';

  @override
  String get continueBtn => '继续';

  @override
  String get whatsNext => '下一步？';

  @override
  String get playAgain => '再玩一次';

  @override
  String get backToHome => '返回主页';

  @override
  String get timesUp => '时间到！';

  @override
  String get language => '语言';

  @override
  String get settingsSaved => '设置已成功保存！';

  @override
  String get resetHighScoresTitle => '重置最高分？';

  @override
  String get resetHighScoresDesc => '这将删除您所有的最高分。此操作无法撤销。';

  @override
  String get reset => '重置';

  @override
  String get highScoresResetSuccess => '最高分已成功重置！';

  @override
  String get appearance => '外观';

  @override
  String get goldTheme => '黄金主题';

  @override
  String get premiumGoldLook => '优质黄金外观';

  @override
  String get unlockInStore => '在商店解锁';

  @override
  String get diamondTheme => '钻石主题';

  @override
  String get legendaryDiamondLook => '传说中的钻石外观';

  @override
  String get unlockInStore1500 => '在商店解锁（1500 金币）';

  @override
  String get gameplay => '游戏设置';

  @override
  String get numberOfQuestions => '问题数量';

  @override
  String get timedDurationSec => '限时持续时间（秒）';

  @override
  String get endlessDurationSec => '无尽持续时间（秒）';

  @override
  String get display => '显示';

  @override
  String get showDifficulty => '显示难度';

  @override
  String get showDifficultyDesc => '显示每个问题的难度级别';

  @override
  String get actions => '操作';

  @override
  String get saveSettings => '保存设置';

  @override
  String get resetScores => '重置分数';

  @override
  String get visitStoreToUnlock => '访问商店以解锁！';

  @override
  String get storeTitle => '商店';

  @override
  String specialBundlePurchased(int remaining) {
    return '已购买特别捆绑包！（剩余：$remaining）';
  }

  @override
  String get notEnoughCoins => '金币不足！';

  @override
  String get exchangeSuccessful => '兑换成功！';

  @override
  String get notEnoughPoints => '积分不足！';

  @override
  String get themeUnlockedSettings => '主题已解锁！请在设置中启用。';

  @override
  String itemPurchased(String itemName) {
    return '已购买 $itemName！';
  }

  @override
  String get currencyExchange => '货币兑换';

  @override
  String get shopItems => '商店物品';

  @override
  String get limitedOffer => '限时优惠';

  @override
  String endsInDays(int days) {
    return '$days 天后结束';
  }

  @override
  String get megaBoosterPack => '超级加速包';

  @override
  String get boosterPackDesc => '1x 50/50 提示 + 1x 时间冻结';

  @override
  String remainingLimit(int current, int max) {
    return '剩余: $current / $max';
  }

  @override
  String get coinsText => '金币';

  @override
  String get convertBtn => '兑换';

  @override
  String get joker5050 => '50/50 提示';

  @override
  String get joker5050Desc => '移除 2 个错误选项';

  @override
  String get timeFreeze => '时间冻结';

  @override
  String get timeFreezeDesc => '停止计时 10 秒';

  @override
  String get premiumTheme => '高级主题';

  @override
  String get unlockGoldTheme => '解锁黄金主题';

  @override
  String get unlockDiamondInterface => '解锁钻石界面';

  @override
  String get themeUnlocked => '主题已解锁';

  @override
  String get owned => '已拥有';

  @override
  String get selectTopic => '选择主题';

  @override
  String topicDifficulty(String topic) {
    return '$topic 难度';
  }

  @override
  String get beginner => '初级';

  @override
  String get intermediate => '中级';

  @override
  String get advanced => '高级';

  @override
  String get dangerZone => '危险区域';

  @override
  String get deleteAccountTitle => '删除帐户并清除数据';

  @override
  String get deleteAccountSubtitle => '永久删除您的个人资料以及云端/本地记录';

  @override
  String get deleteAccountConfirmTitle => '删除帐户和数据？';

  @override
  String get deleteAccountConfirmDesc => '这将永久删除您的个人资料、最高分、物品栏和排行榜数据。此操作无法撤销。';

  @override
  String get deletePermanently => '永久删除';

  @override
  String get accountDeletedSuccess => '账号已成功删除！';

  @override
  String deleteAccountError(String error) {
    return '错误：$error。您可能需要重新验证才能删除帐户。';
  }

  @override
  String get securityCheckTitle => '安全检查';

  @override
  String get securityCheckDesc => '删除您的帐户是一项敏感操作。为了您的安全，请在尝试删除帐户之前先注销并重新登录。';

  @override
  String get logOutAndReLogin => '注销并重新登录';

  @override
  String get adNotReady => '广告还未准备好，请稍等片刻。';

  @override
  String get rewardEarned => '恭喜！你获得了免费金币。';

  @override
  String get freeRewards => '免费奖励';

  @override
  String get watchAd => '观看视频';

  @override
  String get watchAdDesc => '赚取免费金币';

  @override
  String get videoCannotBePlayed => '视频无法播放！';

  @override
  String get noInternetMessage => '您未连接到互联网。请检查您的连接并重试。';

  @override
  String get okButton => '确定';

  @override
  String get continueOffline => '离线继续';

  @override
  String get unknownUser => '未知用户';

  @override
  String get noEmail => '无电子邮件';

  @override
  String get offlineModeDataFromDevice => '离线模式：从设备读取数据。';

  @override
  String get questionsLoadError => '无法加载问题。请检查您的网络连接。';

  @override
  String get points => '分数';

  @override
  String get createWord => '创建单词...';

  @override
  String get clear => '清除';

  @override
  String get submit => '提交';

  @override
  String get checking => '正在检查...';

  @override
  String get chooseYourGame => '选择你的游戏';

  @override
  String get wordTooShort => '单词至少需要3个字母！';

  @override
  String get wordAlreadyFound => '你已经找到这个单词了！';

  @override
  String pointsEarned(int points) {
    return '+$points 分！';
  }

  @override
  String get invalidWord => '无效单词！';

  @override
  String get startFindingWords => '开始找单词吧！';

  @override
  String get gameOver => '游戏结束';

  @override
  String get yourScore => '你的得分：';

  @override
  String get exitWordAlyxTitle => '退出 WordAlyx？';

  @override
  String get exitWordAlyxDesc => '您确定要离开游戏吗？您的进度将会丢失。';

  @override
  String get legal => '法律';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get privacyWelcomeTitle => '欢迎来到 QuizAlyx！';

  @override
  String get privacyWelcomeDesc => '在开始之前，请阅读并接受我们的隐私政策，以了解我们如何保护您的数据。';

  @override
  String get readPrivacyPolicy => '阅读隐私政策';

  @override
  String get acceptAndContinue => '接受并继续';

  @override
  String get creditsPlayStorePublisher => 'Play 商店发布者';

  @override
  String get creditsAppStorePublisher => 'App Store 发布者';

  @override
  String get creditsIDEAndroid => 'IDE (Android)';

  @override
  String get creditsIDEiOS => 'IDE (iOS)';

  @override
  String get creditsDatabase => '数据库';

  @override
  String get creditsFrontend => '前端开发';

  @override
  String get creditsBackend => '后端';

  @override
  String get creditsProduction => '制作与更新';

  @override
  String get creditsWordAlyxUpdate => 'WordAlyx 更新 (2026)';

  @override
  String get creditsProducer => '制作人';

  @override
  String get tapToSkip => '点击任意位置跳过';

  @override
  String get selectCurrentAccountError => '请选择您当前要删除的账号！';
}
