// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'QuizAlyx';

  @override
  String get startQuiz => 'COMENZAR';

  @override
  String get settings => 'Ajustes';

  @override
  String get offlineTitle => 'Sin conexión a Internet';

  @override
  String get offlineDesc =>
      'Por favor revisa tu conexión. Puedes seguir jugando sin conexión, pero tu progreso se guardará localmente como invitado.';

  @override
  String get playAsGuest => 'Jugar como Invitado';

  @override
  String get retry => 'Reintentar';

  @override
  String get exitTitle => '¿Salir de QuizAlyx?';

  @override
  String get exitDesc => '¿Estás seguro de que quieres salir del juego?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get exit => 'Salir';

  @override
  String get dailyRewardTitle => 'Recompensa Diaria';

  @override
  String get dailyRewardDesc => '¡Has ganado 5 monedas por iniciar sesión hoy!';

  @override
  String get plus5Coins => '+5 MONEDAS';

  @override
  String get collect => 'Reclamar';

  @override
  String currentStreak(int days) {
    return 'Racha actual: ¡$days días!';
  }

  @override
  String get guestPlayer => 'Jugador Invitado';

  @override
  String get notLoggedIn => 'No has iniciado sesión';

  @override
  String get myAccount => 'Mi Cuenta';

  @override
  String get myStatistics => 'Mis Estadísticas';

  @override
  String get loginSignup => 'Iniciar sesión / Registrarse';

  @override
  String get logOut => 'Cerrar sesión';

  @override
  String get appSlogan => 'Desafía tus conocimientos';

  @override
  String get missionCompleted => '¡MISIÓN COMPLETADA!';

  @override
  String get leaderboards => 'Clasificaciones';

  @override
  String get leaderboardsOfflineDesc =>
      'Las clasificaciones requieren una conexión a Internet para sincronizar las puntuaciones globales.';

  @override
  String get unexpectedError => 'Ocurrió un error inesperado.';

  @override
  String get noOnePlayedYet => '¡Nadie ha jugado todavía!';

  @override
  String get beTheFirstToPlay =>
      'Resuelve un quiz ahora y sé el primero en entrar a la lista.';

  @override
  String get topPlayers => 'Mejores Jugadores';

  @override
  String get challengeThem => '¡Desafíalos para reclamar tu lugar!';

  @override
  String get pts => 'pts';

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get continueAsGuest => 'Continuar como invitado';

  @override
  String plusCoinsEarned(int coins) {
    return '¡+$coins Monedas!';
  }

  @override
  String get mission_global_title => 'Maestro de Preguntas';

  @override
  String get mission_global_desc => 'Resuelve un total de X preguntas';

  @override
  String get mission_title_Math => 'Matemáticas';

  @override
  String get mission_desc_Math => 'Resuelve preguntas de matemáticas';

  @override
  String get mission_title_Physics => 'Física';

  @override
  String get mission_desc_Physics => 'Resuelve preguntas de física';

  @override
  String get mission_title_Chemistry => 'Química';

  @override
  String get mission_desc_Chemistry => 'Resuelve preguntas de química';

  @override
  String get mission_title_Biology => 'Biología';

  @override
  String get mission_desc_Biology => 'Resuelve preguntas de biología';

  @override
  String get mission_title_History => 'Historia';

  @override
  String get mission_desc_History => 'Resuelve preguntas de historia';

  @override
  String get mission_title_Geography => 'Geografía';

  @override
  String get mission_desc_Geography => 'Resuelve preguntas de geografía';

  @override
  String get mission_title_Literature => 'Literatura';

  @override
  String get mission_desc_Literature => 'Resuelve preguntas de literatura';

  @override
  String get mission_title_Art => 'Arte';

  @override
  String get mission_desc_Art => 'Resuelve preguntas de arte';

  @override
  String get mission_title_Music => 'Música';

  @override
  String get mission_desc_Music => 'Resuelve preguntas de música';

  @override
  String get mission_title_Sports => 'Deportes';

  @override
  String get mission_desc_Sports => 'Resuelve preguntas de deportes';

  @override
  String get mission_title_Technology => 'Tecnología';

  @override
  String get mission_desc_Technology => 'Resuelve preguntas de tecnología';

  @override
  String get mission_title_Software => 'Software';

  @override
  String get mission_desc_Software => 'Resuelve preguntas de software';

  @override
  String get mission_title_Mechanic => 'Mecánica';

  @override
  String get mission_desc_Mechanic => 'Resuelve preguntas de mecánica';

  @override
  String get mission_title_Religion => 'Religión';

  @override
  String get mission_desc_Religion => 'Resuelve preguntas de religión';

  @override
  String get careerAchievements => 'Carrera y Logros';

  @override
  String get totalAchievements => 'Logros Totales';

  @override
  String get maxLevel => 'MÁX';

  @override
  String get completed => 'Completado';

  @override
  String levelProgress(int current, int total) {
    return 'Nivel $current / $total';
  }

  @override
  String get selectGameMode => 'Seleccionar Modo';

  @override
  String get modeClassic => 'Clásico';

  @override
  String get modeClassicDesc => 'Preguntas fijas, tómate tu tiempo';

  @override
  String get modeTimed => 'Con Tiempo';

  @override
  String get modeTimedDesc => 'Carrera contra el reloj';

  @override
  String get modeEndless => 'Infinito';

  @override
  String get modeEndlessDesc => 'Responde todas las que puedas';

  @override
  String get defaultPlayerName => 'Jugador QuizAlyx';

  @override
  String get editProfileName => 'Editar Nombre';

  @override
  String get enterNewName => 'Introduce tu nuevo nombre';

  @override
  String get save => 'Guardar';

  @override
  String get nameChangeLimitTitle => 'Límite de cambio de nombre';

  @override
  String get nameChangeLimitDesc =>
      'Solo puedes cambiar tu nombre 2 veces cada 14 días. Por favor, inténtalo de nuevo más tarde.';

  @override
  String get ok => 'Aceptar';

  @override
  String get unknownDate => 'Desconocido';

  @override
  String get accountStatus => 'Estado de la cuenta';

  @override
  String get verified => 'Verificado';

  @override
  String get guestAccount => 'Cuenta de Invitado';

  @override
  String get joinedDate => 'Fecha de registro';

  @override
  String get membership => 'Membresía';

  @override
  String get freeTier => 'Gratis';

  @override
  String daysCount(int count) {
    return '$count Días';
  }

  @override
  String get dataLoadError => 'No se pudieron cargar los datos.';

  @override
  String get totalScore => 'Puntuación Total';

  @override
  String get quizzesPlayed => 'Cuestionarios Jugados';

  @override
  String get accuracyRate => 'Tasa de Precisión';

  @override
  String get dailyStreak => 'Racha Diaria';

  @override
  String get enterPlayerNameError =>
      '¡Por favor, introduce un nombre de jugador genial!';

  @override
  String get welcomeToQuizAlyx => '¡Bienvenido a QuizAlyx!';

  @override
  String get chooseAvatarName => 'Elige tu avatar y nombre de jugador.';

  @override
  String get enterPlayerNameHint => 'Introducir Nombre de Jugador';

  @override
  String get startJourney => 'Comenzar Viaje';

  @override
  String get quitQuizTitle => '¿Salir del Quiz?';

  @override
  String get quitQuizDesc =>
      'Tu progreso se perderá. ¿Estás seguro de que quieres volver al inicio?';

  @override
  String get quit => 'Salir';

  @override
  String get no5050JokerWarning => '¡No te quedan comodines 50/50!';

  @override
  String get noTimeFreezeWarning => '¡No te queda Congelación de Tiempo!';

  @override
  String get quiz => 'Quiz';

  @override
  String timeSeconds(int seconds) {
    return 'Tiempo: $seconds s';
  }

  @override
  String questionCounter(int current, int total) {
    return 'Pregunta $current / $total';
  }

  @override
  String get quizCompleted => '¡Quiz Completado!';

  @override
  String get correct => 'Correcto';

  @override
  String get wrong => 'Incorrecto';

  @override
  String get score => 'Puntuación';

  @override
  String get continueBtn => 'Continuar';

  @override
  String get whatsNext => '¿Qué sigue?';

  @override
  String get playAgain => 'Jugar de nuevo';

  @override
  String get backToHome => 'Volver al inicio';

  @override
  String get timesUp => '¡Se acabó el tiempo!';

  @override
  String get language => 'Idioma';

  @override
  String get settingsSaved => '¡Ajustes guardados con éxito!';

  @override
  String get resetHighScoresTitle => '¿Restablecer Puntuaciones?';

  @override
  String get resetHighScoresDesc =>
      'Esto eliminará todas tus mejores puntuaciones. Esta acción no se puede deshacer.';

  @override
  String get reset => 'Restablecer';

  @override
  String get highScoresResetSuccess => '¡Puntuaciones restablecidas con éxito!';

  @override
  String get appearance => 'Apariencia';

  @override
  String get goldTheme => 'Tema Oro';

  @override
  String get premiumGoldLook => 'Aspecto dorado premium';

  @override
  String get unlockInStore => 'Desbloquear en la Tienda';

  @override
  String get diamondTheme => 'Tema Diamante';

  @override
  String get legendaryDiamondLook => 'Aspecto diamante legendario';

  @override
  String get unlockInStore1500 => 'Desbloquear en Tienda (1500 Monedas)';

  @override
  String get gameplay => 'Jugabilidad';

  @override
  String get numberOfQuestions => 'Número de Preguntas';

  @override
  String get timedDurationSec => 'Duración con tiempo (seg)';

  @override
  String get endlessDurationSec => 'Duración infinita (seg)';

  @override
  String get display => 'Pantalla';

  @override
  String get showDifficulty => 'Mostrar Dificultad';

  @override
  String get showDifficultyDesc =>
      'Mostrar nivel de dificultad en cada pregunta';

  @override
  String get actions => 'Acciones';

  @override
  String get saveSettings => 'Guardar Ajustes';

  @override
  String get resetScores => 'Restablecer Puntos';

  @override
  String get visitStoreToUnlock => '¡Visita la Tienda para desbloquear!';

  @override
  String get storeTitle => 'Tienda';

  @override
  String specialBundlePurchased(int remaining) {
    return '¡Paquete Especial Comprado! (Restantes: $remaining)';
  }

  @override
  String get notEnoughCoins => '¡No tienes suficientes monedas!';

  @override
  String get exchangeSuccessful => '¡Intercambio exitoso!';

  @override
  String get notEnoughPoints => '¡No tienes suficientes puntos!';

  @override
  String get themeUnlockedSettings =>
      '¡Tema Desbloqueado! Actívalo en Ajustes.';

  @override
  String itemPurchased(String itemName) {
    return '¡$itemName comprado!';
  }

  @override
  String get currencyExchange => 'CAMBIO DE DIVISAS';

  @override
  String get shopItems => 'ARTÍCULOS DE TIENDA';

  @override
  String get limitedOffer => 'OFERTA LIMITADA';

  @override
  String endsInDays(int days) {
    return 'Termina en $days días';
  }

  @override
  String get megaBoosterPack => 'Mega Paquete Booster';

  @override
  String get boosterPackDesc => '1x Comodín 50/50 + 1x Congelar Tiempo';

  @override
  String remainingLimit(int current, int max) {
    return 'Restante: $current / $max';
  }

  @override
  String get coinsText => 'Monedas';

  @override
  String get convertBtn => 'Convertir';

  @override
  String get joker5050 => 'Comodín 50/50';

  @override
  String get joker5050Desc => 'Elimina 2 opciones incorrectas';

  @override
  String get timeFreeze => 'Congelar Tiempo';

  @override
  String get timeFreezeDesc => 'Detiene el tiempo por 10s';

  @override
  String get premiumTheme => 'Tema Premium';

  @override
  String get unlockGoldTheme => 'Desbloquear Tema Oro';

  @override
  String get unlockDiamondInterface => 'Desbloquear Interfaz Diamante';

  @override
  String get themeUnlocked => 'Tema Desbloqueado';

  @override
  String get owned => 'OBTENIDO';

  @override
  String get selectTopic => 'Seleccionar Tema';

  @override
  String topicDifficulty(String topic) {
    return 'Dificultad: $topic';
  }

  @override
  String get beginner => 'Principiante';

  @override
  String get intermediate => 'Intermedio';

  @override
  String get advanced => 'Avanzado';
}
