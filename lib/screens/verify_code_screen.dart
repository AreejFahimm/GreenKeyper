import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/labeled_field.dart';
import 'new_password_screen.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final codeCtrl = TextEditingController();

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
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 24, offset: Offset(0, 12))],
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
                      const SizedBox(height: 18),
                      const Text('Please enter the code sent to your email.',
                          style: TextStyle(fontSize: 12.5, color: Colors.black87)),
                      const SizedBox(height: 22),
                      LabeledField(
                        label: 'Email',
                        hint: email.isEmpty ? 'abc@gmail.com' : email,
                        icon: Icons.email_outlined,
                        obscure: false,
                        readOnly: true,
                      ),
                      const SizedBox(height: 18),
                      LabeledField(
                        label: 'Enter Code',
                        hint: '45263',
                        icon: Icons.confirmation_number_outlined,
                        obscure: false,
                        controller: codeCtrl,
                        keyboardType: TextInputType.number,
                      ),
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
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
                            ),
                            child: const Center(
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: Colors.white, fontSize: 16.5, fontWeight: FontWeight.w700),
                              ),
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
