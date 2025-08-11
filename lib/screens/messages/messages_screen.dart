import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;
import '../home/home_screen.dart';
import '../appointments/appointments_screen.dart';
import '../productos/productos_screen.dart';

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
                  _SideMenu(selectedIndex: _selectedIndex),
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
              title: Text(
                'Mensajes',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontFamily: 'Montserrat',
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
                  onPressed: () {},
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
                            _SideMenu(selectedIndex: _selectedIndex),
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
                                    backgroundColor: Colors.blue[50],
                                    radius: 20,
                                    child: Icon(Icons.person, color: Colors.blue[700], size: 20),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dr. Javier López',
                                          style: textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                        Text(
                                          'En línea',
                                          style: textTheme.bodySmall?.copyWith(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                            fontFamily: 'Montserrat',
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
                                        color: msg.isClient ? Colors.blue[50] : Colors.grey[100],
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(14),
                                          topRight: const Radius.circular(14),
                                          bottomLeft: Radius.circular(msg.isClient ? 14 : 0),
                                          bottomRight: Radius.circular(msg.isClient ? 0 : 14),
                                        ),
                                        border: Border.all(
                                          color: msg.isClient ? Colors.blue[100]! : Colors.grey[200]!,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Text(
                                        msg.text,
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
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
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Escribe un mensaje...',
                                        hintStyle: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontFamily: 'Montserrat',
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
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_controller.text.trim().isNotEmpty) {
                                        setState(() {
                                          _messages.add(_Message(text: _controller.text.trim(), isClient: true));
                                        });
                                        _controller.clear();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Theme.of(context).primaryColor,
                                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      textStyle: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    child: const Text('Enviar'),
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

// Menú lateral adaptado y más fino
class _SideMenu extends StatelessWidget {
  final int selectedIndex;
  const _SideMenu({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.local_hospital, size: 22, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Text(
                'Clínica Médica',
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
              Text(
                'Gestión Sanitaria',
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ),
        _MenuListTile(
          icon: Icons.dashboard,
          title: 'Panel Principal',
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          isSelected: selectedIndex == 0,
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        _MenuListTile(
          icon: Icons.calendar_today,
          title: 'Citas',
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
            );
          },
          isSelected: selectedIndex == 1,
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        _MenuListTile(
          icon: Icons.shopping_bag,
          title: 'Productos',
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ProductosScreen()),
            );
          },
          isSelected: selectedIndex == 2,
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        _MenuListTile(
          icon: Icons.chat,
          title: 'Mensajes',
          onTap: () {
            Navigator.of(context).maybePop();
          },
          isSelected: selectedIndex == 3,
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        // ...otros elementos del menú si los necesitas...
      ],
    );
  }
}

class _MenuListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  final Color textColor;
  final Color iconColor;

  const _MenuListTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isSelected = false,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: isSelected ? Colors.white.withOpacity(0.18) : null,
      ),
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        leading: Icon(
          icon,
          size: 18,
          color: isSelected ? Colors.white : iconColor.withOpacity(0.8),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : textColor.withOpacity(0.8),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
