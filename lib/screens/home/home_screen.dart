import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userName = "Usuario"; // Puedes personalizarlo si tienes datos de usuario

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con avatar y saludo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: Color(0xFF2193b0)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¡Bienvenido, $userName!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Panel de la Clínica',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Tarjetas de acciones principales
              Expanded(
                child: GridView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: 1,
                  ),
                  children: [
                    _HomeCard(
                      icon: Icons.calendar_today_rounded,
                      label: 'Reservas',
                      color: Colors.blueAccent,
                      onTap: () {
                        // Navegar a reservas
                      },
                    ),
                    _HomeCard(
                      icon: Icons.people_alt_rounded,
                      label: 'Pacientes',
                      color: Colors.green,
                      onTap: () {
                        // Navegar a pacientes
                      },
                    ),
                    _HomeCard(
                      icon: Icons.medical_services_rounded,
                      label: 'Servicios',
                      color: Colors.purple,
                      onTap: () {
                        // Navegar a servicios
                      },
                    ),
                    _HomeCard(
                      icon: Icons.settings_rounded,
                      label: 'Ajustes',
                      color: Colors.orange,
                      onTap: () {
                        // Navegar a ajustes
                      },
                    ),
                  ],
                ),
              ),
              // Footer
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 8),
                child: Center(
                  child: Text(
                    'Clínica Innova © 2024',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
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

class _HomeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _HomeCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(18),
      elevation: 6,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                radius: 28,
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 18),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}