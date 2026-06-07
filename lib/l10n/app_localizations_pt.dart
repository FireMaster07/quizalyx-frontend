// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'COMEÇAR';

  @override
  String get settings => 'Configurações';

  @override
  String get offlineTitle => 'Sem conexão com a Internet';

  @override
  String get offlineDesc =>
      'Verifique sua conexão. Você ainda pode jogar offline, mas seu progresso será salvo localmente como convidado.';

  @override
  String get playAsGuest => 'Jogar como Convidado';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get exitTitle => 'Sair do QuizAlyx?';

  @override
  String get exitDesc => 'Tem certeza de que deseja sair do jogo?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get exit => 'Sair';

  @override
  String get dailyRewardTitle => 'Recompensa Diária';

  @override
  String get dailyRewardDesc => 'Você ganhou 5 moedas por entrar hoje!';

  @override
  String get plus5Coins => '+5 MOEDAS';

  @override
  String get collect => 'Coletar';

  @override
  String currentStreak(int days) {
    return 'Sequência atual: $days dias!';
  }

  @override
  String get guestPlayer => 'Jogador Convidado';

  @override
  String get notLoggedIn => 'Não conectado';

  @override
  String get myAccount => 'Minha Conta';

  @override
  String get myStatistics => 'Minhas Estatísticas';

  @override
  String get loginSignup => 'Entrar / Cadastrar';

  @override
  String get logOut => 'Sair';

  @override
  String get appSlogan => 'Desafie seu conhecimento';

  @override
  String get missionCompleted => 'MISSÃO CONCLUÍDA!';

  @override
  String get leaderboards => 'Classificações';

  @override
  String get leaderboardsOfflineDesc =>
      'As classificações exigem uma conexão com a Internet para sincronizar as pontuações globais.';

  @override
  String get unexpectedError => 'Ocorreu um erro inesperado.';

  @override
  String get noOnePlayedYet => 'Ninguém jogou ainda!';

  @override
  String get beTheFirstToPlay =>
      'Resolva um quiz agora e seja o primeiro a entrar na lista.';

  @override
  String get topPlayers => 'Melhores Jogadores';

  @override
  String get challengeThem => 'Desafie-os para reivindicar seu lugar!';

  @override
  String get pts => 'pts';

  @override
  String get signInWithGoogle => 'Entrar com o Google';

  @override
  String get continueAsGuest => 'Continuar como convidado';

  @override
  String plusCoinsEarned(int coins) {
    return '+$coins Moedas!';
  }

  @override
  String get mission_global_title => 'Mestre das Perguntas';

  @override
  String get mission_global_desc => 'Resolva um total de X perguntas';

  @override
  String get mission_title_Math => 'Matemática';

  @override
  String get mission_desc_Math => 'Resolva perguntas de matemática';

  @override
  String get mission_title_Physics => 'Física';

  @override
  String get mission_desc_Physics => 'Resolva perguntas de física';

  @override
  String get mission_title_Chemistry => 'Química';

  @override
  String get mission_desc_Chemistry => 'Resolva perguntas de química';

  @override
  String get mission_title_Biology => 'Biologia';

  @override
  String get mission_desc_Biology => 'Resolva perguntas de biologia';

  @override
  String get mission_title_History => 'História';

  @override
  String get mission_desc_History => 'Resolva perguntas de história';

  @override
  String get mission_title_Geography => 'Geografia';

  @override
  String get mission_desc_Geography => 'Resolva perguntas de geografia';

  @override
  String get mission_title_Literature => 'Literatura';

  @override
  String get mission_desc_Literature => 'Resolva perguntas de literatura';

  @override
  String get mission_title_Art => 'Arte';

  @override
  String get mission_desc_Art => 'Resolva perguntas de arte';

  @override
  String get mission_title_Music => 'Música';

  @override
  String get mission_desc_Music => 'Resolva perguntas de música';

  @override
  String get mission_title_Sports => 'Esportes';

  @override
  String get mission_desc_Sports => 'Resolva perguntas de esportes';

  @override
  String get mission_title_Technology => 'Tecnologia';

  @override
  String get mission_desc_Technology => 'Resolva perguntas de tecnologia';

  @override
  String get mission_title_Software => 'Software';

  @override
  String get mission_desc_Software => 'Resolva perguntas de software';

  @override
  String get mission_title_Mechanic => 'Mecânica';

  @override
  String get mission_desc_Mechanic => 'Resolva perguntas de mecânica';

  @override
  String get mission_title_Religion => 'Religião';

  @override
  String get mission_desc_Religion => 'Resolva perguntas de religião';

  @override
  String get careerAchievements => 'Carreira e Conquistas';

  @override
  String get totalAchievements => 'Total de Conquistas';

  @override
  String get maxLevel => 'MÁX';

  @override
  String get completed => 'Concluído';

  @override
  String levelProgress(int current, int total) {
    return 'Nível $current / $total';
  }

  @override
  String get selectGameMode => 'Selecionar Modo';

  @override
  String get modeClassic => 'Clássico';

  @override
  String get modeClassicDesc => 'Perguntas fixas, sem pressa';

  @override
  String get modeTimed => 'Cronometrado';

  @override
  String get modeTimedDesc => 'Corrida contra o tempo';

  @override
  String get modeEndless => 'Infinito';

  @override
  String get modeEndlessDesc => 'Responda o máximo que puder';

  @override
  String get defaultPlayerName => 'Jogador QuizAlyx';

  @override
  String get editProfileName => 'Editar Nome';

  @override
  String get enterNewName => 'Digite seu novo nome';

  @override
  String get save => 'Salvar';

  @override
  String get nameChangeLimitTitle => 'Limite de Mudança de Nome';

  @override
  String get nameChangeLimitDesc =>
      'Você só pode alterar seu nome 2 vezes a cada 14 dias. Tente novamente mais tarde.';

  @override
  String get ok => 'OK';

  @override
  String get unknownDate => 'Desconhecido';

  @override
  String get accountStatus => 'Status da Conta';

  @override
  String get verified => 'Verificado';

  @override
  String get guestAccount => 'Conta de Convidado';

  @override
  String get joinedDate => 'Data de inscrição';

  @override
  String get membership => 'Assinatura';

  @override
  String get freeTier => 'Gratuito';

  @override
  String daysCount(int count) {
    return '$count Dias';
  }

  @override
  String get dataLoadError => 'Não foi possível carregar os dados.';

  @override
  String get totalScore => 'Pontuação Total';

  @override
  String get quizzesPlayed => 'Quizzes Jogados';

  @override
  String get accuracyRate => 'Taxa de Precisão';

  @override
  String get dailyStreak => 'Sequência Diária';

  @override
  String get enterPlayerNameError =>
      'Por favor, insira um nome de jogador legal!';

  @override
  String get welcomeToQuizAlyx => 'Bem-vindo ao QuizAlyx!';

  @override
  String get chooseAvatarName => 'Escolha seu avatar e nome de jogador.';

  @override
  String get enterPlayerNameHint => 'Digite o Nome do Jogador';

  @override
  String get startJourney => 'Iniciar Jornada';

  @override
  String get quitQuizTitle => 'Sair do Quiz?';

  @override
  String get quitQuizDesc =>
      'Seu progresso será perdido. Tem certeza de que deseja voltar ao Início?';

  @override
  String get quit => 'Sair';

  @override
  String get no5050JokerWarning => 'Você não tem mais Joker 50/50!';

  @override
  String get noTimeFreezeWarning => 'Você não tem mais Congelar Tempo!';

  @override
  String get quiz => 'Quiz';

  @override
  String timeSeconds(int seconds) {
    return 'Tempo: $seconds s';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Pergunta $current / $total';
  }

  @override
  String get quizCompleted => 'Quiz Concluído!';

  @override
  String get correct => 'Correto';

  @override
  String get wrong => 'Errado';

  @override
  String get score => 'Pontuação';

  @override
  String get continueBtn => 'Continuar';

  @override
  String get whatsNext => 'O que vem a seguir?';

  @override
  String get playAgain => 'Jogar Novamente';

  @override
  String get backToHome => 'Voltar ao Início';

  @override
  String get timesUp => 'Tempo Esgotado!';

  @override
  String get language => 'Idioma';

  @override
  String get settingsSaved => 'Configurações salvas com sucesso!';

  @override
  String get resetHighScoresTitle => 'Redefinir Pontuações?';

  @override
  String get resetHighScoresDesc =>
      'Isso excluirá todas as suas pontuações altas. Esta ação não pode ser desfeita.';

  @override
  String get reset => 'Redefinir';

  @override
  String get highScoresResetSuccess => 'Pontuações redefinidas com sucesso!';

  @override
  String get appearance => 'Aparência';

  @override
  String get goldTheme => 'Tema Ouro';

  @override
  String get premiumGoldLook => 'Aparência de ouro premium';

  @override
  String get unlockInStore => 'Desbloquear na Loja';

  @override
  String get diamondTheme => 'Tema Diamante';

  @override
  String get legendaryDiamondLook => 'Aparência de diamante lendário';

  @override
  String get unlockInStore1500 => 'Desbloquear na Loja (1500 Moedas)';

  @override
  String get gameplay => 'Jogabilidade';

  @override
  String get numberOfQuestions => 'Número de Perguntas';

  @override
  String get timedDurationSec => 'Duração cronometrada (seg)';

  @override
  String get endlessDurationSec => 'Duração infinita (seg)';

  @override
  String get display => 'Exibição';

  @override
  String get showDifficulty => 'Mostrar Dificuldade';

  @override
  String get showDifficultyDesc =>
      'Mostrar nível de dificuldade para cada pergunta';

  @override
  String get actions => 'Ações';

  @override
  String get saveSettings => 'Salvar Configurações';

  @override
  String get resetScores => 'Zerar Pontuações';

  @override
  String get visitStoreToUnlock => 'Visite a Loja para desbloquear!';

  @override
  String get storeTitle => 'Loja';

  @override
  String specialBundlePurchased(int remaining) {
    return 'Pacote Especial Comprado! (Restantes: $remaining)';
  }

  @override
  String get notEnoughCoins => 'Moedas insuficientes!';

  @override
  String get exchangeSuccessful => 'Troca bem-sucedida!';

  @override
  String get notEnoughPoints => 'Pontos insuficientes!';

  @override
  String get themeUnlockedSettings =>
      'Tema Desbloqueado! Ative em Configurações.';

  @override
  String itemPurchased(String itemName) {
    return '$itemName comprado!';
  }

  @override
  String get currencyExchange => 'CÂMBIO DE MOEDAS';

  @override
  String get shopItems => 'ITENS DA LOJA';

  @override
  String get limitedOffer => 'OFERTA LIMITADA';

  @override
  String endsInDays(int days) {
    return 'Termina em $days dias';
  }

  @override
  String get megaBoosterPack => 'Mega Pacote Booster';

  @override
  String get boosterPackDesc => '1x Coringa 50/50 + 1x Congelar Tempo';

  @override
  String remainingLimit(int current, int max) {
    return 'Restante: $current / $max';
  }

  @override
  String get coinsText => 'Moedas';

  @override
  String get convertBtn => 'Converter';

  @override
  String get joker5050 => 'Coringa 50/50';

  @override
  String get joker5050Desc => 'Remove 2 opções erradas';

  @override
  String get timeFreeze => 'Congelar Tempo';

  @override
  String get timeFreezeDesc => 'Para o cronômetro por 10s';

  @override
  String get premiumTheme => 'Tema Premium';

  @override
  String get unlockGoldTheme => 'Desbloquear Tema Ouro';

  @override
  String get unlockDiamondInterface => 'Desbloquear Interface Diamante';

  @override
  String get themeUnlocked => 'Tema Desbloqueado';

  @override
  String get owned => 'ADQUIRIDO';

  @override
  String get selectTopic => 'Selecionar Tópico';

  @override
  String topicDifficulty(String topic) {
    return 'Dificuldade: $topic';
  }

  @override
  String get beginner => 'Iniciante';

  @override
  String get intermediate => 'Intermediário';

  @override
  String get advanced => 'Avançado';
}
