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

class _PasswordField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _PasswordField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextField(
          controller: widget.controller,
          obscureText: _obscure,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscure = !_obscure),
              icon: Icon(_obscure ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
            ),
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
    onTap: () {
  debugPrint('Login tapped');
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => const MainNavigation()),
  );
}
,
    child: const Center(child: Text('Login',style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 252, 252, 252),
                            shadows: [
                              Shadow(
                                color: _teal,
                                blurRadius: 12, offset: const Offset(0, 3),
                              ),
                            ],
                          ),)),
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
                      // --- Confirm button (works) ---
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF0FA59D), _tealDark],
                            ),
                            boxShadow: const [
                         
                         
                              BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, 8)),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                // Optional: validate code here first
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
                                );
                              },
                              child: const Center(
                                child: Text(
                                  'Confirm',
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




// new password screen 

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  static const Color _bgTop = Color(0xFFFFFFFF);
  static const Color _bgMid = Color(0xFFEDEDED);
  static const Color _bgBottom = Color(0xFFD8DBD8);
  static const Color _teal = Color(0xFF0B8A83);
  static const Color _tealDark = Color(0xFF0A6E68);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _pass = TextEditingController();
  final _confirm = TextEditingController();

  void _showSuccessToast() {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          // Dim the screen behind (like your mock)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(color: Colors.black.withOpacity(0.35)),
            ),
          ),
          // Top banner
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE4C7), // warm peach
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Text('🎉', style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Congratulations! Your password has changed.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () => entry.remove(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 2), () {
      if (entry.mounted) entry.remove();
      Navigator.pop(context); // back after success
    });
  }

  void _onSave() {
    final p1 = _pass.text.trim();
    final p2 = _confirm.text.trim();

    if (p1.isEmpty || p2.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill both fields.')),
      );
      return;
    }
    if (p1.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters.')),
      );
      return;
    }
    if (p1 != p2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    // TODO: call your API to actually change the password
    _showSuccessToast();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [NewPasswordScreen._bgTop, NewPasswordScreen._bgMid, NewPasswordScreen._bgBottom],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // hero image
              SizedBox(
                height: 190, width: double.infinity,
                child: Image.asset('assets/images/signup_pic.png', fit: BoxFit.cover),
              ),
              // back
              Positioned(
                top: 8, left: 8,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // card
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
                      // title with teal glow
                      Center(
                        child: Text(
                          'New Password',
                          style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700,
                            color: NewPasswordScreen._teal,
                            shadows: [
                              Shadow(color: NewPasswordScreen._teal.withOpacity(0.6),
                                     blurRadius: 12, offset: const Offset(0, 3)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Please add new credentials to change password.',
                        style: TextStyle(fontSize: 12.5, color: Colors.black87),
                      ),
                      const SizedBox(height: 22),

                      _PasswordField(
                        label: 'Password',
                        hint: '•••••••',
                        controller: _pass,
                      ),
                      const SizedBox(height: 14),
                      _PasswordField(
                        label: 'Confirm Password',
                        hint: '•••••••',
                        controller: _confirm,
                      ),

                      const Spacer(),

                      // Save button
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter, end: Alignment.bottomCenter,
                            colors: [Color(0xFF0FA59D), NewPasswordScreen._tealDark],
                          ),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, 8)),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: _onSave,
                            child: const Center(
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white, fontSize: 16.5, fontWeight: FontWeight.w700),
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



// profile screen 
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const Color _teal = Color(0xFF0B8A83);
  static const Color _tealDark = Color(0xFF0A6E68);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _name = TextEditingController(text: 'Jane Cooper');
  final _email = TextEditingController(text: 'janecooper@gmail.com');
  final _contact = TextEditingController();

  int _tab = 1; // 0 = Home, 1 = Profile (current)

  void _save() {
    // TODO: call API
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved')),
    );
  }

  void _logout() {
    // TODO: clear tokens and navigate to Login
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Row(
          children: const [
            SizedBox(width: 8),
            Icon(Icons.home, color: Colors.teal),
            SizedBox(width: 8),
            Text('Edit Profile', style: TextStyle(color: Colors.black87)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: EditProfileScreen._teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              onPressed: _logout,
              icon: const Icon(Icons.logout_rounded, size: 18, color: Colors.white),
              label: const Text('Log Out', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // Avatar + name/email summary card
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundImage: const AssetImage('assets/images/signup_pic.png'),
                    foregroundImage: const AssetImage('assets/images/signup_pic.png'),
                    // fallback color if image not found
                    backgroundColor: Colors.grey.shade300,
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      padding: const EdgeInsets.all(2),
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.orange.shade400,
                        child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_name.text,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(_email.text,
                        style: const TextStyle(color: Colors.teal, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300, height: 1),

          const SizedBox(height: 14),
          const Text('Full Name', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: _name,
            decoration: InputDecoration(
              hintText: 'Jane Cooper',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),

          const SizedBox(height: 12),
          const Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: _email,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'janecooper@gmail.com',
              prefixIcon: const Icon(Icons.mail_outline),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),

          const SizedBox(height: 12),
          const Text('Contact', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: _contact,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Enter your contact',
              prefixIcon: const Icon(Icons.call_outlined),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),

          const SizedBox(height: 16),

          // Change password card
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
              );
            },
            child: Container(
              width: w,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 8))
                ],
              ),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFFEFF7F6),
                    child: Icon(Icons.lock_outline, color: Colors.teal),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text('Change password',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  Icon(Icons.chevron_right, color: Colors.black45),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          // Save / Cancel buttons
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF0FA59D), EditProfileScreen._tealDark],
                    ),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6)),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _save,
                      child: const Center(
                        child: Text('Save',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6)),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.pop(context),
                      child: const Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.close, size: 18, color: Colors.black87),
                            SizedBox(width: 6),
                            Text('Cancel',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// main navigation 
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  final _tabs = const [
    HomeScreen(),        // Home
    EditProfileScreen(), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: EditProfileScreen._teal,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}


// home screen 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _teal = Color(0xFF0B8A83);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(Icons.home, color: Colors.teal),
        ),
        title: const Text('Home', style: TextStyle(color: Colors.black87)),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // Greeting card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _teal,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Hello Jane Cooper, 👋\nWelcome to Greenkeyper!',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 12),

          // Two small stat cards
          Row(
            children: [
              _statCard(
                color: const Color(0xFFE6F4F2),
                icon: Icons.local_shipping_outlined,
                title: 'Assigned\nVehicles',
                value: '03',
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6))],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36, height: 36,
                        child: CircularProgressIndicator(
                          value: 0.8, strokeWidth: 5, color: _teal, backgroundColor: Colors.teal.shade50,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Checklist\nStatus', style: TextStyle(fontWeight: FontWeight.w600)),
                            SizedBox(height: 2),
                            Text('Checked', style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Vehicle fault status
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Vehicle Fault Status', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                _progressRow(label: 'Resolved', value: 0.85, trailing: '03', barColor: _teal),
                const SizedBox(height: 10),
                _progressRow(label: 'Pending', value: 0.2, trailing: '01', barColor: Colors.orange),
              ],
            ),
          ),
          const SizedBox(height: 16),

          const Text('Select your checklist time',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 10),

          // Two checklist time cards (navigate to Checklist screen)
          Row(
            children: [
              _timeCard(context, title: 'Beginning of the Day', icon: Icons.wb_twighlight, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ChecklistScreen()));
              }),
              const SizedBox(width: 12),
              _timeCard(context, title: 'End of the Day', icon: Icons.nights_stay_outlined, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ChecklistScreen()));
              }),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _statCard({required Color color, required IconData icon, required String title, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 18, backgroundColor: Colors.white, child: Icon(icon, color: Colors.teal)),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _progressRow({required String label, required double value, required String trailing, required Color barColor}) {
    return Row(
      children: [
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: value, minHeight: 6,
                color: barColor, backgroundColor: Colors.grey.shade200,
              ),
            ),
          ]),
        ),
        const SizedBox(width: 12),
        Text(trailing, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  static Widget _timeCard(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 6))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.teal),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              const Text('Checklist Questions\n30', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}


//checklist temp
class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text('Checklist Screen')),
  );
}
