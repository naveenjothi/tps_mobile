import 'package:flutter/material.dart';

/// TPS Waveform Painter
///
/// Custom painter that draws the signature TPS heartbeat-style waveform.
/// Used in the logo and splash screens.
class TPSWaveformPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  TPSWaveformPainter({required this.color, this.strokeWidth = 2.5});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    // Scale the coordinates from 24x24 viewBox to actual size
    double scaleX = size.width / 24.0;
    double scaleY = size.height / 24.0;

    // Movement following the SVG path: M4 12h3l2-6 4 12 3-8h4
    // Translated to relative and absolute coordinates

    // M4 12
    path.moveTo(4 * scaleX, 12 * scaleY);
    // h3
    path.lineTo((4 + 3) * scaleX, 12 * scaleY);
    // l2 -6
    path.lineTo((7 + 2) * scaleX, (12 - 6) * scaleY);
    // 4 12 (relative to previous point (9, 6) + (4, 12) = (13, 18))
    path.lineTo((9 + 4) * scaleX, (6 + 12) * scaleY);
    // 3 -8 (relative to previous point (13, 18) + (3, -8) = (16, 10))
    path.lineTo((13 + 3) * scaleX, (18 - 8) * scaleY);
    // h4
    path.lineTo((16 + 4) * scaleX, 10 * scaleY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
