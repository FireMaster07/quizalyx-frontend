// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => '퀴즈 시작';

  @override
  String get settings => '설정';

  @override
  String get offlineTitle => '인터넷 연결 없음';

  @override
  String get offlineDesc =>
      '연결을 확인해주세요. 오프라인으로 플레이할 수 있지만 진행 상황은 게스트로 기기에 저장됩니다.';

  @override
  String get playAsGuest => '게스트로 플레이';

  @override
  String get retry => '재시도';

  @override
  String get exitTitle => 'QuizAlyx를 종료하시겠습니까?';

  @override
  String get exitDesc => '게임을 종료하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get exit => '종료';

  @override
  String get dailyRewardTitle => '일일 보상';

  @override
  String get dailyRewardDesc => '오늘 로그인하여 5코인을 획득했습니다!';

  @override
  String get plus5Coins => '+5 코인';

  @override
  String get collect => '수령하기';

  @override
  String currentStreak(int days) {
    return '현재 연속 기록: $days일!';
  }

  @override
  String get guestPlayer => '게스트 플레이어';

  @override
  String get notLoggedIn => '로그인되지 않음';

  @override
  String get myAccount => '내 계정';

  @override
  String get myStatistics => '내 통계';

  @override
  String get loginSignup => '로그인 / 회원가입';

  @override
  String get logOut => '로그아웃';

  @override
  String get appSlogan => '당신의 지식에 도전하세요';

  @override
  String get missionCompleted => '임무 완료!';

  @override
  String get leaderboards => '순위표';

  @override
  String get leaderboardsOfflineDesc => '글로벌 점수를 동기화하려면 인터넷 연결이 필요합니다.';

  @override
  String get unexpectedError => '예상치 못한 오류가 발생했습니다.';

  @override
  String get noOnePlayedYet => '아직 아무도 플레이하지 않았습니다!';

  @override
  String get beTheFirstToPlay => '지금 퀴즈를 풀고 목록에 가장 먼저 이름을 올리세요.';

  @override
  String get topPlayers => '최고의 플레이어';

  @override
  String get challengeThem => '그들에게 도전하여 당신의 자리를 차지하세요!';

  @override
  String get pts => '점';

  @override
  String get signInWithGoogle => 'Google로 로그인';

  @override
  String get continueAsGuest => '게스트로 계속하기';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins 코인!';
  }

  @override
  String get mission_global_title => '질문 마스터';

  @override
  String get mission_global_desc => '총 X개의 질문을 해결하세요';

  @override
  String get mission_title_Math => '수학';

  @override
  String get mission_desc_Math => '수학 질문 해결';

  @override
  String get mission_title_Physics => '물리학';

  @override
  String get mission_desc_Physics => '물리학 질문 해결';

  @override
  String get mission_title_Chemistry => '화학';

  @override
  String get mission_desc_Chemistry => '화학 질문 해결';

  @override
  String get mission_title_Biology => '생물학';

  @override
  String get mission_desc_Biology => '생물학 질문 해결';

  @override
  String get mission_title_History => '역사';

  @override
  String get mission_desc_History => '역사 질문 해결';

  @override
  String get mission_title_Geography => '지리';

  @override
  String get mission_desc_Geography => '지리 질문 해결';

  @override
  String get mission_title_Literature => '문학';

  @override
  String get mission_desc_Literature => '문학 질문 해결';

  @override
  String get mission_title_Art => '예술';

  @override
  String get mission_desc_Art => '예술 질문 해결';

  @override
  String get mission_title_Music => '음악';

  @override
  String get mission_desc_Music => '음악 질문 해결';

  @override
  String get mission_title_Sports => '스포츠';

  @override
  String get mission_desc_Sports => '스포츠 질문 해결';

  @override
  String get mission_title_Technology => '기술';

  @override
  String get mission_desc_Technology => '기술 질문 해결';

  @override
  String get mission_title_Software => '소프트웨어';

  @override
  String get mission_desc_Software => '소프트웨어 질문 해결';

  @override
  String get mission_title_Mechanic => '기계학';

  @override
  String get mission_desc_Mechanic => '기계학 질문 해결';

  @override
  String get mission_title_Religion => '종교';

  @override
  String get mission_desc_Religion => '종교 질문 해결';

  @override
  String get careerAchievements => '경력 및 업적';

  @override
  String get totalAchievements => '총 업적';

  @override
  String get maxLevel => '최대';

  @override
  String get completed => '완료';

  @override
  String levelProgress(int current, int total) {
    return '레벨 $current / $total';
  }

  @override
  String get selectGameMode => '게임 모드 선택';

  @override
  String get modeClassic => '클래식';

  @override
  String get modeClassicDesc => '고정된 질문, 천천히 푸세요';

  @override
  String get modeTimed => '시간 제한';

  @override
  String get modeTimedDesc => '시간과의 경주';

  @override
  String get modeEndless => '무한';

  @override
  String get modeEndlessDesc => '최대한 많이 대답하세요';

  @override
  String get defaultPlayerName => 'QuizAlyx 플레이어';

  @override
  String get editProfileName => '프로필 이름 편집';

  @override
  String get enterNewName => '새 이름 입력';

  @override
  String get save => '저장';

  @override
  String get nameChangeLimitTitle => '이름 변경 제한';

  @override
  String get nameChangeLimitDesc => '이름은 14일마다 2번만 변경할 수 있습니다. 나중에 다시 시도해 주세요.';

  @override
  String get ok => '확인';

  @override
  String get unknownDate => '알 수 없음';

  @override
  String get accountStatus => '계정 상태';

  @override
  String get verified => '확인됨';

  @override
  String get guestAccount => '게스트 계정';

  @override
  String get joinedDate => '가입 날짜';

  @override
  String get membership => '멤버십';

  @override
  String get freeTier => '무료';

  @override
  String daysCount(int count) {
    return '$count 일';
  }

  @override
  String get dataLoadError => '데이터를 로드할 수 없습니다.';

  @override
  String get totalScore => '총 점수';

  @override
  String get quizzesPlayed => '플레이한 퀴즈';

  @override
  String get accuracyRate => '정확도';

  @override
  String get dailyStreak => '일일 연속 기록';

  @override
  String get enterPlayerNameError => '멋진 플레이어 이름을 입력해주세요!';

  @override
  String get welcomeToQuizAlyx => 'QuizAlyx에 오신 것을 환영합니다!';

  @override
  String get chooseAvatarName => '플레이어 아바타와 이름을 선택하세요.';

  @override
  String get enterPlayerNameHint => '플레이어 이름 입력';

  @override
  String get startJourney => '여정 시작';

  @override
  String get quitQuizTitle => '퀴즈를 종료하시겠습니까?';

  @override
  String get quitQuizDesc => '진행 상황이 손실됩니다. 홈으로 돌아가시겠습니까?';

  @override
  String get quit => '종료';

  @override
  String get no5050JokerWarning => '50/50 조커가 없습니다!';

  @override
  String get noTimeFreezeWarning => '시간 정지가 없습니다!';

  @override
  String get quiz => '퀴즈';

  @override
  String timeSeconds(int seconds) {
    return '시간: $seconds 초';
  }

  @override
  String questionCounter(int current, int total) {
    return '질문 $current / $total';
  }

  @override
  String get quizCompleted => '퀴즈 완료!';

  @override
  String get correct => '정답';

  @override
  String get wrong => '오답';

  @override
  String get score => '점수';

  @override
  String get continueBtn => '계속';

  @override
  String get whatsNext => '다음은?';

  @override
  String get playAgain => '다시 플레이';

  @override
  String get backToHome => '홈으로 돌아가기';

  @override
  String get timesUp => '시간 종료!';

  @override
  String get language => '언어';

  @override
  String get settingsSaved => '설정이 성공적으로 저장되었습니다!';

  @override
  String get resetHighScoresTitle => '최고 점수를 초기화하시겠습니까?';

  @override
  String get resetHighScoresDesc => '모든 최고 점수가 삭제됩니다. 이 작업은 실행 취소할 수 없습니다.';

  @override
  String get reset => '초기화';

  @override
  String get highScoresResetSuccess => '최고 점수가 성공적으로 초기화되었습니다!';

  @override
  String get appearance => '외관';

  @override
  String get goldTheme => '골드 테마';

  @override
  String get premiumGoldLook => '프리미엄 골드 룩';

  @override
  String get unlockInStore => '상점에서 잠금 해제';

  @override
  String get diamondTheme => '다이아몬드 테마';

  @override
  String get legendaryDiamondLook => '전설적인 다이아몬드 룩';

  @override
  String get unlockInStore1500 => '상점에서 잠금 해제 (1500 코인)';

  @override
  String get gameplay => '게임 플레이';

  @override
  String get numberOfQuestions => '질문 수';

  @override
  String get timedDurationSec => '시간 제한 지속 시간 (초)';

  @override
  String get endlessDurationSec => '무한 지속 시간 (초)';

  @override
  String get display => '디스플레이';

  @override
  String get showDifficulty => '난이도 표시';

  @override
  String get showDifficultyDesc => '각 질문의 난이도 레벨 표시';

  @override
  String get actions => '작업';

  @override
  String get saveSettings => '설정 저장';

  @override
  String get resetScores => '점수 초기화';

  @override
  String get visitStoreToUnlock => '잠금 해제하려면 상점을 방문하세요!';

  @override
  String get storeTitle => '상점';

  @override
  String specialBundlePurchased(int remaining) {
    return '특별 번들 구매 완료! (남은 수량: $remaining)';
  }

  @override
  String get notEnoughCoins => '코인이 부족합니다!';

  @override
  String get exchangeSuccessful => '교환 성공!';

  @override
  String get notEnoughPoints => '포인트가 부족합니다!';

  @override
  String get themeUnlockedSettings => '테마 잠금 해제! 설정에서 활성화하세요.';

  @override
  String itemPurchased(String itemName) {
    return '$itemName 구매 완료!';
  }

  @override
  String get currencyExchange => '통화 교환';

  @override
  String get shopItems => '상점 아이템';

  @override
  String get limitedOffer => '한정 혜택';

  @override
  String endsInDays(int days) {
    return '$days일 후 종료';
  }

  @override
  String get megaBoosterPack => '메가 부스터 팩';

  @override
  String get boosterPackDesc => '1x 50/50 조커 + 1x 시간 정지';

  @override
  String remainingLimit(int current, int max) {
    return '남은 수량: $current / $max';
  }

  @override
  String get coinsText => '코인';

  @override
  String get convertBtn => '변환';

  @override
  String get joker5050 => '50/50 조커';

  @override
  String get joker5050Desc => '오답 2개 제거';

  @override
  String get timeFreeze => '시간 정지';

  @override
  String get timeFreezeDesc => '10초 동안 타이머 정지';

  @override
  String get premiumTheme => '프리미엄 테마';

  @override
  String get unlockGoldTheme => '골드 테마 잠금 해제';

  @override
  String get unlockDiamondInterface => '다이아몬드 인터페이스 잠금 해제';

  @override
  String get themeUnlocked => '테마 잠금 해제됨';

  @override
  String get owned => '보유함';

  @override
  String get selectTopic => '주제 선택';

  @override
  String topicDifficulty(String topic) {
    return '$topic 난이도';
  }

  @override
  String get beginner => '초급';

  @override
  String get intermediate => '중급';

  @override
  String get advanced => '고급';

  @override
  String get dangerZone => '위험 구역';

  @override
  String get deleteAccountTitle => '계정 삭제 및 데이터 지우기';

  @override
  String get deleteAccountSubtitle => '프로필 및 클라우드/로컬 기록을 영구적으로 삭제';

  @override
  String get deleteAccountConfirmTitle => '계정 및 데이터를 삭제하시겠습니까?';

  @override
  String get deleteAccountConfirmDesc =>
      '이 작업은 프로필, 최고 점수, 인벤토리 및 순위표 데이터를 영구적으로 삭제합니다. 이 작업은 실행 취소할 수 없습니다.';

  @override
  String get deletePermanently => '영구 삭제';

  @override
  String get accountDeletedSuccess => '계정 및 모든 관련 데이터가 성공적으로 삭제되었습니다!';

  @override
  String deleteAccountError(String error) {
    return '오류: $error. 계정을 삭제하려면 다시 로그인해야 할 수 있습니다.';
  }

  @override
  String get securityCheckTitle => '보안 확인';

  @override
  String get securityCheckDesc =>
      '계정 삭제는 민감한 작업입니다. 보안을 위해 계정을 삭제하기 전에 로그아웃한 후 다시 로그인해 주세요.';

  @override
  String get logOutAndReLogin => '로그아웃 및 재로그인';
}
