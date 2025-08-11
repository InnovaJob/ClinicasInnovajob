import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground; // Ruta actualizada
import '../home/home_screen.dart';
import '../productos/productos_screen.dart'; // Importar la nueva pantalla de productos

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _selectedIndex = 1;
  int _selectedFilter = 0;
  DateTime _selectedDate = DateTime.now();

  final List<String> _filters = [
    'Todas',
    'Pendientes',
    'Confirmadas',
    'Completadas',
    'Canceladas'
  ];

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 700;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      drawer: isLargeScreen
          ? null
          : Drawer(
              backgroundColor: Colors.transparent,
              elevation: 1,
              child: Stack(
                children: [
                  AnimatedBackground(),
                  _SideMenu(selectedIndex: _selectedIndex),
                ],
              ),
            ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Citas',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 20),
            onPressed: () {},
          ),
        ],
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
                            _SideMenu(selectedIndex: _selectedIndex),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            // Calendario minimalista
                            _buildCalendarHeader(),

                            // Lista de citas
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.all(10.0),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          _formatDate(_selectedDate),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Spacer(),
                                        _buildFilterButton(),
                                      ],
                                    ),
                                  ),

                                  // Citas del día (ultra minimalistas)
                                  _AppointmentCard(
                                    time: '09:00',
                                    patientName: 'María García',
                                    service: 'Consulta General',
                                    status: 'Confirmada',
                                  ),
                                  _AppointmentCard(
                                    time: '10:30',
                                    patientName: 'Juan Pérez',
                                    service: 'Dermatología',
                                    status: 'En espera',
                                  ),
                                  _AppointmentCard(
                                    time: '12:00',
                                    patientName: 'Ana Rodríguez',
                                    service: 'Pediatría',
                                    status: 'Completada',
                                  ),
                                  _AppointmentCard(
                                    time: '15:45',
                                    patientName: 'Carlos Ruiz',
                                    service: 'Fisioterapia',
                                    status: 'Cancelada',
                                  ),

                                  if (!isLargeScreen) const SizedBox(height: 80),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: isLargeScreen
          ? null
          : BottomNavigationBar(
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
                } else if (index == 2) {
                  // Navegar a la pantalla de productos
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ProductosScreen()),
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
                  icon: Icon(Icons.shopping_bag),  // Cambio del icono a shopping_bag
                  label: 'Productos',               // Cambio de Pacientes a Productos
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Mensajes',
                ),
              ],
            ),
    );
  }

  Widget _buildFilterButton() {
    return PopupMenuButton<int>(
      icon: Icon(Icons.filter_list, size: 18, color: Colors.grey[700]),
      offset: const Offset(0, 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (index) {
        setState(() {
          _selectedFilter = index;
        });
      },
      itemBuilder: (context) => _filters
          .asMap()
          .entries
          .map((entry) => PopupMenuItem<int>(
                value: entry.key,
                child: Text(
                  entry.value,
                  style: TextStyle(
                    color: _selectedFilter == entry.key
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                    fontWeight: _selectedFilter == entry.key
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 14,
          itemBuilder: (context, index) {
            final date = DateTime.now().add(Duration(days: index));
            final isSelected = _isSameDay(date, _selectedDate);
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = date;
                });
              },
              child: Container(
                width: 40,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getWeekday(date.weekday),
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected ? Colors.white : Colors.grey[600],
                      ),
                    ),
                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];

    return '${date.day} de ${months[date.month - 1]}';
  }

  String _getWeekday(int weekday) {
    const days = ['', 'L', 'M', 'X', 'J', 'V', 'S', 'D'];
    return days[weekday];
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

// Menú lateral simplificado
class _SideMenu extends StatelessWidget {
  final int selectedIndex;

  const _SideMenu({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.local_hospital, size: 24, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              const Text(
                'Clínica Médica',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Gestión Sanitaria',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
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
            Navigator.of(context).maybePop();
          },
          isSelected: selectedIndex == 1,
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        _MenuListTile(
          icon: Icons.shopping_bag,  // Cambio del icono a shopping_bag
          title: 'Productos',        // Cambio de Pacientes a Productos
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ProductosScreen()),
            );
          },
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        _MenuListTile(
          icon: Icons.chat,
          title: 'Contactar Doctor',
          onTap: () {
            Navigator.of(context).maybePop();
          },
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        _MenuListTile(
          icon: Icons.article,
          title: 'Noticias',
          onTap: () {
            Navigator.of(context).maybePop();
          },
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        _MenuListTile(
          icon: Icons.medical_services,
          title: 'Servicios',
          onTap: () {
            Navigator.of(context).maybePop();
          },
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        _MenuListTile(
          icon: Icons.bar_chart,
          title: 'Estadísticas',
          onTap: () {
            Navigator.of(context).maybePop();
          },
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        const Divider(color: Colors.white54),
        _MenuListTile(
          icon: Icons.settings,
          title: 'Configuración',
          onTap: () {
            Navigator.of(context).maybePop();
          },
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        Container(
          margin: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.logout),
            label: Text(
              'Cerrar Sesión',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          ),
        ),
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
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isSelected ? Colors.white.withOpacity(0.2) : null,
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

// Tarjeta de cita ultra minimalista
class _AppointmentCard extends StatelessWidget {
  final String time;
  final String patientName;
  final String service;
  final String status;
  final String? doctorName;
  final String? notes;

  const _AppointmentCard({
    required this.time,
    required this.patientName,
    required this.service,
    required this.status,
    this.doctorName,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'confirmada':
        statusColor = Colors.green;
        break;
      case 'pendiente':
      case 'en espera':
        statusColor = Colors.orange;
        break;
      case 'completada':
        statusColor = Colors.blue;
        break;
      case 'cancelada':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: statusColor, width: 3),
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Row(
            children: [
              // Hora
              Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 12),

              // Información del paciente
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      service,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Estado
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w500,
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
