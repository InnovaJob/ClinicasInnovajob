import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;
import '../appointments/appointments_screen.dart';
import '../productos/productos_screen.dart';
import '../messages/messages_screen.dart';
import '../configuracion/configuracion_screen.dart';
import '../notifications/notifications_screen.dart';
import '../notifications/notification_detail_screen.dart'; // Importar pantalla de detalle
import '../../widgets/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Lista de notificaciones de ejemplo
  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      title: 'Nueva cita confirmada',
      message: 'Su cita con el Dr. Martínez para mañana a las 10:30 ha sido confirmada.',
      time: '10 min',
      isRead: false,
      type: _NotificationType.appointment,
    ),
    _NotificationItem(
      title: 'Recordatorio de medicación',
      message: 'Es hora de tomar su medicación prescrita. No olvide seguir el tratamiento.',
      time: '1 hora',
      isRead: false,
      type: _NotificationType.medication,
    ),
    _NotificationItem(
      title: 'Resultados disponibles',
      message: 'Los resultados de su análisis de sangre ya están disponibles para consulta.',
      time: '3 horas',
      isRead: true,
      type: _NotificationType.results,
    ),
  ];

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
                  SideMenu(selectedIndex: _selectedIndex), // Usar el menú compartido
                ],
              ),
            ),
      extendBodyBehindAppBar: true, // Permite que el cuerpo se extienda detrás del AppBar
      appBar: AppBar(
        title: Text(
          'Clínica Médica',
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.5,
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
                onPressed: () {
                  _showNotificationsPanel(context);
                },
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
                    '${_notifications.where((n) => !n.isRead).length}',
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
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ConfiguracionScreen()),
              );
            },
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
                            SideMenu(selectedIndex: _selectedIndex), // Usar el menú compartido
                          ],
                        ),
                      ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
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
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                    letterSpacing: -0.5,
                                    color: Colors.grey[800],
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
                if (index == _selectedIndex) return;

                setState(() {
                  _selectedIndex = index;
                });

                // Navegación entre pantallas
                if (index == 1) {
                  // Ir a la pantalla de citas
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
                  );
                } else if (index == 2) {
                  // Ir a la pantalla de productos
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ProductosScreen()),
                  );
                } else if (index == 3) {
                  // Ir a la pantalla de mensajes
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MessagesScreen()),
                  );
                }
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

  // Método para mostrar el panel de notificaciones
  void _showNotificationsPanel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 8,
              right: 8,
            ),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: size.width > 700 ? 400 : size.width * 0.85,
                constraints: BoxConstraints(
                  maxHeight: size.height * 0.7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Encabezado
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Notificaciones',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Aquí iría la lógica para marcar todas como leídas
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(4),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Marcar todas como leídas',
                                style: textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1),

                    // Lista de notificaciones
                    _notifications.isEmpty
                        ? _buildEmptyNotifications()
                        : Flexible(
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: _notifications.length,
                              separatorBuilder: (context, index) => const Divider(height: 1),
                              itemBuilder: (context, index) {
                                return _NotificationTile(
                                  notification: _notifications[index],
                                  onTap: () {
                                    // Cerrar el panel de notificaciones
                                    Navigator.pop(context);

                                    // Convertir el tipo local a tipo de notifications_screen.dart
                                    NotificationType notificationType;
                                    switch (_notifications[index].type) {
                                      case _NotificationType.appointment:
                                        notificationType = NotificationType.appointment;
                                        break;
                                      case _NotificationType.medication:
                                        notificationType = NotificationType.medication;
                                        break;
                                      case _NotificationType.results:
                                        notificationType = NotificationType.results;
                                        break;
                                      case _NotificationType.system:
                                        notificationType = NotificationType.system;
                                        break;
                                    }

                                    // Crear un objeto NotificationItem para usar con NotificationDetailScreen
                                    final notificationItem = NotificationItem(
                                      id: index.toString(),
                                      title: _notifications[index].title,
                                      message: _notifications[index].message,
                                      time: _notifications[index].time,
                                      date: 'Hoy',
                                      fullContent: _getFullContent(_notifications[index]),
                                      isRead: _notifications[index].isRead,
                                      type: notificationType,
                                    );

                                    // Navegar a la pantalla de detalle
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => NotificationDetailScreen(
                                          notification: notificationItem,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                    const Divider(height: 1),

                    // Botón para ver todas
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          // Cerrar el panel
                          Navigator.pop(context);

                          // Navegar a la pantalla de notificaciones
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NotificationsScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          foregroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12),
                            ),
                          ),
                        ),
                        child: Text(
                          'Ver todas las notificaciones',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Método para obtener contenido completo para cada notificación
  String _getFullContent(_NotificationItem notification) {
    // Generamos contenido completo basado en el tipo de notificación
    switch (notification.type) {
      case NotificationType.appointment:
        return 'Estimado paciente,\n\nLe confirmamos que su cita ha sido programada correctamente.\n\n${notification.message}\n\nPor favor, llegue 15 minutos antes de la hora programada y traiga consigo su documento de identidad y tarjeta sanitaria.\n\nSi necesita cancelar o reprogramar su cita, hágalo con al menos 24 horas de antelación.\n\nGracias por confiar en Clínica Médica.';

      case NotificationType.medication:
        return 'Recordatorio de medicación:\n\n${notification.message}\n\nRecuerde tomar este medicamento con alimentos y beber suficiente agua.\n\nNo omita ninguna dosis para garantizar la efectividad del tratamiento. Si experimenta algún efecto secundario, contacte a su médico inmediatamente.\n\nSu salud es nuestra prioridad.';

      case NotificationType.results:
        return 'Estimado paciente,\n\n${notification.message}\n\nPuede acceder a ellos desde la sección "Mis resultados" o descargarlos directamente desde esta notificación.\n\nSu médico ha sido notificado y revisará los resultados en su próxima consulta. Si hay algún hallazgo que requiera atención inmediata, nos pondremos en contacto con usted.\n\nGracias por confiar en nuestros servicios.';

      case NotificationType.system:
      default:
        return 'Información del sistema:\n\n${notification.message}\n\nGracias por usar nuestra aplicación.\n\nSi tiene alguna pregunta o sugerencia, no dude en contactar con nuestro servicio de atención al cliente.';
    }
  }

  // Widget para mostrar cuando no hay notificaciones
  Widget _buildEmptyNotifications() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No hay notificaciones',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cuando reciba notificaciones, aparecerán aquí',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Eliminamos la clase _SideMenu ya que ahora usamos el componente compartido

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
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    letterSpacing: 0.2,
                    color: Colors.grey[800],
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
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: statusColor,
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
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  service,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
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
    const baseColor = Color(0xFF5f89c5);

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
                  Icon(icon, color: color == Colors.blue ? baseColor : color),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: (color == Colors.blue ? baseColor : color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.trending_up, color: color == Colors.blue ? baseColor : color, size: 16),
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
    const baseColor = Color(0xFF5f89c5);
    final textTheme = Theme.of(context).textTheme; // Agregado para definir textTheme

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
                    color: (color == Colors.blue ? baseColor : color).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color == Colors.blue ? baseColor : color, size: 24),
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

// Tipos de notificaciones (para uso interno en HomeScreen)
enum _NotificationType {
  appointment,
  medication,
  results,
  system,
}

// Clase para almacenar información de una notificación
class _NotificationItem {
  final String title;
  final String message;
  final String time;
  final bool isRead;
  final _NotificationType type;

  _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.type,
  });
}

