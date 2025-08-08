import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import 'register_screen.dart';
import '../../onboarding/onboarding_screen.dart' show AnimatedBackground;

// Pantalla de Login tradicional sin fondo animado
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(), // Fondo animado igual que splash y onboarding
          // Elimina la capa blanca opaca para mostrar el fondo dinámico
          Center(
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
        ],
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
        Icon(Icons.local_hospital, size: isSmallScreen ? 100 : 200, color: Colors.white), // Cambiado a blanco
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Bienvenido a Clínica Innova",
            textAlign: TextAlign.center,
            style: (isSmallScreen
                    ? Theme.of(context).textTheme.titleMedium
                    : Theme.of(context).textTheme.titleSmall)
                ?.copyWith(color: Colors.white), // Cambiado a blanco
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
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
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
                filled: true,
                fillColor: Colors.white,
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
              title: const Text(
                'Recordarme',
                style: TextStyle(color: Colors.white), // Color blanco
              ),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
              checkColor: Colors.white, // El tick es blanco
              activeColor: Colors.white, // Fondo del cuadrado blanco
              side: const BorderSide(color: Colors.white, width: 2), // Contorno blanco
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
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
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text(
                '¿No tienes cuenta? Regístrate',
                style: TextStyle(color: Colors.white), // Color blanco
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'O inicia sesión con',
              style: TextStyle(color: Colors.white), // Color blanco
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                _SocialLoginButton(
                  imageUrl: 'https://img.icons8.com/color/48/000000/google-logo.png',
                  onPressed: () {
                    // Lógica para iniciar sesión con Google
                  },
                ),
                _SocialLoginButton(
                  imageUrl: 'https://img.icons8.com/ios-filled/50/000000/mac-os.png',
                  onPressed: () {
                    // Lógica para iniciar sesión con Apple
                  },
                ),
                _SocialLoginButton(
                  imageUrl: 'https://img.icons8.com/color/48/000000/facebook-new.png',
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
  final VoidCallback onPressed;

  const _SocialLoginButton({
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.network(imageUrl, height: 32, width: 32, fit: BoxFit.cover),
      iconSize: 40,
      splashRadius: 24,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}
