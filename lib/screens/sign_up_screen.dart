import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/labeled_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.pageGradient),
        child: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.asset('assets/images/signup_pic.png', fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 110, 20, 20),
                  padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
                  height: h * 0.80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 24, offset: Offset(0, 12)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppColors.teal,
                            shadows: [
                              Shadow(
                                color: AppColors.teal,
                                blurRadius: 12,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      const LabeledField.compact(
                        label: 'Full Name', hint: 'Enter your name',
                        icon: Icons.person_outline, obscure: false),
                      const SizedBox(height: 12),
                      const LabeledField.compact(
                        label: 'Email', hint: 'Enter your email',
                        icon: Icons.email_outlined, obscure: false),
                      const SizedBox(height: 12),
                      const LabeledField.compact(
                        label: 'Contact', hint: 'Enter your contact',
                        icon: Icons.call_outlined, obscure: false),
                      const SizedBox(height: 12),
                      const LabeledField.compact(
                        label: 'Password', hint: 'Enter your password',
                        icon: Icons.lock_outline, obscure: true, trailing: Icons.visibility_outlined),
                      const SizedBox(height: 12),
                      const LabeledField.compact(
                        label: 'Confirm Password', hint: 'Enter confirm password',
                        icon: Icons.lock_outline, obscure: true, trailing: Icons.visibility_outlined),

                      const Spacer(),

                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: AppColors.buttonGradient,
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, 8)),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => Navigator.pop(context),
                            child: const Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white, fontSize: 16.5, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? ",
                              style: TextStyle(fontSize: 13.5, color: Colors.black87)),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text('Login',
                                style: TextStyle(fontSize: 13.5, color: Colors.teal, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
