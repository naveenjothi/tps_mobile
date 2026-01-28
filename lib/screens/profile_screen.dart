import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/models/models.dart';
import '../core/providers/providers.dart';
import '../core/theme/theme.dart';
import '../core/widgets/widgets.dart';
import '../core/utils/logger.dart';
import 'profile_edit_sheet.dart';

/// Profile Screen
///
/// Displays user profile information with edit functionality.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentDbUserProvider);

    return Scaffold(
      backgroundColor: TPSColors.charcoal,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: TPSColors.charcoal,
        elevation: 0,
        centerTitle: true,
      ),
      body: userAsync.when(
        data: (user) {
          TPSLogger.debug('User: ${user?.toJson()}', tag: 'ProfileScreen');
          if (user == null) {
            return const Center(child: Text("User not found."));
          }
          return _ProfileContent(user: user);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _ProfileContent extends ConsumerWidget {
  final TPSUser user;

  const _ProfileContent({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: TPSSpacing.pagePadding,
      child: Column(
        children: [
          Center(child: _ProfileHeader(user: user)),
          const SizedBox(height: 48),

          // Options List
          Container(
            decoration: BoxDecoration(
              color: TPSColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: TPSColors.glassBorder.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                _OptionTile(
                  label: "Edit Profile",
                  icon: Icons.edit_outlined,
                  onTap: () => ProfileEditSheet.show(context, user),
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          TPSButton.ghost(
            label: "Sign Out",
            icon: Icons.logout,
            onPressed: () async {
              final authService = ref.read(authServiceProvider);
              await authService.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final TPSUser user;

  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    final hasPhoto = user.photoUrl != null && user.photoUrl!.isNotEmpty;
    final initials = _getInitials();

    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: TPSColors.cyan.withValues(alpha: 0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: TPSColors.cyan.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: TPSColors.surfaceElevated,
            backgroundImage: hasPhoto ? NetworkImage(user.photoUrl!) : null,
            child: !hasPhoto
                ? Text(
                    initials,
                    style: TPSTypography.textTheme.displayMedium?.copyWith(
                      color: TPSColors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "${user.firstName ?? ''} ${user.lastName ?? ''}".trim(),
          style: TPSTypography.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (user.userName != null) ...[
          const SizedBox(height: 4),
          Text(
            "@${user.userName}",
            style: TPSTypography.textTheme.bodyMedium?.copyWith(
              color: TPSColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  String _getInitials() {
    final first = (user.firstName ?? "").trim();
    final last = (user.lastName ?? "").trim();
    String initials = "";
    if (first.isNotEmpty) initials += first[0].toUpperCase();
    if (last.isNotEmpty) initials += last[0].toUpperCase();
    return initials.isEmpty ? "?" : initials;
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: TPSColors.cyan.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: TPSColors.cyan, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TPSTypography.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: TPSColors.textTertiary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
