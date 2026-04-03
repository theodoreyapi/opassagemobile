import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

const kPurple = Color(0xFF5B0FA8);
const kGold = Color(0xFFFFC107);
const kBg = Color(0xFFF2F2F7);
const kWhite = Colors.white;

// ─────────────────────────────────────────
//  SUCCÈS ENREGISTREMENT
// ─────────────────────────────────────────
class EnregistrementSuccessPage extends StatelessWidget {
  const EnregistrementSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          // Header violet arrondi (vide, juste la couleur de fond)
          Container(
            height: 22.h,
            decoration: const BoxDecoration(
              color: kPurple,
              borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
          ),

          // Contenu centré
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Badge vérifié
                  _buildBadge(),

                  Gap(4.h),

                  // Titre "Super"
                  Text(
                    'Super',
                    style: TextStyle(
                      color: kPurple,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Gap(1.h),

                  // Sous-titre
                  Text(
                    'Ton hébergement est enregistré\navec succès',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPurple,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),

                  Gap(5.h),

                  // Bouton Terminer
                  SizedBox(
                    width: double.infinity,
                    height: 6.5.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPurple,
                        foregroundColor: kGold,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Terminer',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Gap(2.h),

                  // Bouton Ajouter un autre espace
                  SizedBox(
                    width: double.infinity,
                    height: 6.5.h,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kPurple,
                        side: const BorderSide(color: kPurple, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, color: kPurple),
                          Gap(2.w),
                          Text(
                            'Ajouter un autre espace',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: kPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── BADGE VÉRIFIÉ ──
  Widget _buildBadge() {
    return Container(
      width: 30.w,
      height: 30.w,
      decoration: const BoxDecoration(
        color: kPurple,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: _BadgeVerifie(size: 16.w),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  BADGE VÉRIFIÉ (étoile dorée + check)
// ─────────────────────────────────────────
class _BadgeVerifie extends StatelessWidget {
  final double size;
  const _BadgeVerifie({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _BadgePainter(),
        child: Center(
          child: Icon(
            Icons.check,
            color: kPurple,
            size: size * 0.5,
            weight: 700,
          ),
        ),
      ),
    );
  }
}

class _BadgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kGold
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const points = 8;
    const outerR = 1.0;
    const innerR = 0.78;

    final path = Path();
    for (int i = 0; i < points * 2; i++) {
      final angle = (i * 3.14159265 / points) - 3.14159265 / 2;
      final r = i.isEven ? outerR : innerR;
      final x = center.dx + radius * r * _cos(angle);
      final y = center.dy + radius * r * _sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  double _cos(double angle) => math.cos(angle);
  double _sin(double angle) => math.sin(angle);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}