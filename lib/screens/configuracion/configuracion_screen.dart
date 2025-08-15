import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;
import '../home/home_screen.dart';
import '../appointments/appointments_screen.dart';
import '../productos/productos_screen.dart';
import '../messages/messages_screen.dart';
import '../login/login_screen.dart'; // Importamos la pantalla de login
import '../../widgets/side_menu.dart';
import '../../theme/theme_provider.dart';

class ConfiguracionScreen extends StatefulWidget {
  const ConfiguracionScreen({Key? key}) : super(key: key);

  @override
  State<ConfiguracionScreen> createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  int _selectedIndex = 7; // Índice para la opción de configuración en el menú lateral
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Español';
  final List<String> _languages = ['Español', 'English', 'Français', 'Deutsch'];

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 700;
    final textTheme = Theme.of(context).textTheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    const baseColor = Color(0xFF5f89c5);

    // Color del fondo del contenedor basado en el tema
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[850]
        : Colors.white;

    // Color del texto basado en el tema
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;

    // Color para subtítulos basado en el tema
    final subtitleColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : Colors.grey[600];

    return Scaffold(
      drawer: isLargeScreen
          ? null
          : Drawer(
              backgroundColor: Colors.transparent,
              elevation: 1,
              child: Stack(
                children: [
                  AnimatedBackground(),
                  SideMenu(selectedIndex: _selectedIndex),
                ],
              ),
            ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: isLargeScreen
            ? null
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, size: 22),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
      ),
      body: Stack(
        children: [
          AnimatedBackground(),
          Column(
            children: [
              SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top),
              Expanded(
                child: Row(
                  children: [
                    if (isLargeScreen)
                      SizedBox(
                        width: 220,
                        child: Stack(
                          children: [
                            ClipRect(child: AnimatedBackground()),
                            SideMenu(selectedIndex: _selectedIndex),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Container(
                        color: backgroundColor,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Sección de perfil
                              _buildSectionHeader('Perfil', Icons.person),
                              _buildProfileCard(),
                              const SizedBox(height: 24),

                              // Sección de notificaciones
                              _buildSectionHeader('Notificaciones', Icons.notifications),
                              _buildSettingCard(
                                title: 'Activar notificaciones',
                                subtitle: 'Recibe alertas sobre citas, resultados y más',
                                trailing: Switch(
                                  value: _notificationsEnabled,
                                  onChanged: (value) {
                                    setState(() {
                                      _notificationsEnabled = value;
                                    });
                                  },
                                  activeColor: baseColor,
                                ),
                              ),
                              _buildSettingCard(
                                title: 'Recordatorios de citas',
                                subtitle: 'Recuerda tus próximas citas médicas',
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),
                              const SizedBox(height: 24),

                              // Sección de apariencia
                              _buildSectionHeader('Apariencia', Icons.palette),
                              _buildSettingCard(
                                title: 'Modo oscuro',
                                subtitle: 'Cambia entre tema claro y oscuro',
                                trailing: Switch(
                                  value: themeProvider.isDarkMode,
                                  onChanged: (value) {
                                    themeProvider.toggleTheme();
                                  },
                                  activeColor: baseColor,
                                ),
                              ),
                              _buildSettingCard(
                                title: 'Idioma',
                                subtitle: 'Selecciona tu idioma preferido',
                                trailing: DropdownButton<String>(
                                  value: _selectedLanguage,
                                  underline: const SizedBox(),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  dropdownColor: backgroundColor,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        _selectedLanguage = newValue;
                                      });
                                    }
                                  },
                                  items: _languages.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: textColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Sección de privacidad
                              _buildSectionHeader('Privacidad y Seguridad', Icons.security),
                              _buildSettingCard(
                                title: 'Cambiar contraseña',
                                subtitle: 'Actualiza tu contraseña periódicamente',
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),
                              _buildSettingCard(
                                title: 'Autenticación de dos factores',
                                subtitle: 'Añade una capa extra de seguridad',
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),
                              _buildSettingCard(
                                title: 'Gestionar datos personales',
                                subtitle: 'Revisa y modifica tu información personal',
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),
                              const SizedBox(height: 24),

                              // Sección de información
                              _buildSectionHeader('Información', Icons.info),
                              _buildSettingCard(
                                title: 'Sobre la aplicación',
                                subtitle: 'Versión 1.0.0',
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),
                              _buildSettingCard(
                                title: 'Términos y condiciones',
                                subtitle: 'Revisa los términos de uso',
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),
                              _buildSettingCard(
                                title: 'Política de privacidad',
                                subtitle: 'Cómo utilizamos tus datos',
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {},
                              ),

                              // Botón de cerrar sesión
                              const SizedBox(height: 40),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.logout),
                                  label: const Text('Cerrar Sesión'),
                                  onPressed: () {
                                    // Implementamos la funcionalidad de cierre de sesión
                                    _cerrarSesion(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),

                              if (!isLargeScreen) const SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: isLargeScreen
          ? null
          : BottomNavigationBar(
              currentIndex: 0, // Siempre mostrar Home como seleccionado
              onTap: (index) {
                if (index == 0) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } else if (index == 1) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
                  );
                } else if (index == 2) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ProductosScreen()),
                  );
                } else if (index == 3) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MessagesScreen()),
                  );
                }
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: 'Citas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag),
                  label: 'Productos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Mensajes',
                ),
              ],
            ),
    );
  }

  // Método para cerrar sesión
  void _cerrarSesion(BuildContext context) {
    // Aquí podrías añadir lógica adicional como:
    // - Limpiar tokens de autenticación
    // - Eliminar datos de usuario de SharedPreferences
    // - Reiniciar estados globales si es necesario

    // Navegar a la pantalla de inicio de sesión eliminando toda la pila de navegación
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false, // Esto elimina todas las rutas anteriores
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              fontSize: 18,
              letterSpacing: 0.1,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]
        : Colors.white;

    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;

    final subtitleColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : Colors.grey[600];

    final cardBorderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[700]
        : Colors.grey[200];

    return Card(
      elevation: 0,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cardBorderColor!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: 36,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'María García',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'maria.garcia@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      foregroundColor: Theme.of(context).primaryColor,
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Editar Perfil'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]
        : Colors.white;

    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black87;

    final subtitleColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : Colors.grey[600];

    final cardBorderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[700]
        : Colors.grey[200];

    return Card(
      elevation: 0,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: cardBorderColor!),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: textColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: subtitleColor,
          ),
        ),
        trailing: trailing,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
