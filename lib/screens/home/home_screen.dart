import 'package:flutter/material.dart';
import '../../onboarding/onboarding_screen.dart' show AnimatedBackground;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 700;

    return Scaffold(
      // Drawer con fondo transparente para mostrar el AnimatedBackground
      drawer: isLargeScreen
          ? null
          : Drawer(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Stack(
                children: [
                  // Fondo animado en el drawer
                  AnimatedBackground(),
                  SafeArea(child: _SideMenu()),
                ],
              ),
            ),
      appBar: AppBar(
        title: const Text('Panel de la Clínica'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: isLargeScreen
            ? null
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
      ),
      extendBodyBehindAppBar: true,
      body: Row(
        children: [
          if (isLargeScreen)
            Container(
              width: 260,
              child: Stack(
                children: [
                  // Fondo animado en el menú lateral para pantallas grandes
                  ClipRect(child: AnimatedBackground()),
                  SafeArea(child: _SideMenu()),
                ],
              ),
            ),
          Expanded(
            child: Container(
              color: Colors.white, // Fondo blanco para la pantalla principal
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¡Bienvenido a la gestión de tu clínica!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black), // Texto negro para fondo blanco
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Aquí puedes navegar a la pantalla de reservas, pacientes, etc.
                      },
                      child: const Text('Ver Reservas'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Aquí puedes navegar a la pantalla de pacientes
                      },
                      child: const Text('Ver Pacientes'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Aquí puedes navegar a la pantalla de servicios
                      },
                      child: const Text('Ver Servicios'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            // Quitamos el color sólido para que se vea el fondo animado
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Divider(color: Colors.white.withOpacity(0.7), thickness: 1),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today, color: Colors.white),
          title: const Text('Citas', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.of(context).maybePop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.chat, color: Colors.white),
          title: const Text('Contactar con el doctor', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.of(context).maybePop();
          },
        ),
        ListTile(
          leading: const Icon(Icons.article, color: Colors.white),
          title: const Text('Noticias', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.of(context).maybePop();
          },
        ),
        Divider(color: Colors.white.withOpacity(0.5)),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.white),
          title: const Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.of(context).maybePop();
          },
        ),
      ],
    );
  }
}