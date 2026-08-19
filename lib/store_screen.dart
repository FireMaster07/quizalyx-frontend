import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart'; // YORUMA ALINDI: Reklamlar kapalı test sonrası eklenecek
import 'main.dart'; // For AppColors
import 'currency_manager.dart';
import 'l10n/app_localizations.dart';
// import 'dart:io'; // YORUMA ALINDI: Sadece reklam internet kontrolü için lazımdı

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // ESPRESSO TEST FLAG: Can be set to true in the test environment to completely disable ads.
  // static bool disableAdsForTesting = false; // YORUMA ALINDI

  int _coins = 0;
  int _points = 0;
  bool _isLoading = true;

  bool _hasGoldTheme = false;
  bool _hasDiamondTheme = false;

  int _bundlePurchasedCount = 0;
  final int _bundleMaxLimit = 50;
  late DateTime _offerDeadline;
  bool _isOfferActive = false;

  // ADMOB VARIABLES (YORUMA ALINDI)
  // RewardedAd? _rewardedAd;
  // bool _isRewardedAdReady = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _offerDeadline = DateTime(now.year, now.month + 1, 0);

    _loadBalances();
    // _loadRewardedAd(); // Start preloading the ad (YORUMA ALINDI)
  }

  /* --- ADMOB LOADING AND DISPLAYING FUNCTIONS (YORUMA ALINDI) ---
  void _loadRewardedAd() {
    if (disableAdsForTesting) return; // Cancel loading if in test mode

    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917', // ANDROID TEST ID (To be changed before publishing)
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _loadRewardedAd(); // Load a new ad when the user closes the ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _loadRewardedAd(); // Load a new ad if there is a display error
            },
          );

          if (mounted) {
            setState(() {
              _rewardedAd = ad;
              _isRewardedAdReady = true;
            });
          }
        },
        onAdFailedToLoad: (error) {
          debugPrint('Failed to load Rewarded Ad: $error');
          _isRewardedAdReady = false;
        },
      ),
    );
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void _showNoInternetDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // Main Content Box
                Container(
                  margin: const EdgeInsets.only(top: 16), // Space for the badge above
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                  decoration: BoxDecoration(
                    color: AppColors.surface, // QuizAlyx dark surface color
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purpleAccent.withOpacity(0.5), width: 1.5),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 15, spreadRadius: 5)
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off_rounded, color: Colors.redAccent, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)?.noInternetMessage ?? "You are not connected to the internet. Please check your connection and try again.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.4),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary, // QuizAlyx purple
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            AppLocalizations.of(context)?.okButton ?? "OK",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Top-Center Frame Text (Badge)
                Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.redAccent, Colors.deepOrange]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.redAccent.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3))
                      ],
                    ),
                    child: Text(
                      AppLocalizations.of(context)?.videoCannotBePlayed ?? "Video cannot be played!",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  void _showRewardedAd() async {
    // 1. FIRST CHECK INTERNET
    bool hasInternet = await _hasInternetConnection();
    if (!hasInternet) {
      _showNoInternetDialog();
      return; // If there is no internet, stop the function here, don’t go further
    }

    // 2. THEN CHECK IF AD IS READY
    if (!_isRewardedAdReady || _rewardedAd == null) {
      _showSnack(AppLocalizations.of(context)?.adNotReady ?? "Ad is not ready yet, please wait a moment.", Colors.orange);
      return;
    }

    // 3. SHOW THE AD
    _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
      // REWARD PROCESS (e.g., giving 3 Coins)
      await CurrencyManager.addCoins(3); // User finished the ad, give the reward

      debugPrint("User watched the ad and earned the reward!");
      _loadBalances();

      if (mounted) {
        _showSnack(AppLocalizations.of(context)?.rewardEarned ?? "Congratulations! You earned free coins.", Colors.green);
      }
    });

    setState(() {
      _isRewardedAdReady = false;
      _rewardedAd = null;
    });
  }
  ---------------------------------------------- */

  Future<void> _loadBalances() async {
    final c = await CurrencyManager.getCoins();
    final p = await CurrencyManager.getPoints();

    final goldInv = await CurrencyManager.getInventory('theme_gold');
    final diamondInv = await CurrencyManager.getInventory('theme_diamond');
    final bundleCount = await CurrencyManager.getSpecialBundleCount();

    final now = DateTime.now();
    bool isCheating = await CurrencyManager.isDateManipulated();

    bool active = now.isBefore(_offerDeadline) &&
        (bundleCount < _bundleMaxLimit) &&
        !isCheating;

    if (mounted) {
      setState(() {
        _coins = c;
        _points = p;
        _hasGoldTheme = goldInv > 0;
        _hasDiamondTheme = diamondInv > 0;
        _bundlePurchasedCount = bundleCount;
        _isOfferActive = active;
        _isLoading = false;
      });

      if (isCheating && now.isBefore(_offerDeadline)) {
        debugPrint("Security Alert: Time manipulation detected. Offer disabled.");
      }
    }
  }

  Future<void> _buySpecialBundle() async {
    int cost = 15;
    bool success = await CurrencyManager.spendCoins(cost);

    if (success) {
      await CurrencyManager.addItem('time_freeze');
      await CurrencyManager.addItem('hint_5050');
      await CurrencyManager.incrementSpecialBundleCount();

      if (mounted) _showSnack(AppLocalizations.of(context)!.specialBundlePurchased(_bundleMaxLimit - _bundlePurchasedCount - 1), Colors.purpleAccent);
      _loadBalances();
    } else {
      if (mounted) _showSnack(AppLocalizations.of(context)!.notEnoughCoins, Colors.red);
    }
  }

  Future<void> _exchangePoints(int costPoints, int gainCoins) async {
    bool success = await CurrencyManager.convertPointsToCoins(costPoints, gainCoins);
    if (success) {
      _loadBalances();
      if (mounted) _showSnack(AppLocalizations.of(context)!.exchangeSuccessful, Colors.green);
    } else {
      if (mounted) _showSnack(AppLocalizations.of(context)!.notEnoughPoints, Colors.red);
    }
  }

  Future<void> _buyItem(String itemName, String itemKey, int costCoins) async {
    if (itemKey == 'theme_gold' && _hasGoldTheme) return;
    if (itemKey == 'theme_diamond' && _hasDiamondTheme) return;

    bool success = await CurrencyManager.spendCoins(costCoins);

    if (success) {
      await CurrencyManager.addItem(itemKey);

      if (itemKey == 'theme_gold' || itemKey == 'theme_diamond') {
        if (mounted) _showSnack(AppLocalizations.of(context)!.themeUnlockedSettings, Colors.amber);
      } else {
        if (mounted) _showSnack(AppLocalizations.of(context)!.itemPurchased(itemName), Colors.green);
      }
      _loadBalances();
    } else {
      if (mounted) _showSnack(AppLocalizations.of(context)!.notEnoughCoins, Colors.red);
    }
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color, duration: const Duration(seconds: 2)),
    );
  }

  @override
  void dispose() {
    // _rewardedAd?.dispose(); // YORUMA ALINDI
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text(AppLocalizations.of(context)!.storeTitle),
        actions: [
          if (!_isLoading)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  Icon(Icons.stars_rounded, color: AppColors.accentBlue, size: 18),
                  const SizedBox(width: 4),
                  Text('$_points', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  Container(width: 1, height: 16, color: Colors.white24),
                  const SizedBox(width: 12),
                  const Icon(Icons.monetization_on_rounded, color: Color(0xFFFFD700), size: 18),
                  const SizedBox(width: 4),
                  Text('$_coins', style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // 1. FREE REWARDS SECTION (YORUMA ALINDI)
          // _buildSectionTitle(AppLocalizations.of(context)?.freeRewards ?? "FREE REWARDS"),
          // _buildFreeRewardCard(),
          // const SizedBox(height: 24),

          // 2. CURRENCY EXCHANGE SECTION
          _buildSectionTitle(AppLocalizations.of(context)!.currencyExchange),
          _buildExchangeCard(100, 10),
          _buildExchangeCard(500, 60),
          const SizedBox(height: 24),

          // 3. SHOP ITEMS SECTION
          _buildSectionTitle(AppLocalizations.of(context)!.shopItems),
          _buildSpecialOfferCard(),
          _buildShopItem(
            icon: Icons.lightbulb_rounded,
            name: AppLocalizations.of(context)!.joker5050,
            itemKey: 'hint_5050',
            desc: AppLocalizations.of(context)!.joker5050Desc,
            price: 50,
            color: AppColors.accentOrange,
          ),
          _buildShopItem(
            icon: Icons.timer_off_rounded,
            name: AppLocalizations.of(context)!.timeFreeze,
            itemKey: 'time_freeze',
            desc: AppLocalizations.of(context)!.timeFreezeDesc,
            price: 100,
            color: AppColors.accentBlue,
          ),
          _buildShopItem(
            icon: Icons.palette_rounded,
            name: AppLocalizations.of(context)!.premiumTheme,
            itemKey: 'theme_gold',
            desc: AppLocalizations.of(context)!.unlockGoldTheme,
            price: 500,
            color: AppColors.accentPink,
          ),
          _buildShopItem(
            icon: Icons.diamond_rounded,
            name: AppLocalizations.of(context)!.diamondTheme,
            itemKey: 'theme_diamond',
            desc: AppLocalizations.of(context)!.unlockDiamondInterface,
            price: 1500,
            color: const Color(0xFF00E5FF),
          )
        ],
      ),
    );
  }

  /* --- NEW WIDGET: FREE AD CARD (YORUMA ALINDI) ---
  Widget _buildFreeRewardCard() {
    if (disableAdsForTesting) return const SizedBox.shrink(); // Hide in test mode

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.play_circle_fill_rounded, color: Colors.greenAccent, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)?.watchAd ?? "Watch Video", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(AppLocalizations.of(context)?.watchAdDesc ?? "Earn free coins", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _isRewardedAdReady ? _showRewardedAd : null,
            icon: const Icon(Icons.monetization_on_rounded, size: 16, color: Color(0xFFFFD700)),
            label: const Text("+3"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.withOpacity(0.2),
              foregroundColor: Colors.greenAccent,
              disabledBackgroundColor: Colors.white10,
              disabledForegroundColor: Colors.white30,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }
  -------------------------------------------------- */

  Widget _buildSpecialOfferCard() {
    if (!_isOfferActive || _bundlePurchasedCount >= _bundleMaxLimit) {
      return const SizedBox.shrink();
    }
    final daysLeft = _offerDeadline.difference(DateTime.now()).inDays;
    if (daysLeft < 0) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.purple, Colors.blueAccent]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.purple.withOpacity(0.4), blurRadius: 15, spreadRadius: 2)
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(AppLocalizations.of(context)!.limitedOffer, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                Text(
                  AppLocalizations.of(context)!.endsInDays(daysLeft),
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Stack(
                  children: [
                    Icon(Icons.lightbulb_rounded, color: AppColors.accentOrange, size: 40),
                    Positioned(
                        right: 0, bottom: 0,
                        child: Icon(Icons.timer, color: AppColors.accentBlue, size: 25)
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.megaBoosterPack,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.boosterPackDesc,
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.remainingLimit(_bundleMaxLimit - _bundlePurchasedCount, _bundleMaxLimit),
                        style: const TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _buySpecialBundle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: const Column(
                    children: [
                      Text("15", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Icon(Icons.monetization_on_rounded, size: 14, color: Color(0xFFFFD700)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }

  Widget _buildExchangeCard(int cost, int gain) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.stars_rounded, color: AppColors.accentBlue),
                  const SizedBox(width: 8),
                  Text("$cost ${AppLocalizations.of(context)!.pts}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.arrow_forward_rounded, color: Colors.white24, size: 16)),
                  const Icon(Icons.monetization_on_rounded, color: Color(0xFFFFD700)),
                  const SizedBox(width: 8),
                  Text("$gain ${AppLocalizations.of(context)!.coinsText}", style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => _exchangePoints(cost, gain),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(AppLocalizations.of(context)!.convertBtn),
          ),
        ],
      ),
    );
  }

  Widget _buildShopItem({
    required IconData icon,
    required String name,
    required String itemKey,
    required String desc,
    required int price,
    required Color color,
  }) {
    bool isOwned = false;
    if (itemKey == 'theme_gold' && _hasGoldTheme) isOwned = true;
    if (itemKey == 'theme_diamond' && _hasDiamondTheme) isOwned = true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: isOwned ? Colors.green.withOpacity(0.3) : Colors.white.withOpacity(0.05)
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(isOwned ? AppLocalizations.of(context)!.themeUnlocked : desc, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: isOwned ? null : () => _buyItem(name, itemKey, price),
            icon: isOwned ? const Icon(Icons.check, size: 16) : const Icon(Icons.monetization_on_rounded, size: 16),
            label: Text(isOwned ? AppLocalizations.of(context)!.owned : '$price'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isOwned ? Colors.white10 : const Color(0xFFFFD700),
              foregroundColor: isOwned ? Colors.green : Colors.black,
              disabledBackgroundColor: Colors.white10,
              disabledForegroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }
}