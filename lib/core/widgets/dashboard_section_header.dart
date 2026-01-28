import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'pairing_dialog.dart';
import 'tps_button.dart';
import 'tps_card.dart';

/// Dashboard section header with title, subtitle, and optional action.
class DashboardSectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onAction;

  const DashboardSectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TPSTypography.textTheme.headlineSmall),
            Text(subtitle, style: TPSTypography.textTheme.bodySmall),
          ],
        ),
        if (onAction != null)
          IconButton(
            icon: const Icon(Icons.arrow_forward_rounded),
            color: TPSColors.muted,
            onPressed: onAction,
          ),
      ],
    );
  }
}

/// Empty state for "Recently Added" section.
class EmptyRecentlyAdded extends StatelessWidget {
  final String? pairingCode;
  final dynamic ref;
  final BuildContext? dialogContext;

  const EmptyRecentlyAdded({
    super.key,
    this.pairingCode,
    this.ref,
    this.dialogContext,
  });

  @override
  Widget build(BuildContext context) {
    return TPSCard.surface(
      child: Padding(
        padding: TPSSpacing.cardPadding,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: TPSColors.surface,
                borderRadius: TPSDecorations.standardBorderRadius,
              ),
              child: const Icon(
                Icons.music_off_rounded,
                color: TPSColors.muted,
                size: 32,
              ),
            ),
            TPSSpacing.vGapMd,
            Text('No songs found', style: TPSTypography.textTheme.titleMedium),
            TPSSpacing.vGapXs,
            Text(
              'Sync your mobile device to start streaming',
              style: TPSTypography.textTheme.bodySmall?.copyWith(
                color: TPSColors.muted,
              ),
              textAlign: TextAlign.center,
            ),
            TPSSpacing.vGapLg,
            TPSButton.primary(
              label: 'Pair Device',
              icon: Icons.phonelink_rounded,
              onPressed:
                  pairingCode != null && ref != null && dialogContext != null
                  ? () => showPairingDialog(
                      context: dialogContext!,
                      pairingCode: pairingCode,
                      ref: ref,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
