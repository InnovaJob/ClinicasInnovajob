import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/appointments/appointments_screen.dart';
import '../screens/productos/productos_screen.dart';
import '../screens/messages/messages_screen.dart';
import '../screens/configuracion/configuracion_screen.dart';
import '../screens/login/login_screen.dart'; // Importamos la pantalla de login

class SideMenu extends StatelessWidget {
  final int selectedIndex;

  const SideMenu({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Función para cerrar sesión y navegar al login
    void _cerrarSesion(BuildContext context) {
      // Navegar a la pantalla de inicio de sesión eliminando toda la pila de navegación
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Esto elimina todas las rutas anteriores
      );
    }

    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          // Logo o encabezado
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 24,
              bottom: 24,
            ),
            child: Column(
              children: [
                // Ícono o logo
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.medical_services,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 12),
                // Título
                const Text(
                  'Clínica Médica',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          // Lista de opciones
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  context: context,
                  index: 0,
                  title: 'Dashboard',
                  icon: Icons.dashboard,
                  onTap: () {
                    if (selectedIndex != 0) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context: context,
                  index: 1,
                  title: 'Citas',
                  icon: Icons.calendar_today,
                  onTap: () {
                    if (selectedIndex != 1) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context: context,
                  index: 2,
                  title: 'Productos',
                  icon: Icons.shopping_bag,
                  onTap: () {
                    if (selectedIndex != 2) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const ProductosScreen()),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context: context,
                  index: 3,
                  title: 'Mensajes',
                  icon: Icons.chat,
                  onTap: () {
                    if (selectedIndex != 3) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const MessagesScreen()),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context: context,
                  index: 4,
                  title: 'Historial',
                  icon: Icons.history,
                  onTap: () {
                    // Navegación a la pantalla de historial
                  },
                ),
                _buildMenuItem(
                  context: context,
                  index: 5,
                  title: 'Recordatorios',
                  icon: Icons.notifications,
                  onTap: () {
                    // Navegación a la pantalla de recordatorios
                  },
                ),
                _buildMenuItem(
                  context: context,
                  index: 6,
                  title: 'Facturación',
                  icon: Icons.receipt,
                  onTap: () {
                    // Navegación a la pantalla de facturación
                  },
                ),
                // Otras opciones del menú...
                const Divider(color: Colors.white30),
                _buildMenuItem(
                  context: context,
                  index: 7,
                  title: 'Configuración',
                  icon: Icons.settings,
                  onTap: () {
                    if (selectedIndex != 7) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ConfiguracionScreen()),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context: context,
                  index: 8,
                  title: 'Cerrar Sesión',
                  icon: Icons.logout,
                  onTap: () {
                    // Llamamos a la función de cerrar sesión
                    _cerrarSesion(context);
                  },
                ),
              ],
            ),
          ),
          // Footer o información adicional
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'v1.0.0',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required int index,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedIndex == index;
    final color = isSelected ? Colors.white : Colors.white.withOpacity(0.7);

    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: isSelected,
        selectedTileColor: Colors.white.withOpacity(0.1),
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: color,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
