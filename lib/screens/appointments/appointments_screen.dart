import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground; // Ruta actualizada
import '../home/home_screen.dart';
import '../productos/productos_screen.dart'; // Importar la nueva pantalla de productos
import '../messages/messages_screen.dart'; // Importar pantalla de mensajes
import '../../widgets/side_menu.dart'; // Importar el menú lateral compartido

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
                  SideMenu(selectedIndex: _selectedIndex), // Usar el menú compartido
                ],
              ),
            ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Citas',
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
                            SideMenu(selectedIndex: _selectedIndex), // Usar el menú compartido
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
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.2,
                                            color: Colors.black87,
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
                        fontFamily: 'Montserrat',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey[600],
                      ),
                    ),
                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black87,
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
    const baseColor = Color(0xFF5f89c5);

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
        statusColor = baseColor;  // Cambiado de azul al color base
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
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.black87,
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
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      service,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.grey[700],
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
                    fontFamily: 'Montserrat',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
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
