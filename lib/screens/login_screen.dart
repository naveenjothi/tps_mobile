import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/theme.dart';
import '../core/widgets/widgets.dart';
import '../core/providers/providers.dart';

/// TPS Login Screen
///
/// Beautiful login screen with TPS branding and Google Sign-In.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Prevent redirection until backend is verified
      ref.read(isBackendReadyProvider.notifier).setReady(false);

      final authService = ref.read(authServiceProvider);
      final result = await authService.signInWithGoogle();

      final userService = ref.read(userServiceProvider);
      if (result.user != null) {
        final dbUser = await userService.createDbUserIfNotExists(result.user!);
        if (dbUser != null) {
          // Cache the user globally
          ref.read(currentDbUserProvider.notifier).setUser(dbUser);

          // Backend verification successful, allow redirection
          ref.read(isBackendReadyProvider.notifier).setReady(true);
        } else {
          setState(() {
            _errorMessage =
                'Could not connect to TPS backend. Your music library may be unavailable.';
          });
          // Sign out from Firebase if backend fails, so we stay on LoginScreen
          await authService.signOut();
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Sign-in failed. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: TPSSpacing.pagePadding,
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo and Branding
              _buildBranding(),

              const Spacer(flex: 1),

              // Feature highlights
              _buildFeatures(),

              const Spacer(flex: 2),

              // Error message
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: TPSColors.error.withValues(alpha: 0.1),
                    borderRadius: TPSDecorations.standardBorderRadius,
                    border: Border.all(
                      color: TPSColors.error.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: TPSColors.error,
                        size: 20,
                      ),
                      TPSSpacing.hGapSm,
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TPSTypography.textTheme.bodySmall?.copyWith(
                            color: TPSColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TPSSpacing.vGapLg,
              ],

              // Sign In Button
              TPSButton.primary(
                label: _isLoading ? 'Signing in...' : 'Sign in with Google',
                icon: Icons.login_rounded,
                onPressed: _isLoading ? null : _signInWithGoogle,
                isLoading: _isLoading,
              ),

              TPSSpacing.vGapMd,

              // Terms text
              Text(
                'By signing in, you agree to our Terms of Service\nand Privacy Policy',
                textAlign: TextAlign.center,
                style: TPSTypography.textTheme.bodySmall?.copyWith(
                  color: TPSColors.muted,
                ),
              ),

              TPSSpacing.vGapXl,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBranding() {
    return Column(
      children: [
        // Animated Logo Container
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: TPSColors.cyanGradient,
            borderRadius: TPSDecorations.heroBorderRadius,
            boxShadow: [
              BoxShadow(
                color: TPSColors.cyan.withValues(alpha: 0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Signature Waveform in background
              Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CustomPaint(
                    painter: TPSWaveformPainter(
                      color: Colors.white,
                      strokeWidth: 6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        TPSSpacing.vGapLg,

        // App Name
        Text(
          'TPS',
          style: TPSTypography.textTheme.displayLarge?.copyWith(
            color: TPSColors.cyan,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        TPSSpacing.vGapXs,

        // Tagline
        Text(
          'The Private Streamer',
          style: TPSTypography.textTheme.titleMedium?.copyWith(
            color: TPSColors.textSecondary,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures() {
    return Column(
      children: [
        _buildFeatureItem(
          Icons.lock_rounded,
          'Private & Secure',
          'Your music, your privacy',
        ),
        TPSSpacing.vGapMd,
        _buildFeatureItem(
          Icons.flash_on_rounded,
          'Bit-Perfect Audio',
          'Lossless streaming from source',
        ),
        TPSSpacing.vGapMd,
        _buildFeatureItem(
          Icons.lightbulb_rounded,
          'On-Device AI Discovery',
          'Discover and stream music from your device',
        ),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: TPSColors.surface,
                borderRadius: TPSDecorations.compactBorderRadius,
                border: Border.all(color: TPSColors.glassBorder),
              ),
              child: Icon(icon, color: TPSColors.cyan, size: 22),
            ),

            TPSSpacing.hGapMd,

            // ✅ NO Expanded needed
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TPSTypography.textTheme.titleSmall),
                Text(
                  subtitle,
                  style: TPSTypography.textTheme.bodySmall?.copyWith(
                    color: TPSColors.muted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
