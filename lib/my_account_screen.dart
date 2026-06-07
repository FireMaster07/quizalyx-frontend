import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'main.dart';
import 'l10n/app_localizations.dart';
import 'package:intl/intl.dart'; // For date translations

/// We use StatefulWidget because the user's name can change dynamically
/// and we need the UI to reflect this change immediately.
class MyAccountScreen extends StatefulWidget {
  final User? user; // Receives the currently logged-in user data

  const MyAccountScreen({super.key, required this.user});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  // Holds the name that is currently displayed on the screen
  late String _currentDisplayName;

  @override
  void initState() {
    super.initState();
    // Initialize the display name with the user's current Firebase name.
    // Fallback to "QuizAlyx Player" if the name is null.
    _currentDisplayName = widget.user?.displayName ?? "";
  }

  /// Displays a dialog that allows the user to edit their profile name.
  /// Includes rate limiting logic (max 2 changes per 14 days) via AuthService.
  Future<void> _showEditNameDialog() async {
    TextEditingController nameController = TextEditingController(
        text: _currentDisplayName.isEmpty ? AppLocalizations.of(context)!.defaultPlayerName : _currentDisplayName
    );
    bool isSaving = false; // Tracks the loading state during the database update

    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by tapping outside
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.surface,
              title: Text(AppLocalizations.of(context)!.editProfileName, style: const TextStyle(color: Colors.white)),
              content: TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterNewName,
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.surfaceLight)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                ),
              ),
              actions: [
                // Cancel Button
                TextButton(
                  onPressed: isSaving ? null : () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: Colors.grey)),
                ),
                // Save Button (Turns into a loading spinner when saving)
                isSaving
                    ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                )
                    : TextButton(
                  onPressed: () async {
                    String newName = nameController.text.trim();

                    // Proceed only if the name is not empty and is actually different
                    if (newName.isNotEmpty && newName != _currentDisplayName) {
                      setDialogState(() => isSaving = true); // Trigger loading animation

                      // 🚀 Update the name across Auth, Users, and Leaderboard collections
                      String result = await AuthService().syncUserName(newName);

                      if (mounted) Navigator.pop(context); // Close the input dialog

                      // Handle the result of the update process
                      if (result == "limit_reached") {
                        // Show a warning if the user exceeded their name change limit
                        if (mounted) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              backgroundColor: AppColors.surface,
                              title: Text(AppLocalizations.of(context)!.nameChangeLimitTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              content: Text(
                                AppLocalizations.of(context)!.nameChangeLimitDesc,
                                style: TextStyle(color: Colors.white70),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: Text(AppLocalizations.of(context)!.ok, style: TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          );
                        }
                      } else if (result == "success") {
                        // Update the local state so the UI reflects the new name instantly
                        setState(() {
                          _currentDisplayName = newName;
                        });
                      }
                    } else {
                      // If the name wasn't changed or is empty, just close the dialog
                      if (mounted) Navigator.pop(context);
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.save, style: TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format the account creation date nicely (e.g., "Oct 2025")
    String joinedDate = AppLocalizations.of(context)!.unknownDate;
    if (widget.user?.metadata.creationTime != null) {
      final date = widget.user!.metadata.creationTime!;
      // HERE’S THE MAGIC! It automatically recognizes and formats all months in 15 languages:
      joinedDate = DateFormat.yMMM(Localizations.localeOf(context).languageCode).format(date);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.myAccount, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Radial Gradient Background Effect
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.5,
                colors: [
                  AppColors.primary.withValues(alpha: 0.15),
                  AppColors.background,
                  AppColors.background,
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Profile Avatar Section
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
                        boxShadow: [
                          BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 2)
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.surface,
                        backgroundImage: widget.user?.photoURL != null ? NetworkImage(widget.user!.photoURL!) : null,
                        child: widget.user?.photoURL == null ? const Icon(Icons.person, size: 60, color: Colors.white) : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Display Name and Edit Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          _currentDisplayName.isEmpty ? AppLocalizations.of(context)!.defaultPlayerName : _currentDisplayName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      // Only show the edit button if the user is authenticated (not a guest)
                      if (widget.user != null)
                        IconButton(
                          icon: Icon(Icons.edit, color: AppColors.primaryLight, size: 20),
                          onPressed: _showEditNameDialog,
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // User Email Display
                  Text(
                    widget.user?.email ?? "player@quizalyx.com",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),

                  // Account Information Card (Status, Date, Membership)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.surfaceLight, width: 1),
                    ),
                    child: Column(
                      children: [
                        _buildAccountInfoRow(Icons.verified_user_rounded, AppLocalizations.of(context)!.accountStatus, widget.user != null ? AppLocalizations.of(context)!.verified : AppLocalizations.of(context)!.guestAccount, widget.user != null ? AppColors.success : Colors.grey),
                        const Divider(color: AppColors.surfaceLight, height: 32),
                        _buildAccountInfoRow(Icons.calendar_month_rounded, AppLocalizations.of(context)!.joinedDate, joinedDate, Colors.white),
                        const Divider(color: AppColors.surfaceLight, height: 32),
                        _buildAccountInfoRow(Icons.workspace_premium_rounded, AppLocalizations.of(context)!.membership, AppLocalizations.of(context)!.freeTier, AppColors.accentOrange),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build consistent info rows inside the account card.
  /// Wraps the value text in a Tooltip so long texts can be read on tap.
  Widget _buildAccountInfoRow(IconData icon, String title, String value, Color valueColor) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryLight, size: 24),
        const SizedBox(width: 16),
        Text(title, style: const TextStyle(fontSize: 16, color: Colors.white70)),
        const SizedBox(width: 16),
        Expanded(
          child: Tooltip(
            message: value,
            triggerMode: TooltipTriggerMode.tap,
            preferBelow: false,
            showDuration: const Duration(seconds: 3),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary, width: 1),
            ),
            textStyle: const TextStyle(color: Colors.white, fontSize: 14),
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: valueColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}