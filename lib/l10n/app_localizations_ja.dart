// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'クイズ開始';

  @override
  String get settings => '設定';

  @override
  String get offlineTitle => 'インターネット接続なし';

  @override
  String get offlineDesc =>
      '接続を確認してください。オフラインでもプレイ可能ですが、進行状況はゲストとしてローカルに保存されます。';

  @override
  String get playAsGuest => 'ゲストとしてプレイ';

  @override
  String get retry => '再試行';

  @override
  String get exitTitle => 'QuizAlyxを終了しますか？';

  @override
  String get exitDesc => 'ゲームを終了してもよろしいですか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get exit => '終了';

  @override
  String get dailyRewardTitle => 'デイリー報酬';

  @override
  String get dailyRewardDesc => '今日のログインで5コインを獲得しました！';

  @override
  String get plus5Coins => '+5 コイン';

  @override
  String get collect => '受け取る';

  @override
  String currentStreak(int days) {
    return '現在の連続記録: $days 日！';
  }

  @override
  String get guestPlayer => 'ゲストプレイヤー';

  @override
  String get notLoggedIn => '未ログイン';

  @override
  String get myAccount => 'マイアカウント';

  @override
  String get myStatistics => 'マイ統計';

  @override
  String get loginSignup => 'ログイン / 登録';

  @override
  String get logOut => 'ログアウト';

  @override
  String get appSlogan => '知識に挑戦しよう';

  @override
  String get missionCompleted => 'ミッション達成！';

  @override
  String get leaderboards => 'リーダーボード';

  @override
  String get leaderboardsOfflineDesc => 'グローバルスコアを同期するにはインターネット接続が必要です。';

  @override
  String get unexpectedError => '予期せぬエラーが発生しました。';

  @override
  String get noOnePlayedYet => 'まだ誰もプレイしていません！';

  @override
  String get beTheFirstToPlay => '今すぐクイズを解いて、リストの最初の人になりましょう。';

  @override
  String get topPlayers => 'トッププレイヤー';

  @override
  String get challengeThem => '彼らに挑戦して、あなたの場所を手に入れましょう！';

  @override
  String get pts => 'pt';

  @override
  String get signInWithGoogle => 'Google でログイン';

  @override
  String get continueAsGuest => 'ゲストとして続行';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins コイン！';
  }

  @override
  String get mission_global_title => 'クイズマスター';

  @override
  String get mission_global_desc => '合計X問解く';

  @override
  String get mission_title_Math => '数学';

  @override
  String get mission_desc_Math => '数学の質問を解く';

  @override
  String get mission_title_Physics => '物理';

  @override
  String get mission_desc_Physics => '物理の質問を解く';

  @override
  String get mission_title_Chemistry => '化学';

  @override
  String get mission_desc_Chemistry => '化学の質問を解く';

  @override
  String get mission_title_Biology => '生物';

  @override
  String get mission_desc_Biology => '生物の質問を解く';

  @override
  String get mission_title_History => '歴史';

  @override
  String get mission_desc_History => '歴史の質問を解く';

  @override
  String get mission_title_Geography => '地理';

  @override
  String get mission_desc_Geography => '地理の質問を解く';

  @override
  String get mission_title_Literature => '文学';

  @override
  String get mission_desc_Literature => '文学の質問を解く';

  @override
  String get mission_title_Art => '美術';

  @override
  String get mission_desc_Art => '美術の質問を解く';

  @override
  String get mission_title_Music => '音楽';

  @override
  String get mission_desc_Music => '音楽の質問を解く';

  @override
  String get mission_title_Sports => 'スポーツ';

  @override
  String get mission_desc_Sports => 'スポーツの質問を解く';

  @override
  String get mission_title_Technology => 'テクノロジー';

  @override
  String get mission_desc_Technology => 'テクノロジーの質問を解く';

  @override
  String get mission_title_Software => 'ソフトウェア';

  @override
  String get mission_desc_Software => 'ソフトウェアの質問を解く';

  @override
  String get mission_title_Mechanic => '機械工学';

  @override
  String get mission_desc_Mechanic => '機械工学の質問を解く';

  @override
  String get mission_title_Religion => '宗教';

  @override
  String get mission_desc_Religion => '宗教の質問を解く';

  @override
  String get careerAchievements => 'キャリアと実績';

  @override
  String get totalAchievements => '合計実績';

  @override
  String get maxLevel => '最大';

  @override
  String get completed => '完了';

  @override
  String levelProgress(int current, int total) {
    return 'レベル $current / $total';
  }

  @override
  String get selectGameMode => 'ゲームモードを選択';

  @override
  String get modeClassic => 'クラシック';

  @override
  String get modeClassicDesc => '固定問題、自分のペースで';

  @override
  String get modeTimed => 'タイムド';

  @override
  String get modeTimedDesc => '時間との戦い';

  @override
  String get modeEndless => 'エンドレス';

  @override
  String get modeEndlessDesc => 'できるだけ多く答える';

  @override
  String get defaultPlayerName => 'QuizAlyx プレイヤー';

  @override
  String get editProfileName => 'プロフィール名を編集';

  @override
  String get enterNewName => '新しい名前を入力';

  @override
  String get save => '保存';

  @override
  String get nameChangeLimitTitle => '名前変更の制限';

  @override
  String get nameChangeLimitDesc => '名前の変更は14日間に2回までです。後で再試行してください。';

  @override
  String get ok => 'OK';

  @override
  String get unknownDate => '不明';

  @override
  String get accountStatus => 'アカウント状況';

  @override
  String get verified => '認証済み';

  @override
  String get guestAccount => 'ゲストアカウント';

  @override
  String get joinedDate => '登録日';

  @override
  String get membership => 'メンバーシップ';

  @override
  String get freeTier => '無料プラン';

  @override
  String daysCount(int count) {
    return '$count 日';
  }

  @override
  String get dataLoadError => 'データを読み込めませんでした。';

  @override
  String get totalScore => '合計スコア';

  @override
  String get quizzesPlayed => 'プレイしたクイズ';

  @override
  String get accuracyRate => '正解率';

  @override
  String get dailyStreak => '連続ログイン';

  @override
  String get enterPlayerNameError => 'クールなプレイヤー名を入力してください！';

  @override
  String get welcomeToQuizAlyx => 'QuizAlyxへようこそ！';

  @override
  String get chooseAvatarName => 'プレイヤーアバターと名前を選択してください。';

  @override
  String get enterPlayerNameHint => 'プレイヤー名を入力';

  @override
  String get startJourney => '旅を始める';

  @override
  String get quitQuizTitle => 'クイズを終了しますか？';

  @override
  String get quitQuizDesc => '進行状況は失われます。ホームに戻ってもよろしいですか？';

  @override
  String get quit => '終了';

  @override
  String get no5050JokerWarning => '50/50ジョーカーがありません！';

  @override
  String get noTimeFreezeWarning => 'タイムフリーズがありません！';

  @override
  String get quiz => 'クイズ';

  @override
  String timeSeconds(int seconds) {
    return '残り時間: $seconds 秒';
  }

  @override
  String questionCounter(int current, int total) {
    return '問題 $current / $total';
  }

  @override
  String get quizCompleted => 'クイズ完了！';

  @override
  String get correct => '正解';

  @override
  String get wrong => '不正解';

  @override
  String get score => 'スコア';

  @override
  String get continueBtn => '続ける';

  @override
  String get whatsNext => '次はどうする？';

  @override
  String get playAgain => 'もう一度プレイ';

  @override
  String get backToHome => 'ホームに戻る';

  @override
  String get timesUp => '時間切れ！';

  @override
  String get language => '言語';

  @override
  String get settingsSaved => '設定が正常に保存されました！';

  @override
  String get resetHighScoresTitle => 'ハイスコアをリセットしますか？';

  @override
  String get resetHighScoresDesc => 'これによりすべてのハイスコアが削除されます。この操作は元に戻せません。';

  @override
  String get reset => 'リセット';

  @override
  String get highScoresResetSuccess => 'ハイスコアが正常にリセットされました！';

  @override
  String get appearance => '外観';

  @override
  String get goldTheme => 'ゴールドテーマ';

  @override
  String get premiumGoldLook => 'プレミアムなゴールドルック';

  @override
  String get unlockInStore => 'ストアでロック解除';

  @override
  String get diamondTheme => 'ダイヤモンドテーマ';

  @override
  String get legendaryDiamondLook => '伝説のダイヤモンドルック';

  @override
  String get unlockInStore1500 => 'ストアでロック解除 (1500 コイン)';

  @override
  String get gameplay => 'ゲームプレイ';

  @override
  String get numberOfQuestions => '問題数';

  @override
  String get timedDurationSec => '制限時間 (秒)';

  @override
  String get endlessDurationSec => 'エンドレスの制限時間 (秒)';

  @override
  String get display => '表示';

  @override
  String get showDifficulty => '難易度を表示';

  @override
  String get showDifficultyDesc => '各問題の難易度を表示する';

  @override
  String get actions => 'アクション';

  @override
  String get saveSettings => '設定を保存';

  @override
  String get resetScores => 'スコアをリセット';

  @override
  String get visitStoreToUnlock => 'ストアにアクセスしてロック解除！';

  @override
  String get storeTitle => 'ストア';

  @override
  String specialBundlePurchased(int remaining) {
    return '特別バンドルを購入しました！（残り：$remaining）';
  }

  @override
  String get notEnoughCoins => 'コインが足りません！';

  @override
  String get exchangeSuccessful => '交換成功！';

  @override
  String get notEnoughPoints => 'ポイントが足りません！';

  @override
  String get themeUnlockedSettings => 'テーマのロックを解除しました！設定で有効にしてください。';

  @override
  String itemPurchased(String itemName) {
    return '$itemName を購入しました！';
  }

  @override
  String get currencyExchange => '通貨交換';

  @override
  String get shopItems => 'ショップアイテム';

  @override
  String get limitedOffer => '期間限定オファー';

  @override
  String endsInDays(int days) {
    return '残り $days 日で終了';
  }

  @override
  String get megaBoosterPack => 'メガブースターパック';

  @override
  String get boosterPackDesc => '1x 50/50 ジョーカー + 1x タイムフリーズ';

  @override
  String remainingLimit(int current, int max) {
    return '残り: $current / $max';
  }

  @override
  String get coinsText => 'コイン';

  @override
  String get convertBtn => '変換';

  @override
  String get joker5050 => '50/50 ジョーカー';

  @override
  String get joker5050Desc => '間違った選択肢を2つ削除';

  @override
  String get timeFreeze => 'タイムフリーズ';

  @override
  String get timeFreezeDesc => 'タイマーを10秒間停止';

  @override
  String get premiumTheme => 'プレミアムテーマ';

  @override
  String get unlockGoldTheme => 'ゴールドテーマをアンロック';

  @override
  String get unlockDiamondInterface => 'ダイヤモンドUIをアンロック';

  @override
  String get themeUnlocked => 'テーマをアンロック済み';

  @override
  String get owned => '所有済み';

  @override
  String get selectTopic => 'トピックを選択';

  @override
  String topicDifficulty(String topic) {
    return '$topic の難易度';
  }

  @override
  String get beginner => '初級';

  @override
  String get intermediate => '中級';

  @override
  String get advanced => '上級';

  @override
  String get dangerZone => 'デンジャーゾーン';

  @override
  String get deleteAccountTitle => 'アカウントとデータを削除';

  @override
  String get deleteAccountSubtitle => 'プロフィールとクラウド/ローカルの記録を完全に削除する';

  @override
  String get deleteAccountConfirmTitle => 'アカウントとデータを削除しますか？';

  @override
  String get deleteAccountConfirmDesc =>
      'これにより、プロフィール、ハイスコア、インベントリ、リーダーボードのデータが完全に削除されます。この操作は元に戻せません。';

  @override
  String get deletePermanently => '完全に削除';

  @override
  String get accountDeletedSuccess => 'アカウントが正常に削除されました！';

  @override
  String deleteAccountError(String error) {
    return 'エラー：$error。アカウントを削除するには、再度ログインする必要がある場合があります。';
  }

  @override
  String get securityCheckTitle => 'セキュリティチェック';

  @override
  String get securityCheckDesc =>
      'アカウントの削除は重要な操作です。セキュリティのため、アカウントを削除する前に一度ログアウトし、再度ログインしてください。';

  @override
  String get logOutAndReLogin => 'ログアウトして再ログイン';

  @override
  String get adNotReady => '広告の準備がまだできていません。少々お待ちください。';

  @override
  String get rewardEarned => 'おめでとうございます！無料のコインを獲得しました。';

  @override
  String get freeRewards => '無料報酬';

  @override
  String get watchAd => '動画を見る';

  @override
  String get watchAdDesc => '無料コインを稼ぐ';

  @override
  String get videoCannotBePlayed => '動画を再生できません！';

  @override
  String get noInternetMessage => 'インターネットに接続されていません。接続を確認して、もう一度お試しください。';

  @override
  String get okButton => 'OK';

  @override
  String get continueOffline => 'オフラインで続行';

  @override
  String get unknownUser => '不明なユーザー';

  @override
  String get noEmail => 'メールなし';

  @override
  String get offlineModeDataFromDevice => 'オフラインモード：デバイスからデータを読み取ります。';

  @override
  String get questionsLoadError => '問題が読み込めませんでした。インターネット接続を確認してください。';

  @override
  String get points => 'スコア';

  @override
  String get createWord => '単語を作成...';

  @override
  String get clear => 'クリア';

  @override
  String get submit => '送信';

  @override
  String get checking => '確認中...';

  @override
  String get chooseYourGame => 'ゲームを選択';

  @override
  String get wordTooShort => '単語は3文字以上である必要があります！';

  @override
  String get wordAlreadyFound => 'この単語はすでに見つけました！';

  @override
  String pointsEarned(int points) {
    return '+$points ポイント！';
  }

  @override
  String get invalidWord => '無効な単語です！';

  @override
  String get startFindingWords => '単語を見つけ始めましょう！';

  @override
  String get gameOver => 'ゲームオーバー';

  @override
  String get yourScore => 'あなたのスコア：';

  @override
  String get exitWordAlyxTitle => 'WordAlyxを終了しますか？';

  @override
  String get exitWordAlyxDesc => '本当にゲームを終了しますか？進行状況は失われます。';

  @override
  String get legal => '法的情報';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get privacyWelcomeTitle => 'QuizAlyxへようこそ！';

  @override
  String get privacyWelcomeDesc =>
      '始める前に、データの保護方法をご理解いただくため、プライバシーポリシーを読み、同意してください。';

  @override
  String get readPrivacyPolicy => 'プライバシーポリシーを読む';

  @override
  String get acceptAndContinue => '同意して続ける';

  @override
  String get creditsPlayStorePublisher => 'Play ストア パブリッシャー';

  @override
  String get creditsAppStorePublisher => 'App Store パブリッシャー';

  @override
  String get creditsIDEAndroid => 'IDE (Android)';

  @override
  String get creditsIDEiOS => 'IDE (iOS)';

  @override
  String get creditsDatabase => 'データベース';

  @override
  String get creditsFrontend => 'フロントエンド開発';

  @override
  String get creditsBackend => 'バックエンド';

  @override
  String get creditsProduction => '制作とアップデート';

  @override
  String get creditsWordAlyxUpdate => 'WordAlyx アップデート (2026)';

  @override
  String get creditsProducer => 'プロデューサー';

  @override
  String get tapToSkip => 'どこでもタップしてスキップ';

  @override
  String get selectCurrentAccountError => '削除する現在のアカウントを選択してください！';
}
