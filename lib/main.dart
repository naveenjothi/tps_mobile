import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tps_core/core/widgets/widgets.dart';
import 'firebase_options.dart';
import 'core/theme/theme.dart';
import 'core/providers/providers.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific options
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Firebase already initialized - this is fine
  }

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
class TPSApp extends ConsumerWidget {
  const TPSApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'TPS - The Private Streamer',
      debugShowCheckedModeBanner: false,
      theme: TPSTheme.dark,
      darkTheme: TPSTheme.dark,
      themeMode: ThemeMode.dark,
      home: authState.when(
        data: (user) =>
            user != null ? const DashboardScreen() : const LoginScreen(),
        loading: () => const _SplashScreen(),
        error: (_, __) => const LoginScreen(),
      ),
    );
  }
}

/// Splash screen shown during initial auth state check.
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: TPSColors.cyanGradient,
                borderRadius: TPSDecorations.heroBorderRadius,
                boxShadow: [
                  BoxShadow(
                    color: TPSColors.cyan.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                  width: 80 * 0.625,
                  height: 80 * 0.625,
                  child: CustomPaint(
                    painter: TPSWaveformPainter(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ),
                ),
              ),
            ),
            TPSSpacing.vGapLg,
            Text(
              'TPS',
              style: TPSTypography.textTheme.headlineLarge?.copyWith(
                color: TPSColors.cyan,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
