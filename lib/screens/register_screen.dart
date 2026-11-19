import 'package:flutter/material.dart';
import '../core/app_data.dart';
import '../widgets/common_widgets.dart';

// ================= REGISTER SCREEN =================

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirm = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Widget registerLabel(String text) {
    return Text(
      text,
      style: const TextStyle(color: C.lavender, fontSize: 13),
    );
  }

  Widget registerField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: obscure,
      textDirection: keyboardType == TextInputType.emailAddress
          ? TextDirection.ltr
          : TextDirection.rtl,
      style: const TextStyle(color: Colors.white),
      decoration: fieldDecoration(hint, icon).copyWith(suffixIcon: suffix),
      validator: validator,
    );
  }

  void register() {
    if (!formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final enteredEmail = emailController.text.trim().toLowerCase();

    final emailExists = usersList.any(
      (user) => user.email.toLowerCase() == enteredEmail,
    );

    if (emailExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("هذا البريد مسجل مسبقاً"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    usersList.add(
      UserAccount(
        name: nameController.text.trim(),
        email: enteredEmail,
        phone: normalizeDigits(phoneController.text.trim()),
        password: passwordController.text,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم إنشاء الحساب بنجاح، يمكنك تسجيل الدخول"),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
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
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 12, 25, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Capsule opens when the Register screen appears.
                    const Center(child: OpeningCapsule(size: 75)),

                    const SizedBox(height: 12),
                    const Text(
                      "إنشاء حساب جديد",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "انضم إلينا وابدأ رحلتك الصحية",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD3C4E2),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 30),
                    glassCard(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "بيانات الحساب",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),

                            registerLabel("الاسم الكامل"),
                            const SizedBox(height: 9),
                            registerField(
                              hint: "أدخل اسمك الكامل",
                              icon: Icons.person_outline,
                              controller: nameController,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return "يرجى إدخال الاسم";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),
                            registerLabel("البريد الإلكتروني"),
                            const SizedBox(height: 9),
                            registerField(
                              hint: "example@email.com",
                              icon: Icons.email_outlined,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null ||
                                    !v.contains('@') ||
                                    !v.contains('.')) {
                                  return "أدخل بريداً إلكترونياً صحيحاً";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),
                            registerLabel("رقم الهاتف"),
                            const SizedBox(height: 9),
                            registerField(
                              hint: "أدخل رقم الهاتف",
                              icon: Icons.phone_outlined,
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                final normalized = normalizeDigits(value);
                                if (normalized != value) {
                                  final selection = phoneController.selection;
                                  phoneController.value = TextEditingValue(
                                    text: normalized,
                                    selection: selection.copyWith(
                                      baseOffset: selection.baseOffset.clamp(0, normalized.length).toInt(),
                                      extentOffset: selection.extentOffset.clamp(0, normalized.length).toInt(),
                                    ),
                                  );
                                }
                              },
                              validator: (v) {
                                if (v == null || normalizeDigits(v).replaceAll(RegExp(r'[^0-9]'), '').length < 9) {
                                  return "أدخل رقم هاتف صحيحاً";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),
                            registerLabel("كلمة المرور"),
                            const SizedBox(height: 9),
                            registerField(
                              hint: "أدخل كلمة المرور",
                              icon: Icons.lock_outline,
                              controller: passwordController,
                              obscure: hidePassword,
                              suffix: IconButton(
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
                              validator: (v) {
                                if (v == null || v.length < 6) {
                                  return "كلمة المرور 6 أحرف على الأقل";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),
                            registerLabel("تأكيد كلمة المرور"),
                            const SizedBox(height: 9),
                            registerField(
                              hint: "أعد إدخال كلمة المرور",
                              icon: Icons.lock_reset,
                              controller: confirmController,
                              obscure: hideConfirm,
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideConfirm = !hideConfirm;
                                  });
                                },
                                icon: Icon(
                                  hideConfirm
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: C.lavender,
                                ),
                              ),
                              validator: (v) {
                                if (v != passwordController.text) {
                                  return "كلمتا المرور غير متطابقتين";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 30),
                            gradientButton(
                              text: "إنشاء الحساب",
                              onPressed: register,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "لديك حساب بالفعل؟ ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              color: C.lavender,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "DOCTOR • PHARMACY • CARE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        letterSpacing: 2.5,
                      ),
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
