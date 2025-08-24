import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/labeled_field.dart';
import 'verify_code_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final emailCtrl = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.pageGradient),
        child: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: 190, width: double.infinity,
                child: Image.asset('assets/images/signup_pic.png', fit: BoxFit.cover),
              ),
              Positioned(
                top: 8, left: 8,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
                  height: h * 0.75,
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
                        child: Text('Forgot Password',
                            style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.teal,
                              shadows: [Shadow(color: AppColors.teal, blurRadius: 12, offset: Offset(0,3))],
                            )),
                      ),
                      const SizedBox(height: 45),
                      const Text(
                        'Please enter your email to request a password reset',
                        style: TextStyle(fontSize: 12.5, color: Colors.black87),
                      ),
                      const SizedBox(height: 35),
                      LabeledField(
                        label: 'Email',
                        hint: 'abc@gmail.com',
                        icon: Icons.email_outlined,
                        obscure: false,
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 50),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VerifyCodeScreen(email: emailCtrl.text.trim()),
                                ),
                              );
                            },
                            child: const Center(
                              child: Text('Send Code',
                                  style: TextStyle(color: Colors.white, fontSize: 16.5, fontWeight: FontWeight.w700)),
                            ),
                          ),
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
    );
  }
}
