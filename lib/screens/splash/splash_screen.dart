import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;

// Pantalla Splash que muestra el logo y navega al onboarding tras 2 segundos
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Espera 2 segundos y navega a la pantalla de onboarding
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(), // Fondo animado
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono de la app
                Icon(Icons.local_hospital, size: 80, color: Colors.white), // Cambiado a blanco
                const SizedBox(height: 24),
                // Nombre de la app
                const Text(
                  'Clínica Innova',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Cambiado a blanco
                  ),
                ),
                const SizedBox(height: 16),
                // Indicador de carga
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}