import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final IconData? trailing;
  final bool dense;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const _LabeledField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.obscure,
    this.trailing,
    this.dense = false,
    this.readOnly = false,
    this.keyboardType,
    this.controller,
  });

  const _LabeledField.compact({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.obscure,
    this.trailing,
    this.readOnly = false,
    this.keyboardType,
    this.controller,
  }) : dense = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          readOnly: readOnly,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: trailing != null ? Icon(trailing) : null,
            isDense: dense,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Figma colors
  static const Color _bgTop = Color(0xFFFFFFFF);
  static const Color _bgMid = Color(0xFFEDEDED);
  static const Color _bgBottom = Color(0xFFD8DBD8);
  static const Color _teal = Color(0xFF0B8A83);
  static const Color _tealDark = Color(0xFF0A6E68);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Page gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_bgTop, _bgMid, _bgBottom],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Top hero image
              SizedBox(
                height: 210,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/signup_pic.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Main card
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                  padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
                  height: MediaQuery.of(context).size.height * 0.72,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      // softer shadow than pure black
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    // prevents overflow on small screens / with keyboard
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // LOGO with teal glow
                        Center(
                          child: Text(
                            'LOGO',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: _teal,
                              
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        const Center(
                          child: Text(
                            'Welcome to Greenkeyper!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 45),

                        // Email
                        const _LabeledField(
                          label: 'Email',
                          hint: 'Enter your email',
                          icon: Icons.email_outlined,
                          obscure: false,
                        ),
                        const SizedBox(height: 20),

                        // Password + forgot
                        // Password + forgot
                        const _LabeledField(
                          label: 'Password',
                          hint: 'Enter your password',
                          icon: Icons.lock_outline,
                          obscure: true,
                          trailing: Icons.visibility_outlined,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.teal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),


                        // Login button (teal gradient + shadow)
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF0FA59D),
                                _tealDark,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {},
                              child: const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sign up row
                        // 1) In your LoginScreen, replace the Sign up row with this:
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text("Don't have an account? ",
        style: TextStyle(fontSize: 13.5, color: Colors.black87)),
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SignUpScreen()),
        );
      },
      child: const Text(
        'Sign up',
        style: TextStyle(
          fontSize: 13.5, color: Colors.teal, fontWeight: FontWeight.w700),
      ),
    ),
  ],
),

                      ],
                    ),
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



//sign up screen
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const Color _bgTop = Color(0xFFFFFFFF);
  static const Color _bgMid = Color(0xFFEDEDED);
  static const Color _bgBottom = Color(0xFFD8DBD8);
  static const Color _teal = Color(0xFF0B8A83);
  static const Color _tealDark = Color(0xFF0A6E68);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [_bgTop, _bgMid, _bgBottom], stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // slightly shorter hero image to free vertical space
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.asset('assets/images/signup_pic.png', fit: BoxFit.cover),
              ),

              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  // tweak top margin to sit under the image
                  margin: const EdgeInsets.fromLTRB(20, 110, 20, 20),
                  padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
                  // card height ~ 80% of screen; adjust if needed
                  height: h * 0.80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 24, offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700, color: _teal,
                            shadows: [
                              Shadow(
                                color: _teal,
                                blurRadius: 12, offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // FIELDS (compact)
                      const _LabeledField.compact(
                        label: 'Full Name', hint: 'Enter your name', icon: Icons.person_outline, obscure: false),
                      const SizedBox(height: 12),
                      const _LabeledField.compact(
                        label: 'Email', hint: 'Enter your email', icon: Icons.email_outlined, obscure: false),
                      const SizedBox(height: 12),
                      const _LabeledField.compact(
                        label: 'Contact', hint: 'Enter your contact', icon: Icons.call_outlined, obscure: false),
                      const SizedBox(height: 12),
                      const _LabeledField.compact(
                        label: 'Password', hint: 'Enter your password', icon: Icons.lock_outline, obscure: true, trailing: Icons.visibility_outlined),
                      const SizedBox(height: 12),
                      const _LabeledField.compact(
                        label: 'Confirm Password', hint: 'Enter confirm password', icon: Icons.lock_outline, obscure: true, trailing: Icons.visibility_outlined),

                      const Spacer(), // pushes button & footer to bottom

                      // Sign Up button
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter, end: Alignment.bottomCenter,
                            colors: const [Color(0xFF0FA59D), _tealDark],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 16, offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              // TODO: handle submit
                              Navigator.pop(context);
                            },
                            child: const Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white, fontSize: 16.5, fontWeight: FontWeight.w700),
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



class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  static const Color _bgTop = Color(0xFFFFFFFF);
  static const Color _bgMid = Color(0xFFEDEDED);
  static const Color _bgBottom = Color(0xFFD8DBD8);
  static const Color _teal = Color(0xFF0B8A83);
  static const Color _tealDark = Color(0xFF0A6E68);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final emailCtrl = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [_bgTop, _bgMid, _bgBottom], stops: [0.0, 0.55, 1.0],
          ),
        ),
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 24, offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text('Forgot Password',
                            style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w700, color: _teal,
                              shadows: [Shadow(color: _teal, blurRadius: 12, offset: Offset(0,3))],
                            )),
                      ),
                      const SizedBox(height: 45),
                      const Text(
                        'Please enter your email to request a password reset',
                        style: TextStyle(fontSize: 12.5, color: Colors.black87),
                      ),
                      const SizedBox(height: 35),
                      _LabeledField(
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
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter, end: Alignment.bottomCenter,
                            colors: [Color(0xFF0FA59D), _tealDark],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 16, offset: const Offset(0, 8),
                            ),
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
                                  style: TextStyle(
                                    color: Colors.white, fontSize: 16.5, fontWeight: FontWeight.w700)),
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


//verify code screen
class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key, required this.email});
  final String email;

  static const Color _bgTop = Color(0xFFFFFFFF);
  static const Color _bgMid = Color(0xFFEDEDED);
  static const Color _bgBottom = Color(0xFFD8DBD8);
  static const Color _teal = Color(0xFF0B8A83);
  static const Color _tealDark = Color(0xFF0A6E68);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final codeCtrl = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [_bgTop, _bgMid, _bgBottom], stops: [0.0, 0.55, 1.0],
          ),
        ),
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 24, offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text('Forgot Password',
                            style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w700, color: _teal,
                              shadows: [Shadow(color: _teal, blurRadius: 12, offset: Offset(0,3))],
                            )),
                      ),
                      const SizedBox(height: 18),
                      const Text('Please enter the code sent to your email.',
                          style: TextStyle(fontSize: 12.5, color: Colors.black87)),
                      const SizedBox(height: 22),
                      _LabeledField(
                        label: 'Email',
                        hint: email.isEmpty ? 'abc@gmail.com' : email,
                        icon: Icons.email_outlined,
                        obscure: false,
                        readOnly: true,
                      ),
                      const SizedBox(height: 18),
                      _LabeledField(
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
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter, end: Alignment.bottomCenter,
                            colors: [Color(0xFF0FA59D), _tealDark],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 16, offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text('Confirm',
                              style: TextStyle(
                                color: Colors.white, fontSize: 16.5, fontWeight: FontWeight.w700)),
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