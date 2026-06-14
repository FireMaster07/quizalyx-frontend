import 'package:flutter/material.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'settings_screen.dart';
import 'leaderboards_screen.dart';
import 'main.dart';
import 'topic_selection_screen.dart';
import 'missions_screen.dart';
import 'mission_manager.dart';
import 'store_screen.dart';
import 'mode_selection_screen.dart';
import 'package:ntp/ntp.dart'; // For real internet time
import 'package:shared_preferences/shared_preferences.dart'; // For data storage
import 'package:firebase_auth/firebase_auth.dart'; // Required to recognize FirebaseAuth
import 'auth_service.dart'; // Required for the sign-out function
import 'my_account_screen.dart';
import 'my_statistics_screen.dart';
import 'login_screen.dart';
import 'l10n/app_localizations.dart';
import 'audio_manager.dart'; // ADDED
import 'avatar_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _hasInternet = true;
  List<Mission> activeNotifications = [];

  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _checkConnection();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _pulseController.stop();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!kIsWeb) {
        AudioManager.instance.playHomeMusic(); // CALLED FROM CENTRAL
      }
      _checkDailyReward(); // Start daily reward check
    });
  }

  // Determines whether the device has internet access by pinging Google
  Future<void> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (mounted) setState(() => _hasInternet = true);
      }
    } on SocketException catch (_) {
      if (mounted) {
        setState(() => _hasInternet = false);

        // --- CRITICAL UPDATE HERE ---
        // If there is a logged-in Firebase user on the device, show this warning.
        // If the user is already a guest (currentUser is null), don’t bother them with repeated alerts!
        if (FirebaseAuth.instance.currentUser != null) {
          _showOfflineDialog();
        }
      }
    }
  }

  void _showOfflineDialog() {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing by tapping outside, user must choose
      builder: (BuildContext context) {
        return Align(
          // HERE’S THAT FINE-TUNING YOU WANTED: Horizontally centered (0), vertically slightly above center (-0.2)
          alignment: const Alignment(0, -0.2),
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.surfaceLight, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Warning Icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.wifi_off_rounded,
                      color: AppColors.error,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    AppLocalizations.of(context)!.offlineTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Description (As you wanted, in English)
                  Text(
                    AppLocalizations.of(context)!.offlineDesc,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Play as Guest Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Closes the dialog; in the background we already masked as guest, game continues normally
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.playAsGuest,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Retry Button (Extra industry standard: maybe user wants to enable Wi-Fi and try again)
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close
                        _checkConnection(); // Check connection again
                      },
                      child: Text(
                        AppLocalizations.of(context)!.retry,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _showExitConfirmDialog() async {
    return await showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.exit_to_app_rounded,
                    color: AppColors.error,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.exitTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.exitDesc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          key: const ValueKey(
                            'dialog_exit_cancel_button',
                          ), // ADDED
                          onPressed: () => Navigator.of(context).pop(false),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white24),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                          ), // UPDATED
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          key: const ValueKey(
                            'dialog_exit_confirm_button',
                          ), // ADDED
                          onPressed: () => Navigator.of(context).pop(true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.exit,
                          ), // UPDATED
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ) ??
        false;
  }

  void _checkCompletedMissions() {
    if (MissionManager.completedMissionsQueue.isNotEmpty) {
      setState(() {
        activeNotifications.addAll(MissionManager.completedMissionsQueue);
        MissionManager.completedMissionsQueue.clear();
      });

      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            activeNotifications.clear();
          });
        }
      });
    }
  }

  // --- SECURE DAILY REWARD SYSTEM (Cheat-Protected) ---

  Future<void> _checkDailyReward() async {
    final prefs = await SharedPreferences.getInstance();

    // 1. PROTECTION: We try to obtain the real time from the internet
    DateTime now;
    try {
      // Fetch the real time from Google servers using the NTP package
      // The lookUpAddress parameter is optional, but the default can sometimes be slow.
      now = await NTP.now();
    } catch (e) {
      // If there is no internet connection or the NTP server cannot be reached:
      // To avoid risk, we either do not give the reward or use the local time.
      // IF YOU WANT ABSOLUTE PROTECTION: return; (No internet means no reward)
      debugPrint('Internet time could not be retrieved, reward check skipped.');
      return;
    }

    // Convert the date to "YYYY-MM-DD" format (Now the 'now' variable holds the real internet time)
    final today =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    // Retrieve the saved data
    final lastRewardDate = prefs.getString('last_reward_date');

    // If today’s reward has already been claimed, exit
    if (lastRewardDate == today) return;

    // If the reward has not been claimed, show the Dialog
    if (mounted) {
      _showDailyRewardDialog(
        prefs,
        today,
        lastRewardDate,
        now,
      ); // We also send the 'now' variable
    }
  }

  // Let’s make a small update to the Dialog function so it accepts the 'now' parameter
  // Because the "Did you log in yesterday?" check must also be done according to the REAL time.
  void _showDailyRewardDialog(
    SharedPreferences prefs,
    String today,
    String? lastDate,
    DateTime trueNow,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.amber, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.monetization_on_rounded,
                    color: Colors.amber,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.dailyRewardTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.dailyRewardDesc,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.plus5Coins,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    key: const ValueKey('daily_reward_collect_button'), // ADDED
                    onPressed: () async {
                      // 1. Add coin
                      int currentCoins = prefs.getInt('user_coins') ?? 0;
                      await prefs.setInt('user_coins', currentCoins + 5);

                      // 2. Streak Calculation – PROTECTED
                      int currentStreak = prefs.getInt('daily_streak') ?? 0;

                      if (lastDate != null) {
                        // We determine yesterday based on trueNow (the internet time)
                        final yesterday = trueNow.subtract(
                          const Duration(days: 1),
                        );
                        final yesterdayString =
                            "${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";

                        if (lastDate == yesterdayString) {
                          currentStreak++;
                        } else {
                          currentStreak = 1; // The streak is broken
                        }
                      } else {
                        currentStreak = 1; // First login
                      }

                      await prefs.setInt('daily_streak', currentStreak);
                      await prefs.setString('last_reward_date', today);

                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.success,
                            content: Row(
                              children: [
                                const Icon(
                                  Icons.local_fire_department_rounded,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  // (Since this is a variable, we will send it as a function, I’ll adjust the ARB accordingly)
                                  AppLocalizations.of(
                                    context,
                                  )!.currentStreak(currentStreak),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.collect,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _showExitConfirmDialog();
        if (shouldExit) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        // 1. CRITICAL SETTING: Ensures the body extends behind the AppBar (so the gradient isn’t cut off)
        extendBodyBehindAppBar: true,

        // 2. DRAWER CONNECTION: We link the menu from the previous message here
        endDrawer: _buildProfileDrawer(),

        // 3. APPBAR ADDITION
        appBar: AppBar(
          // Make the background transparent and remove shadow so it doesn’t break the layout
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "QuizAlyx",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            Builder(
              builder: (context) {
                final user = FirebaseAuth.instance.currentUser;

                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () => Scaffold.of(context).openEndDrawer(),
                    child: user == null
                        ? CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.primary,
                            child: Icon(Icons.person, color: Colors.white),
                          )
                        : FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data!.exists) {
                                int avatarIndex =
                                    (snapshot.data!.data()
                                        as Map<
                                          String,
                                          dynamic
                                        >)['avatarIndex'] ??
                                    0;
                                return AvatarHelper.buildAvatar(
                                  avatarIndex,
                                  radius: 18,
                                );
                              }
                              return CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColors.primary,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            },
                          ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.5,
                  colors: [
                    AppColors.primary.withOpacity(0.15),
                    AppColors.background,
                    AppColors.background,
                  ],
                ),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            _buildHeader(),
                            Expanded(child: Container()),
                            _buildMainContent(),
                            Expanded(child: Container()),
                            _buildBottomNavigation(),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (activeNotifications.isNotEmpty)
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: activeNotifications.map((mission) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: AppColors.success,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // If you haven’t added a key for "MISSION COMPLETED!", you can write it directly here
                                    // Or you can add 'mission_completed' to the dictionary.
                                    // For now, keep "MISSION COMPLETED!" as is, or use a translation if available.
                                    AppLocalizations.of(
                                      context,
                                    )!.missionCompleted,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    // FIX: use mission.titleKey instead of mission.title
                                    mission.titleKey,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  activeNotifications.remove(mission);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDrawer() {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    // ENGINEERING TRICK: Even if an account is open in Firebase, if there is no internet, make the user "null" (Guest)!
    final user = _hasInternet ? firebaseUser : null;

    // Checking if the user is a guest
    final bool isGuest = user == null;

    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          // 1. Profile Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            accountName: Text(
              user?.displayName ??
                  AppLocalizations.of(
                    context,
                  )!.guestPlayer, // Updated for guest
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(
              user?.email ??
                  AppLocalizations.of(
                    context,
                  )!.notLoggedIn, // Updated for guest
              style: TextStyle(color: AppColors.textSecondary),
            ),
            currentAccountPicture: isGuest
                ? CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  )
                : FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.exists) {
                        int avatarIndex =
                            (snapshot.data!.data()
                                as Map<String, dynamic>)['avatarIndex'] ??
                            0;
                        return AvatarHelper.buildAvatar(
                          avatarIndex,
                          radius: 35,
                        );
                      }
                      return CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
          ),

          // 2. Menu Options
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.manage_accounts,
                    color: Colors.white,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.myAccount,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // THIS PART UPDATED: Just like MyAccount, we also pass the user information here
                        builder: (context) => MyAccountScreen(user: user),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.leaderboard, color: Colors.white),
                  title: Text(
                    AppLocalizations.of(context)!.myStatistics,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyStatisticsScreen(user: user),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // 3. Dynamic Login/Logout Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                // If guest, Primary (Purple) color; if logged in, Error (Red) color is assigned
                backgroundColor: isGuest
                    ? AppColors.primary.withOpacity(0.2)
                    : AppColors.error.withOpacity(0.2),
                foregroundColor: isGuest
                    ? AppColors.primaryLight
                    : AppColors.error,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // Icon set dynamically
              icon: Icon(isGuest ? Icons.login_rounded : Icons.logout_rounded),
              // Text set dynamically
              label: Text(
                isGuest
                    ? AppLocalizations.of(context)!.loginSignup
                    : AppLocalizations.of(context)!.logOut,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                Navigator.pop(context); // Drawer is closed

                if (isGuest) {
                  // If user is guest, directly navigated to LoginScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                } else {
                  // If user is logged in, session is terminated and redirected
                  await AuthService().signOut();
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(Icons.quiz_rounded, size: 45, color: Colors.white),
        ),
        const SizedBox(height: 24),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
          ).createShader(bounds),
          child: Text(
            'QUIZALYX',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 40,
              letterSpacing: 4,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.appSlogan,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    // No more condition, no animation. We directly call the button.
    return _buildStartButton();
  }

  // --- NEW VERSION ---
  Widget _buildStartButton() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: GestureDetector(
            // Start Button inside HomeScreen
            key: const ValueKey('start_quiz_button'), // ADDED
            onTap: () {
              // The showDialog function opens a layer on top of the screen (Popup)
              showDialog(
                context: context,
                barrierDismissible:
                    true, // Should it close when tapping the empty background? (Yes)
                barrierColor: Colors.black.withOpacity(
                  0.7,
                ), // How much should we darken the background?
                builder: (BuildContext context) {
                  // We now delegate the job of stopping music to our central manager (AudioManager)
                  return ModeSelectionDialog(
                    onStopMusic: () => AudioManager.instance.stopMusic(),
                  );
                },
              ).then((_) {
                // This runs when the window is closed (after returning from quiz or canceling)
                _checkCompletedMissions();
                AudioManager.instance
                    .playHomeMusic(); // AFTER QUIZ, CONTINUE MAIN MUSIC
              });
            },
            child: Container(
              // ... (Your design code stays the same) ...
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)!.startQuiz,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavButton(
            keyName: 'nav_sound_button', // ADDED
            icon:
                AudioManager
                    .instance
                    .isSoundOn // READ FROM CENTRAL VARIABLE
                ? Icons.volume_up_rounded
                : Icons.volume_off_rounded,
            onTap: () async {
              await AudioManager.instance
                  .toggleSound(); // TRIGGER CENTRAL FUNCTION
              setState(() {}); // Refresh screen so the icon updates
            },
          ),
          _buildNavButton(
            keyName: 'nav_missions_button', // ADDED
            icon: Icons.assignment_turned_in_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MissionsScreen()),
              );
            },
          ),
          _buildNavButton(
            keyName: 'nav_leaderboard_button', // ADDED
            icon: Icons.leaderboard_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LeaderboardsScreen()),
              );
            },
          ),
          _buildNavButton(
            keyName: 'nav_store_button', // ADDED
            icon: Icons.store_mall_directory_rounded, // Store icon
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StoreScreen()),
              );
            },
          ),
          _buildNavButton(
            keyName: 'nav_settings_button', // ADDED
            icon: Icons.settings_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required String keyName, // 1. ADDED: Unique identifier for Espresso
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      key: ValueKey(keyName), // 2. ADDED: Key assignment done
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Icon(icon, color: AppColors.textSecondary, size: 25),
      ),
    );
  }
}
