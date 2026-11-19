import 'dart:async';
import 'package:flutter/material.dart';
import '../core/app_data.dart';
import '../widgets/common_widgets.dart';
import 'login_screen.dart';

// ================= SPLASH SCREEN =================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController opening;
  late AnimationController background;

  @override
  void initState() {
    super.initState();

    opening = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();

    background = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat();

    Timer(const Duration(milliseconds: 3500), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    opening.dispose();
    background.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const LuxuryBackground(),
          AnimatedBuilder(
            animation: background,
            builder: (_, __) {
              return CustomPaint(
                painter: ParticlePainter(progress: background.value),
              );
            },
          ),
          Center(
            child: AnimatedBuilder(
              animation: opening,
              builder: (_, __) {
                final value =
                    Curves.easeInOutCubic.transform(opening.value);

                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.75 + value * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated capsule opens when the app starts.
                        const OpeningCapsule(size: 125),
                        const SizedBox(height: 20),
                        const Text(
                          "Dawa'i",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 43,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 5,
                          ),
                        ),
                        const Text(
                          "دوائي",
                          style: TextStyle(
                            color: C.lavender,
                            fontSize: 29,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 13),
                        const Text(
                          "رعايتك تبدأ من هنا",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Text(
              "YOUR HEALTH • OUR PRIORITY",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
