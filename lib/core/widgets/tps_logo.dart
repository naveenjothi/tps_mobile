import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/tps_colors.dart';

class TPSLogo extends StatelessWidget {
  final double size;

  const TPSLogo({super.key, this.size = 32.0});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'TPS Logo',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo Icon Container
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [TPSColors.cyan, TPSColors.lilac],
              ),
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
                width: size * 0.625, // 20/32 equivalent to 5/8 (w-5/w-8)
                height: size * 0.625,
                child: CustomPaint(
                  painter: _WaveformPainter(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Logo Text
          Text(
            'TPS',
            style: GoogleFonts.outfit(
              fontSize: size * 0.625, // proportional to size
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _WaveformPainter({required this.color, required this.strokeWidth});

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

    // M4 12
    path.moveTo(4 * scaleX, 12 * scaleY);
    // h3
    path.lineTo((4 + 3) * scaleX, 12 * scaleY);
    // l2 -6
    path.lineTo((7 + 2) * scaleX, (12 - 6) * scaleY);
    // 4 12
    path.lineTo((9 + 4) * scaleX, (6 + 12) * scaleY);
    // 3 -8
    path.lineTo((13 + 3) * scaleX, (18 - 8) * scaleY);
    // h4
    path.lineTo((16 + 4) * scaleX, 10 * scaleY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
