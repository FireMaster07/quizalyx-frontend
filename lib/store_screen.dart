import 'package:flutter/material.dart';
import 'main.dart'; // For AppColors
import 'currency_manager.dart';
import 'l10n/app_localizations.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int _coins = 0;
  int _points = 0;
  bool _isLoading = true;

  // Themes
  bool _hasGoldTheme = false;
  bool _hasDiamondTheme = false;

  // SPECIAL OFFER VARIABLES
  int _bundlePurchasedCount = 0;
  final int _bundleMaxLimit = 50;
  late DateTime _offerDeadline; // Instead of a fixed date, we made it dynamic
  bool _isOfferActive = false;

  @override
  void initState() {
    super.initState();
    // NEW: The offer should always end on the last day of the current month
    final now = DateTime.now();
    _offerDeadline = DateTime(now.year, now.month + 1, 0);

    _loadBalances();
  }

  Future<void> _loadBalances() async {
    final c = await CurrencyManager.getCoins();
    final p = await CurrencyManager.getPoints();

    final goldInv = await CurrencyManager.getInventory('theme_gold');
    final diamondInv = await CurrencyManager.getInventory('theme_diamond');

    // We call it from CurrencyManager (It should now be defined there)
    final bundleCount = await CurrencyManager.getSpecialBundleCount();

    // --- SECURITY & OFFER LOGIC ---
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

  // --- 1. SPECIAL BUNDLE PURCHASE FUNCTION ---
  Future<void> _buySpecialBundle() async {
    int cost = 15; // Package Price

    bool success = await CurrencyManager.spendCoins(cost);

    if (success) {
      // Provide contents
      await CurrencyManager.addItem('time_freeze');
      await CurrencyManager.addItem('hint_5050');

      // Increment counter
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
          _buildSectionTitle(AppLocalizations.of(context)!.currencyExchange),
          _buildExchangeCard(100, 10),
          _buildExchangeCard(500, 60),

          const SizedBox(height: 24),

          _buildSectionTitle(AppLocalizations.of(context)!.shopItems),

          // --- MISSING PART 2: Adding the card to the list ---
          _buildSpecialOfferCard(),
          // ------------------------------------------

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

  // --- 3. SPECIAL OFFER CARD WIDGET ---
  Widget _buildSpecialOfferCard() {
    // NEW CHECK: If the offer is not active, or the limit has been reached, DO NOT SHOW IT ON SCREEN (prevents negative values)
    if (!_isOfferActive || _bundlePurchasedCount >= _bundleMaxLimit) {
      return const SizedBox.shrink();
    }

    // Time check
    final daysLeft = _offerDeadline.difference(DateTime.now()).inDays;
    if (daysLeft < 0) {
      return const SizedBox.shrink(); // Extra safety
    }

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
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.boosterPackDesc,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
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
                  onPressed: _buySpecialBundle, // Now always active, because if inactive we shrink above
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: Column(
                    children: [
                      const Text("15", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const Icon(Icons.monetization_on_rounded, size: 14, color: Color(0xFFFFD700)),
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