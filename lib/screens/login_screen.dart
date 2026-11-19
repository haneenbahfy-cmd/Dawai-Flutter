import 'package:flutter/material.dart';
import '../core/app_data.dart';
import '../widgets/common_widgets.dart';
import 'register_screen.dart';
import 'home_screen.dart';

// ================= LOGIN SCREEN =================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool hidePassword = true;
  late AnimationController entrance;
  late AnimationController movement;

  @override
  void initState() {
    super.initState();

    entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..forward();

    movement = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    entrance.dispose();
    movement.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Widget stagger(Widget child, double start) {
    final animation = CurvedAnimation(
      parent: entrance,
      curve: Interval(start, 1, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 25 * (1 - animation.value)),
            child: child,
          ),
        );
      },
    );
  }

  void login() {
    if (!formKey.currentState!.validate()) return;

    final enteredEmail = email.text.trim().toLowerCase();
    final enteredPassword = password.text;

    UserAccount? foundUser;

    for (final user in usersList) {
      if (user.email.toLowerCase() == enteredEmail) {
        foundUser = user;
        break;
      }
    }

    if (foundUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الحساب غير موجود، يرجى إنشاء حساب"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (foundUser.password != enteredPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("كلمة المرور غير صحيحة"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => const HomeScreen(),
  ),
);
  }

  void openRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            const LuxuryBackground(),
            AnimatedBuilder(
              animation: movement,
              builder: (_, __) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: ParticlePainter(progress: movement.value),
                );
              },
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 15),
                    stagger(
                      Column(
                        children: [
                          logo(size: 90),
                          const SizedBox(height: 5),
                          const Text(
                            "Dawa'i",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 4,
                            ),
                          ),
                          const Text(
                            "دوائي",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: C.lavender,
                            ),
                          ),
                        ],
                      ),
                      0,
                    ),
                    const SizedBox(height: 30),
                    stagger(
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "رعايتك تبدأ من هنا",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 9),
                          Text(
                            "اعثر على دوائك، واعرف أين تجده",
                            style: TextStyle(
                              color: Color(0xFFD3C4E2),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      0.22,
                    ),
                    const SizedBox(height: 27),
                    glassCard(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            stagger(
                              const Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              0.30,
                            ),
                            const SizedBox(height: 23),
                            stagger(
                              const Text(
                                "البريد الإلكتروني",
                                style: TextStyle(
                                  color: C.lavender,
                                  fontSize: 13,
                                ),
                              ),
                              0.36,
                            ),
                            const SizedBox(height: 9),
                            stagger(
                              TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(color: Colors.white),
                                decoration: fieldDecoration(
                                  "example@email.com",
                                  Icons.alternate_email,
                                ),
                                validator: (v) {
                                  if (v == null ||
                                      !v.contains('@') ||
                                      !v.contains('.')) {
                                    return "أدخل بريداً إلكترونياً صحيحاً";
                                  }
                                  return null;
                                },
                              ),
                              0.42,
                            ),
                            const SizedBox(height: 20),
                            stagger(
                              const Text(
                                "كلمة المرور",
                                style: TextStyle(
                                  color: C.lavender,
                                  fontSize: 13,
                                ),
                              ),
                              0.52,
                            ),
                            const SizedBox(height: 9),
                            stagger(
                              TextFormField(
                                controller: password,
                                obscureText: hidePassword,
                                style: const TextStyle(color: Colors.white),
                                decoration: fieldDecoration(
                                  "أدخل كلمة المرور",
                                  Icons.lock_outline,
                                ).copyWith(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    icon: Icon(
                                      hidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: C.lavender,
                                    ),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.length < 6) {
                                    return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
                                  }
                                  return null;
                                },
                              ),
                              0.58,
                            ),
                            const SizedBox(height: 28),
                            stagger(
                              gradientButton(
                                text: "دخول إلى حسابي",
                                onPressed: login,
                              ),
                              0.72,
                            ),
                            const SizedBox(height: 20),
                            stagger(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "مستخدم جديد؟ ",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  TextButton(
                                    onPressed: openRegister,
                                    child: const Text(
                                      "أنشئ حسابك الآن",
                                      style: TextStyle(
                                        color: C.lavender,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              0.84,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 27),
                    stagger(
                      const Text(
                        "DOCTOR • PHARMACY • CARE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          letterSpacing: 2.5,
                        ),
                      ),
                      0.92,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
