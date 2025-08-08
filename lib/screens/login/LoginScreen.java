import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Center(
        child: isSmallScreen
            ? const Column(
          mainAxisSize: MainAxisSize.min,
          children: [_Logo(), _FormContent()],
        )
            : Container(
          padding: const EdgeInsets.all(32.0),
          constraints: const BoxConstraints(maxWidth: 800),
          child: const Row(
            children: [
              Expanded(child: _Logo()),
              Expanded(child: Center(child: _FormContent())),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.local_hospital, size: isSmallScreen ? 100 : 200, color: Colors.blue),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Bienvenido a Clínica Innova",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent();

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce tu correo';
                }
                bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                ).hasMatch(value);
                if (!emailValid) {
                  return 'Introduce un correo válido';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'Introduce tu correo',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Password
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce tu contraseña';
                }
                if (value.length < 6) {
                  return 'La contraseña debe tener al menos 6 caracteres';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                hintText: 'Introduce tu contraseña',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
              },
              title: const Text('Recordarme'),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            const SizedBox(height: 16),
            // Login button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 12),
            // Register button
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('¿No tienes cuenta? Regístrate'),
            ),
            const SizedBox(height: 12),
            const Text('O inicia sesión con'),
            const SizedBox(height: 12),
            // Social login buttons with Wrap to avoid overflow
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                _SocialLoginButton(
                  imageUrl:
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/512px-Google_%22G%22_Logo.svg.png',
                  label: 'Google',
                  onPressed: () {
                    // Lógica para iniciar sesión con Google
                  },
                ),
                _SocialLoginButton(
                  imageUrl:
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/512px-Apple_logo_black.svg.png',
                  label: 'Apple',
                  onPressed: () {
                    // Lógica para iniciar sesión con Apple
                  },
                ),
                _SocialLoginButton(
                  imageUrl:
                  'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_(2019).png',
                  label: 'Facebook',
                  onPressed: () {
                    // Lógica para iniciar sesión con Facebook
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String imageUrl;
  final String label;
  final VoidCallback onPressed;

  const _SocialLoginButton({
    required this.imageUrl,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(imageUrl, height: 32, width: 32),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }
}