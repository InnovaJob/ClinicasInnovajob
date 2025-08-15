import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show OnboardingScreen, AnimatedBackground;

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
    _navigateToOnboarding();
  }

  // Extraer la lógica de navegación a un método separado
  void _navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Definir constantes para colores y tamaños que se usan múltiples veces
    const Color textColor = Colors.white;
    const double iconSize = 80.0;
    const double titleFontSize = 28.0;

    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(), // Uso de const para evitar reconstrucción
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono de la app
                const Icon(
                  Icons.local_hospital,
                  size: iconSize,
                  color: textColor
                ),
                const SizedBox(height: 24),
                // Nombre de la app
                const Text(
                  'Clínica Innova',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16),
                // Indicador de carga
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}