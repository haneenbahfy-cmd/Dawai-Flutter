import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import '../core/app_data.dart';

// ================= BACKGROUND =================

class LuxuryBackground extends StatelessWidget {
  const LuxuryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF241632),
            Color(0xFF38234F),
            Color(0xFF50346D),
            Color(0xFF2B1B40),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -80,
            child: _glow(300, const Color(0xFFB99ADB)),
          ),
          Positioned(
            bottom: -130,
            left: -90,
            child: _glow(320, const Color(0xFF9875C6)),
          ),
          Positioned(
            top: 350,
            right: 100,
            child: _glow(180, const Color(0xFF8060A8)),
          ),
        ],
      ),
    );
  }

  Widget _glow(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.20),
            blurRadius: 110,
            spreadRadius: 35,
          ),
        ],
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final double progress;

  ParticlePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint();

    for (int i = 0; i < 40; i++) {
      final x = (i * 73.0) % size.width;
      final y = (i * 113.0 + progress * 180) % size.height;
      final opacity =
          0.08 + (math.sin(progress * 2 * math.pi + i) + 1) * 0.12;

      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(
        Offset(x, y),
        1.2 + (i % 3) * 0.7,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// ================= UI HELPERS =================

InputDecoration fieldDecoration(String hint, IconData icon) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(
      color: Color(0xFFD0C3DC),
      fontSize: 14,
    ),
    prefixIcon: Icon(icon, color: C.lavender),
    filled: true,
    fillColor: Colors.white.withOpacity(0.09),
    contentPadding: const EdgeInsets.all(18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.15)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: C.lavender, width: 1.5),
    ),
  );
}

Widget glassCard({required Widget child}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
      child: Container(
        padding: const EdgeInsets.all(23),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.085),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.18)),
        ),
        child: child,
      ),
    ),
  );
}

Widget gradientButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    height: 58,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFBDA2DC), Color(0xFF8060AA)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: C.violet.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

// ================= CAPSULE LOGO =================

// Default logo used on splash and login.
Widget logo({double size = 65}) {
  return SizedBox(
    width: size,
    height: size,
    child: CustomPaint(
      painter: CapsulePainter(openProgress: 0),
    ),
  );
}

// Animated opening logo used only on Register screen.
class OpeningCapsule extends StatefulWidget {
  final double size;

  const OpeningCapsule({super.key, this.size = 65});

  @override
  State<OpeningCapsule> createState() => _OpeningCapsuleState();
}

class _OpeningCapsuleState extends State<OpeningCapsule>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size * 1.18,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          final t = controller.value;
          final turn = t < 0.55
              ? math.sin((t / 0.55) * math.pi) * 0.72
              : 0.0;
          final open = t < 0.58
              ? 0.0
              : Curves.easeOutBack.transform(
                  ((t - 0.58) / 0.32).clamp(0.0, 1.0),
                );

          final perspective = Matrix4.identity()
            ..setEntry(3, 2, 0.0018)
            ..rotateY(turn);

          return Transform(
            alignment: Alignment.center,
            transform: perspective,
            child: Transform.translate(
              offset: Offset(0, math.sin(t * math.pi * 2) * 2.5),
              child: CustomPaint(
                painter: CapsulePainter(openProgress: open),
                size: Size(widget.size, widget.size * 1.18),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CapsulePainter extends CustomPainter {
  final double openProgress;

  CapsulePainter({required this.openProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final w = size.width * 0.43;
    final h = size.height * 0.88;
    final r = w / 2;
    final separation = h * 0.17 * openProgress;

    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(-0.52);

    final topShift = -separation;
    final bottomShift = separation;

    // Upper half: rounded outer cap with a straight joining edge.
    final topPath = Path()
      ..moveTo(-r, topShift)
      ..lineTo(-r, -h / 2 + r + topShift)
      ..arcToPoint(
        Offset(r, -h / 2 + r + topShift),
        radius: Radius.circular(r),
        clockwise: true,
      )
      ..lineTo(r, topShift)
      ..close();

    // Lower half: matching shell, forming one complete capsule when closed.
    final bottomPath = Path()
      ..moveTo(-r, bottomShift)
      ..lineTo(-r, h / 2 - r + bottomShift)
      ..arcToPoint(
        Offset(r, h / 2 - r + bottomShift),
        radius: Radius.circular(r),
        clockwise: false,
      )
      ..lineTo(r, bottomShift)
      ..close();

    final purpleRect = Rect.fromLTWH(-r, -h / 2 + topShift, w, h / 2);
    final whiteRect = Rect.fromLTWH(-r, bottomShift, w, h / 2);

    final purpleFill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF0DFFF),
          Color(0xFFB88AE0),
          Color(0xFF7446A7),
          Color(0xFF4B286F),
        ],
        stops: [0.0, 0.28, 0.72, 1.0],
      ).createShader(purpleRect);

    final whiteFill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFFF4EFFF),
          Color(0xFFD8C4ED),
          Color(0xFFB9A0D4),
        ],
        stops: [0.0, 0.30, 0.72, 1.0],
      ).createShader(whiteRect);

    final edge = Paint()
      ..color = const Color(0xFFFDF8FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = (size.width * 0.014).clamp(1.1, 2.2);

    // Soft cast shadows give the capsule a raised, glossy 3D appearance.
    canvas.drawShadow(topPath, const Color(0x990D0614), 9, true);
    canvas.drawShadow(bottomPath, const Color(0x880D0614), 9, true);
    canvas.drawPath(topPath, purpleFill);
    canvas.drawPath(bottomPath, whiteFill);
    canvas.drawPath(topPath, edge);
    canvas.drawPath(bottomPath, edge);

    // Fine reflective streaks on each shell.
    final gloss = Paint()
      ..color = Colors.white.withOpacity(0.48)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.7
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(-r * 0.42, -h * 0.34 + topShift),
      Offset(-r * 0.10, -h * 0.43 + topShift),
      gloss,
    );
    canvas.drawLine(
      Offset(-r * 0.38, h * 0.19 + bottomShift),
      Offset(-r * 0.08, h * 0.29 + bottomShift),
      gloss,
    );

    // A small dark seam is visible only while the capsule is closed.
    if (openProgress < 0.08) {
      final seam = Paint()
        ..color = const Color(0x665D3C79)
        ..strokeWidth = 1.3;
      canvas.drawLine(Offset(-r, 0), Offset(r, 0), seam);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CapsulePainter oldDelegate) =>
      oldDelegate.openProgress != openProgress;
}
