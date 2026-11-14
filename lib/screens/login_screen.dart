import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../widgets/dutio_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DutioRole role = DutioRole.member;
  final username = TextEditingController();
  final password = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  void signIn() => Navigator.pushReplacementNamed(
    context,
    role == DutioRole.member ? '/user' : '/coordinator',
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(26, 22, 26, 28),
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: DutioLogo(size: 44),
          ),
          const SizedBox(height: 80),
          Text(
            role == DutioRole.member ? 'Crew, Let’s Move!' : 'Captain on Deck!',
            style: TextStyle(
              color: AppTheme.darkGreen,
              fontSize: 29,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            role == DutioRole.member
                ? 'Piket hari ini dimulai dari sini 🚀'
                : 'Jalankan kendali, buat semuanya teratur ⚙️',
            style: const TextStyle(color: AppTheme.dark, fontSize: 16),
          ),
          const SizedBox(height: 130),
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.sizeOf(context).height * .58,
            ),
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            decoration: BoxDecoration(
              color: AppTheme.sage,
              borderRadius: BorderRadius.circular(38),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.ink,
                    fontSize: 39,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SegmentedButton<DutioRole>(
                  segments: const [
                    ButtonSegment(
                      value: DutioRole.member,
                      label: Text('Anggota'),
                    ),
                    ButtonSegment(
                      value: DutioRole.coordinator,
                      label: Text('Koordinator'),
                    ),
                  ],
                  selected: {role},
                  onSelectionChanged: (value) =>
                      setState(() => role = value.first),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => states.contains(WidgetState.selected)
                          ? AppTheme.cream
                          : AppTheme.sage,
                    ),
                    foregroundColor: WidgetStateProperty.all(
                      AppTheme.darkGreen,
                    ),
                  ),
                ),
                _input('Username atau email', controller: username),
                _input(
                  'Password',
                  controller: password,
                  obscureText: hidePassword,
                  suffix: IconButton(
                    onPressed: () =>
                        setState(() => hidePassword = !hidePassword),
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/forgot-password',
                      arguments: role,
                    ),
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: AppTheme.white),
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: signIn,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.ink,
                    foregroundColor: AppTheme.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                if (role == DutioRole.coordinator) ...[
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    child: const Text(
                      'Become the Captain!  Sign Up',
                      style: TextStyle(color: AppTheme.white),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _input(
    String hint, {
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffix,
  }) => TextField(
    controller: controller,
    obscureText: obscureText,
    style: const TextStyle(color: AppTheme.white),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppTheme.white.withValues(alpha: .75)),
      suffixIcon: suffix,
      fillColor: AppTheme.charcoal.withValues(alpha: .65),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    ),
  );
}