// Widget para mostrar una notificación individual
class _NotificationTile extends StatelessWidget {
  final _NotificationItem notification;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = notification.isRead
        ? Colors.transparent
        : Theme.of(context).primaryColor.withOpacity(0.05);

    return InkWell(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono según tipo de notificación
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getNotificationColor(notification.type).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getNotificationIcon(notification.type),
                color: _getNotificationColor(notification.type),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

            // Contenido
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: notification.isRead
                                ? FontWeight.w500
                                : FontWeight.w700,
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        notification.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      height: 1.4,
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Indicador de no leída
            if (!notification.isRead)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(left: 8, top: 8),
                decoration: BoxDecoration(
                  color: _getNotificationColor(notification.type),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
      );
  }

  IconData _getNotificationIcon(_NotificationType type) {
    switch (type) {
      case _NotificationType.appointment:
        return Icons.calendar_today;
      case _NotificationType.medication:
        return Icons.medication;
      case _NotificationType.results:
        return Icons.description;
      case _NotificationType.system:
        return Icons.info;
    }
  }

  Color _getNotificationColor(_NotificationType type) {
    const baseColor = Color(0xFF5f89c5);

    switch (type) {
      case _NotificationType.appointment:
        return baseColor;
      case _NotificationType.medication:
        return Colors.orange;
      case _NotificationType.results:
        return Colors.green;
      case _NotificationType.system:
        return Color(0xFF8BACE0); // Versión más clara del color principal
    }
  }
}
