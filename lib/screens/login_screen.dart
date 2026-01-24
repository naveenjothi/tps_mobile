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
      final authService = ref.read(authServiceProvider);
      await authService.signInWithGoogle();
      // Navigation will be handled by the auth state listener in main.dart
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
                    color: TPSColors.error.withOpacity(0.1),
                    borderRadius: TPSDecorations.standardBorderRadius,
                    border: Border.all(color: TPSColors.error.withOpacity(0.3)),
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
                color: TPSColors.cyan.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(
            Icons.headphones_rounded,
            color: Colors.white,
            size: 48,
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
          Icons.high_quality_rounded,
          'Bit-Perfect Audio',
          'Lossless streaming from source',
        ),
        TPSSpacing.vGapMd,
        _buildFeatureItem(
          Icons.devices_rounded,
          'P2P Connection',
          'Direct device to device streaming',
        ),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Row(
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
        Expanded(
          child: Column(
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
        ),
      ],
    );
  }
}
