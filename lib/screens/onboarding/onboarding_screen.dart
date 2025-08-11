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
          AnimatedBackground(),
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

class AnimatedBackground extends StatefulWidget {
  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _color1 = ColorTween(
      begin: Colors.blue.shade200,
      end: Colors.blue.shade900,
    ).animate(_controller);

    _color2 = ColorTween(
      begin: Colors.cyan.shade100,
      end: Colors.indigo.shade200,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _color1.value ?? Colors.blue,
                _color2.value ?? Colors.cyan,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }
}
