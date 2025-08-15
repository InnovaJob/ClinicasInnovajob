import 'package:flutter/material.dart';
import '../login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;

  final List<Map<String, String>> _steps = [
    {
      'title': '¡Bienvenido a Clínica Innova!',
      'desc': 'Gestiona tus citas y tu salud de forma sencilla y rápida.',
    },
    {
      'title': '¿Cómo funciona?',
      'desc':
          'Podrás reservar citas, consultar tu historial médico y recibir recordatorios de tus próximas consultas, todo desde tu móvil.',
    },
    {
      'title': 'Privacidad y Seguridad',
      'desc':
          'Tus datos están protegidos y solo tú tendrás acceso a tu información médica. Cumplimos con los más altos estándares de seguridad.',
    },
  ];

  void _nextStep() {
    if (_step < _steps.length - 1) {
      setState(() {
        _step++;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    _steps[_step]['title']!,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Cambiado de azul a blanco
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _steps[_step]['desc']!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Cambiado de azul a blanco
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _nextStep,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text(
                        _step < _steps.length - 1 ? 'Siguiente' : 'Comenzar',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Clase para el fondo animado que se usa en varias pantallas
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Usando el nuevo color #5f89c5 y variaciones
    const baseColor = Color(0xFF5f89c5);
    const secondaryColor = Color(0xFF8BACE0); // Un tono más claro
    const accentColor = Color(0xFF4A6A9D); // Un tono más oscuro

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseColor,
                secondaryColor,
                baseColor.withOpacity(0.8),
                accentColor,
              ],
              stops: [
                0,
                _animation.value * 0.3,
                _animation.value * 0.7,
                1,
              ],
            ),
          ),
        );
      },
    );
  }
}
