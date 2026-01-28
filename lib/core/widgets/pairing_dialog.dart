import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme.dart';
import '../providers/providers.dart';
import 'tps_button.dart';

/// Displays the device pairing dialog with unique pairing code.
void showPairingDialog({
  required BuildContext context,
  required String? pairingCode,
  required WidgetRef ref,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: TPSColors.surface,
      title: Text('Pair Device', style: TPSTypography.textTheme.titleLarge),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter this code on the web dashboard to pair your device.',
            style: TPSTypography.textTheme.bodyMedium,
          ),
          TPSSpacing.vGapLg,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            decoration: BoxDecoration(
              color: TPSColors.charcoal,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: TPSColors.cyan.withOpacity(0.3)),
            ),
            child: Text(
              pairingCode ?? 'Loading...',
              style: TPSTypography.textTheme.headlineMedium?.copyWith(
                color: TPSColors.cyan,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TPSSpacing.vGapMd,
          Text(
            'This code is unique to this device.',
            style: TPSTypography.textTheme.labelSmall?.copyWith(
              color: TPSColors.muted,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(deviceControllerProvider.notifier).toggleConnection();
            Navigator.of(context).pop();
          },
          child: Text('Test Connect', style: TextStyle(color: TPSColors.muted)),
        ),
        TPSButton.primary(
          label: 'Done',
          onPressed: () => Navigator.of(context).pop(),
          isCompact: true,
        ),
      ],
    ),
  );
}
