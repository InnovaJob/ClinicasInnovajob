import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;
import '../home/home_screen.dart';
import '../appointments/appointments_screen.dart';
import '../productos/productos_screen.dart';
import '../configuracion/configuracion_screen.dart'; // Importar la pantalla de configuración
import '../../widgets/side_menu.dart'; // Importar el menú lateral compartido

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<_Message> _messages = [
    _Message(text: 'Hola doctor, tengo una consulta.', isClient: true),
    _Message(text: 'Claro, ¿en qué puedo ayudarle?', isClient: false),
    _Message(text: 'Mi dolor de cabeza persiste.', isClient: true),
    _Message(text: 'Le recomiendo realizarse un chequeo.', isClient: false),
  ];
  final TextEditingController _controller = TextEditingController();

  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xFF5f89c5);
    final bool isLargeScreen = MediaQuery.of(context).size.width > 700;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: isLargeScreen
          ? null
          : Drawer(
              backgroundColor: Colors.transparent,
              elevation: 4,
              child: Stack(
                children: [
                  AnimatedBackground(),
                  SideMenu(selectedIndex: _selectedIndex), // Usar el menú compartido
                ],
              ),
            ),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Stack(
          children: [
            // Fondo animado en la barra superior
            SizedBox(
              height: 56 + MediaQuery.of(context).padding.top,
              width: double.infinity,
              child: AnimatedBackground(),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Mensajes',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
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
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined, size: 22),
                  onPressed: () {
                    // Navegar a la pantalla de configuración
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ConfiguracionScreen()),
                    );
                  },
                ),
                const SizedBox(width: 4),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          AnimatedBackground(),
          Column(
            children: [
              SizedBox(
                height: 56 + MediaQuery.of(context).padding.top,
              ),
              Expanded(
                child: Row(
                  children: [
                    if (isLargeScreen)
                      SizedBox(
                        width: 220,
                        child: Stack(
                          children: [
                            ClipRect(child: AnimatedBackground()),
                            SideMenu(selectedIndex: _selectedIndex), // Usar el menú compartido
                          ],
                        ),
                      ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            // Cabecera de chat minimalista y fina
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]!),
                                ),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: baseColor.withOpacity(0.1),
                                    radius: 20,
                                    child: Icon(Icons.person, color: baseColor, size: 20),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dr. Javier López',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            letterSpacing: 0.1,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        Text(
                                          'En línea',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.more_vert, size: 18),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            // Lista de mensajes
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: _messages.length,
                                itemBuilder: (context, index) {
                                  final msg = _messages[index];
                                  return Align(
                                    alignment: msg.isClient ? Alignment.centerRight : Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * (isLargeScreen ? 0.5 : 0.7),
                                      ),
                                      decoration: BoxDecoration(
                                        color: msg.isClient ? baseColor.withOpacity(0.1) : Colors.grey[100],
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(14),
                                          topRight: const Radius.circular(14),
                                          bottomLeft: Radius.circular(msg.isClient ? 14 : 0),
                                          bottomRight: Radius.circular(msg.isClient ? 0 : 14),
                                        ),
                                        border: Border.all(
                                          color: msg.isClient ? baseColor.withOpacity(0.3) : Colors.grey[200]!,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Text(
                                        msg.text,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          height: 1.4,
                                          letterSpacing: 0.1,
                                          color: Colors.grey[900],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Input de mensaje
                            Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _controller,
                                      style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Escribe un mensaje...',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[500],
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(width: 0.5, color: Colors.grey),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Botón circular con icono de envío
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                                      onPressed: () {
                                        if (_controller.text.trim().isNotEmpty) {
                                          setState(() {
                                            _messages.add(_Message(text: _controller.text.trim(), isClient: true));
                                          });
                                          _controller.clear();
                                        }
                                      },
                                      padding: const EdgeInsets.all(10),
                                      constraints: const BoxConstraints(),
                                      splashRadius: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
          : Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (index) {
                  if (index == _selectedIndex) return;
                  setState(() {
                    _selectedIndex = index;
                  });
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
                  }
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.grey,
                selectedLabelStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                iconSize: 20,
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
            ),
    );
  }
}

class _Message {
  final String text;
  final bool isClient;
  _Message({required this.text, required this.isClient});
}
