import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/theme.dart';
import 'core/widgets/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style for dark mode
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: TPSColors.charcoal,
    ),
  );

  runApp(const ProviderScope(child: TPSApp()));
}

/// TPS - The Private Streamer
///
/// Root application widget with the TPS design system.
class TPSApp extends StatelessWidget {
  const TPSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPS - The Private Streamer',
      debugShowCheckedModeBanner: false,
      theme: TPSTheme.dark,
      darkTheme: TPSTheme.dark,
      themeMode: ThemeMode.dark,
      home: const DashboardScreen(),
    );
  }
}

/// Sample Dashboard Screen
///
/// Demonstrates the TPS design system with:
/// - Bento Grid layout
/// - Glassmorphism cards
/// - Electric Cyan accents
/// - 2026 Soft Dark Mode aesthetic
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TPS',
                    style: TPSTypography.textTheme.headlineLarge?.copyWith(
                      color: TPSColors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'The Private Streamer',
                    style: TPSTypography.textTheme.labelSmall?.copyWith(
                      color: TPSColors.muted,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {},
                ),
              ],
            ),

            // Content
            SliverPadding(
              padding: TPSSpacing.pagePadding,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Connection Status Card
                  _buildConnectionCard(),
                  TPSSpacing.vGapLg,

                  // Section Header
                  _buildSectionHeader('Dashboard', 'Your Music Hub'),
                  TPSSpacing.vGapMd,

                  // Bento Grid Layout
                  TPSBentoGrid(
                    items: [
                      // Recently Played - Large card
                      TPSBentoItem.large(
                        height: 180,
                        child: _buildRecentlyPlayedCard(),
                      ),

                      // Top Favorites
                      TPSBentoItem.standard(
                        child: _buildStatCard(
                          icon: Icons.favorite_rounded,
                          iconColor: TPSColors.lilac,
                          title: 'Favorites',
                          value: '24',
                          subtitle: 'songs saved',
                        ),
                      ),

                      // Library Size
                      TPSBentoItem.standard(
                        child: _buildStatCard(
                          icon: Icons.library_music_rounded,
                          iconColor: TPSColors.cyan,
                          title: 'Library',
                          value: '1,247',
                          subtitle: 'tracks available',
                        ),
                      ),

                      // Quick Actions
                      TPSBentoItem.large(
                        height: 120,
                        child: _buildQuickActionsCard(),
                      ),
                    ],
                  ),

                  TPSSpacing.vGapXl,

                  // Empty State Demo
                  _buildSectionHeader('Favorites', 'Songs you love'),
                  TPSSpacing.vGapMd,

                  TPSCard.surface(
                    child: TPSEmptyState.favorites(onAction: () {}),
                  ),

                  TPSSpacing.vGapXl,

                  // Button Demos
                  _buildSectionHeader('Controls', 'Primary Actions'),
                  TPSSpacing.vGapMd,

                  TPSButton.primary(
                    label: 'Connect to Source',
                    icon: Icons.wifi_rounded,
                    onPressed: () {},
                  ),
                  TPSSpacing.vGapMd,

                  Row(
                    children: [
                      Expanded(
                        child: TPSButton.secondary(
                          label: 'Favorites',
                          icon: Icons.favorite_rounded,
                          onPressed: () {},
                        ),
                      ),
                      TPSSpacing.hGapMd,
                      Expanded(
                        child: TPSButton.ghost(
                          label: 'Settings',
                          icon: Icons.settings_rounded,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),

                  TPSSpacing.vGapXxl,
                ]),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {},
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_music_outlined),
            selectedIcon: Icon(Icons.library_music_rounded),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_rounded),
            selectedIcon: Icon(Icons.history_rounded),
            label: 'History',
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionCard() {
    return TPSCard.hero(
      padding: TPSSpacing.cardPadding,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: TPSColors.success.withOpacity(0.2),
              borderRadius: TPSDecorations.compactBorderRadius,
            ),
            child: const Icon(Icons.wifi_rounded, color: TPSColors.success),
          ),
          TPSSpacing.hGapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Connected', style: TPSTypography.textTheme.titleMedium),
                TPSSpacing.vGapXs,
                Text(
                  'Direct-to-Source • Bit-Perfect',
                  style: TPSTypography.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: TPSColors.cyan.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: TPSColors.cyan.withOpacity(0.3)),
            ),
            child: Text('FLAC 24/96', style: TPSTypography.qualityBadge),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TPSTypography.textTheme.headlineSmall),
            Text(subtitle, style: TPSTypography.textTheme.bodySmall),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_rounded),
          color: TPSColors.muted,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildRecentlyPlayedCard() {
    return TPSCard.surface(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Album Art Placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: TPSColors.lilacGradient,
                  borderRadius: TPSDecorations.compactBorderRadius,
                ),
                child: const Icon(
                  Icons.music_note_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              TPSSpacing.hGapMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recently Played',
                      style: TPSTypography.textTheme.labelMedium,
                    ),
                    TPSSpacing.vGapXs,
                    Text(
                      'Bohemian Rhapsody',
                      style: TPSTypography.textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('Queen', style: TPSTypography.textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Icon(
                Icons.play_circle_filled_rounded,
                color: TPSColors.cyan,
                size: 48,
              ),
              TPSSpacing.hGapMd,
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: TPSColors.surface,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: TPSColors.cyanGradient,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              TPSSpacing.hGapMd,
              Text('2:34 / 5:55', style: TPSTypography.timestamp),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return TPSCard.surface(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: TPSDecorations.compactBorderRadius,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const Spacer(),
          Text(
            value,
            style: TPSTypography.textTheme.displaySmall?.copyWith(
              color: iconColor,
            ),
          ),
          Text(subtitle, style: TPSTypography.textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return TPSCard.surface(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildQuickAction(Icons.shuffle_rounded, 'Shuffle'),
          _buildQuickAction(Icons.radio_rounded, 'Radio'),
          _buildQuickAction(Icons.playlist_add_rounded, 'Add'),
          _buildQuickAction(Icons.share_rounded, 'Share'),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: TPSColors.surface,
            borderRadius: TPSDecorations.compactBorderRadius,
            border: Border.all(color: TPSColors.glassBorder),
          ),
          child: Icon(icon, color: TPSColors.textSecondary),
        ),
        TPSSpacing.vGapSm,
        Text(label, style: TPSTypography.textTheme.labelSmall),
      ],
    );
  }
}
