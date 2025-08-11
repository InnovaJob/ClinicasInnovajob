import 'package:flutter/material.dart';
import '../../onboarding/onboarding_screen.dart' show AnimatedBackground;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 700;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // Drawer con fondo animado para pantallas pequeñas
      drawer: isLargeScreen
          ? null
          : Drawer(
              backgroundColor: Colors.transparent,
              elevation: 4,
              child: Stack(
                children: [
                  // Fondo animado en el drawer
                  AnimatedBackground(),
                  _SideMenu(),
                ],
              ),
            ),
      extendBodyBehindAppBar: true, // Permite que el cuerpo se extienda detrás del AppBar
      appBar: AppBar(
        title: Text(
          'Clínica Médica',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Fondo transparente para mostrar AnimatedBackground
        elevation: 0, // Sin sombra
        leading: isLargeScreen
            ? null
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, size: 26),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 26),
                onPressed: () {},
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 26),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          // Fondo animado detrás de todo
          AnimatedBackground(),

          // Contenido principal
          Column(
            children: [
              // Espacio para el AppBar
              SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top),

              // Contenido restante
              Expanded(
                child: Row(
                  children: [
                    if (isLargeScreen)
                      Container(
                        width: 260,
                        child: Stack(
                          children: [
                            // Fondo transparente para dejar ver el AnimatedBackground
                            ClipRect(child: AnimatedBackground()),
                            _SideMenu(),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Container(
                        color: Colors.white, // Mantenemos el fondo blanco para el dashboard
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Título del dashboard
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  'Panel de Control',
                                  style: textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                ),
                              ),

                              // Tarjetas de acceso rápido
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: Row(
                                  children: [
                                    _QuickAccessButton(
                                      icon: Icons.calendar_month,
                                      label: 'Nueva Cita',
                                      onTap: () {},
                                      color: Colors.blue,
                                    ),
                                    _QuickAccessButton(
                                      icon: Icons.person_add,
                                      label: 'Nuevo Paciente',
                                      onTap: () {},
                                      color: Colors.green,
                                    ),
                                    _QuickAccessButton(
                                      icon: Icons.medical_services,
                                      label: 'Nuevo Servicio',
                                      onTap: () {},
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),
                              ),

                              // Tarjetas de estadísticas
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24.0),
                                child: Row(
                                  children: [
                                    _StatCard(
                                      title: 'Pacientes Hoy',
                                      value: '12',
                                      icon: Icons.people,
                                      color: Colors.blue,
                                    ),
                                    _StatCard(
                                      title: 'Ingresos',
                                      value: '€1,250',
                                      icon: Icons.euro,
                                      color: Colors.green,
                                    ),
                                    _StatCard(
                                      title: 'Citas Pendientes',
                                      value: '8',
                                      icon: Icons.calendar_today,
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),
                              ),

                              // Tarjeta de citas del día
                              _CardContainer(
                                title: 'Citas de Hoy',
                                icon: Icons.today,
                                child: Column(
                                  children: [
                                    _AppointmentItem(
                                      time: '09:00',
                                      name: 'María García',
                                      service: 'Consulta General',
                                      status: 'Confirmada',
                                    ),
                                    _AppointmentItem(
                                      time: '10:30',
                                      name: 'Juan Pérez',
                                      service: 'Dermatología',
                                      status: 'En espera',
                                    ),
                                    _AppointmentItem(
                                      time: '12:00',
                                      name: 'Ana Martínez',
                                      service: 'Pediatría',
                                      status: 'Completada',
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Ver todas las citas',
                                        style: textTheme.labelLarge?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Tarjeta de próximas citas
                              _CardContainer(
                                title: 'Próximas Citas',
                                icon: Icons.event_note,
                                child: Column(
                                  children: [
                                    _AppointmentItem(
                                      time: 'Mañana, 09:30',
                                      name: 'Carlos Ruiz',
                                      service: 'Fisioterapia',
                                      status: 'Confirmada',
                                    ),
                                    _AppointmentItem(
                                      time: 'Mañana, 11:00',
                                      name: 'Laura Sánchez',
                                      service: 'Odontología',
                                      status: 'Pendiente',
                                    ),
                                    _AppointmentItem(
                                      time: '23 Nov, 10:15',
                                      name: 'Roberto Fernández',
                                      service: 'Nutrición',
                                      status: 'Confirmada',
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Ver agenda completa',
                                        style: textTheme.labelLarge?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Espaciado para el menú inferior en móviles
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
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
              unselectedLabelStyle: textTheme.labelSmall,
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
                  icon: Icon(Icons.people),
                  label: 'Pacientes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'Mensajes',
                ),
              ],
            ),
    );
  }
}

class _SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.transparent, // Fondo transparente para ver el AnimatedBackground
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.local_hospital, size: 30, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              Text(
                'Clínica Médica',
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Gestión Sanitaria',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
        _MenuListTile(
          icon: Icons.dashboard,
          title: 'Panel Principal',
          onTap: () {
            Navigator.of(context).maybePop();
          },
          isSelected: true,
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        _MenuListTile(
          icon: Icons.calendar_today,
          title: 'Citas',
          onTap: () {
            Navigator.of(context).maybePop();
          },
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        _MenuListTile(
          icon: Icons.people,
          title: 'Pacientes',
          onTap: () {
            Navigator.of(context).maybePop();
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
              style: textTheme.labelLarge?.copyWith(
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
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.white.withOpacity(0.2) : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : iconColor.withOpacity(0.8),
        ),
        title: Text(
          title,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : textColor.withOpacity(0.8),
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _CardContainer({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Divider(),
            child,
          ],
        ),
      ),
    );
  }
}

class _AppointmentItem extends StatelessWidget {
  final String time;
  final String name;
  final String service;
  final String status;

  const _AppointmentItem({
    required this.time,
    required this.name,
    required this.service,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
      default:
        statusColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 50,
            color: statusColor,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                status,
                style: textTheme.bodySmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  service,
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.trending_up, color: color, size: 16),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAccessButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _QuickAccessButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

