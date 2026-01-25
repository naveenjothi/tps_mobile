import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/tps_colors.dart';
import 'tps_waveform_painter.dart';

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
                  painter: TPSWaveformPainter(
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
