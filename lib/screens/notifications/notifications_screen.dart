import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;
import 'notification_detail_screen.dart';
import '../../widgets/side_menu.dart';

// Tipos de notificaciones
enum NotificationType {
  appointment,
  medication,
  results,
  system,
}

// Clase para almacenar información de una notificación
class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final String date;
  final String fullContent;
  bool isRead;
  final NotificationType type;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.date,
    required this.fullContent,
    required this.isRead,
    required this.type,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedIndex = 9; // Índice específico para la página de notificaciones

  // Lista de notificaciones de ejemplo
  List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: 'Nueva cita confirmada',
      message: 'Su cita con el Dr. Martínez para mañana a las 10:30 ha sido confirmada.',
      time: '10 min',
      date: '22 Nov 2023',
      fullContent: 'Estimado paciente,\n\nLe confirmamos que su cita con el Dr. Carlos Martínez en el departamento de Medicina General ha sido confirmada para mañana, 23 de noviembre de 2023, a las 10:30 horas.\n\nPor favor, llegue 15 minutos antes de la hora programada y traiga consigo su documento de identidad y tarjeta sanitaria.\n\nSi necesita cancelar o reprogramar su cita, hágalo con al menos 24 horas de antelación.\n\nGracias por confiar en Clínica Médica.',
      isRead: false,
      type: NotificationType.appointment,
    ),
    NotificationItem(
      id: '2',
      title: 'Recordatorio de medicación',
      message: 'Es hora de tomar su medicación prescrita. No olvide seguir el tratamiento.',
      time: '1 hora',
      date: '22 Nov 2023',
      fullContent: 'Recordatorio de medicación:\n\nEs momento de tomar su dosis de Paracetamol 500mg.\n\nRecuerde tomar este medicamento con alimentos y beber suficiente agua.\n\nNo omita ninguna dosis para garantizar la efectividad del tratamiento. Si experimenta algún efecto secundario, contacte a su médico inmediatamente.\n\nSu salud es nuestra prioridad.',
      isRead: false,
      type: NotificationType.medication,
    ),
    NotificationItem(
      id: '3',
      title: 'Resultados disponibles',
      message: 'Los resultados de su análisis de sangre ya están disponibles para consulta.',
      time: '3 horas',
      date: '22 Nov 2023',
      fullContent: 'Estimado paciente,\n\nLe informamos que los resultados de su análisis de sangre realizado el 20 de noviembre de 2023 ya están disponibles en su portal de paciente.\n\nPuede acceder a ellos desde la sección "Mis resultados" o descargarlos directamente desde esta notificación.\n\nSu médico ha sido notificado y revisará los resultados en su próxima consulta. Si hay algún hallazgo que requiera atención inmediata, nos pondremos en contacto con usted.\n\nGracias por confiar en nuestros servicios.',
      isRead: true,
      type: NotificationType.results,
    ),
    NotificationItem(
      id: '4',
      title: 'Actualización de la aplicación',
      message: 'Hemos mejorado la experiencia del usuario y corregido algunos errores.',
      time: '1 día',
      date: '21 Nov 2023',
      fullContent: 'Estimado usuario,\n\nHemos lanzado una nueva actualización de la aplicación Clínica Médica (versión 2.1.0) con las siguientes mejoras:\n\n• Nuevo diseño de la pantalla de citas\n• Mejoras en el rendimiento y velocidad de la aplicación\n• Corrección de errores en el calendario\n• Nueva funcionalidad para compartir resultados\n• Soporte para documentos adjuntos en mensajes\n\nLa actualización se instalará automáticamente la próxima vez que reinicie la aplicación.\n\nAgradecemos sus comentarios y sugerencias que nos ayudan a mejorar continuamente.',
      isRead: true,
      type: NotificationType.system,
    ),
    NotificationItem(
      id: '5',
      title: 'Recordatorio de vacunación',
      message: 'Su vacuna anual contra la gripe está programada para la próxima semana.',
      time: '2 días',
      date: '20 Nov 2023',
      fullContent: 'Recordatorio de vacunación:\n\nLe recordamos que tiene programada su vacuna anual contra la gripe para el día 27 de noviembre a las 15:00 horas en nuestra clínica.\n\nLa vacunación es una medida preventiva importante, especialmente durante la temporada de gripe.\n\nNo necesita ayuno ni preparación especial. El proceso tomará aproximadamente 15 minutos, incluido el tiempo de observación posterior.\n\nSi ha tenido fiebre en los últimos días o alguna reacción alérgica a vacunas anteriores, por favor infórmenos antes de su cita.',
      isRead: false,
      type: NotificationType.appointment,
    ),
  ];

  // Filtros para las notificaciones
  bool _showUnreadOnly = false;
  String? _selectedTypeFilter;

  // Lista filtrada de notificaciones
  List<NotificationItem> get _filteredNotifications {
    return _notifications.where((notification) {
      // Filtrar por leídas/no leídas
      if (_showUnreadOnly && notification.isRead) {
        return false;
      }

      // Filtrar por tipo
      if (_selectedTypeFilter != null) {
        String typeString = notification.type.toString().split('.').last;
        if (typeString != _selectedTypeFilter) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 700;

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
          'Notificaciones',
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
          // Botón para marcar todas como leídas
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Marcar todas como leídas',
            onPressed: () {
              setState(() {
                for (var notification in _notifications) {
                  notification.isRead = true;
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Todas las notificaciones marcadas como leídas'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
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
                            SideMenu(selectedIndex: _selectedIndex),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          children: [
                            // Filtros
                            Container(
                              padding: const EdgeInsets.all(16),
                              color: Theme.of(context).cardColor,
                              child: Row(
                                children: [
                                  // Filtro de no leídas
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Switch(
                                          value: _showUnreadOnly,
                                          onChanged: (value) {
                                            setState(() {
                                              _showUnreadOnly = value;
                                            });
                                          },
                                          activeColor: Theme.of(context).primaryColor,
                                        ),
                                        const Text(
                                          'Solo no leídas',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Filtro por tipo
                                  Expanded(
                                    child: DropdownButton<String?>(
                                      value: _selectedTypeFilter,
                                      hint: const Text('Filtrar por tipo'),
                                      isExpanded: true,
                                      items: [
                                        const DropdownMenuItem<String?>(
                                          value: null,
                                          child: Text('Todos los tipos'),
                                        ),
                                        ...NotificationType.values.map((type) {
                                          String label = '';
                                          switch (type) {
                                            case NotificationType.appointment:
                                              label = 'Citas';
                                              break;
                                            case NotificationType.medication:
                                              label = 'Medicación';
                                              break;
                                            case NotificationType.results:
                                              label = 'Resultados';
                                              break;
                                            case NotificationType.system:
                                              label = 'Sistema';
                                              break;
                                          }
                                          return DropdownMenuItem<String>(
                                            value: type.toString().split('.').last,
                                            child: Text(label),
                                          );
                                        }).toList(),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedTypeFilter = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Lista de notificaciones
                            Expanded(
                              child: _filteredNotifications.isEmpty
                                  ? _buildEmptyState()
                                  : ListView.separated(
                                      padding: const EdgeInsets.all(0),
                                      itemCount: _filteredNotifications.length,
                                      separatorBuilder: (context, index) => const Divider(height: 1),
                                      itemBuilder: (context, index) {
                                        return NotificationTile(
                                          notification: _filteredNotifications[index],
                                          onTap: () {
                                            _openNotificationDetail(_filteredNotifications[index]);
                                          },
                                          onMarkAsRead: () {
                                            setState(() {
                                              _filteredNotifications[index].isRead = true;
                                            });
                                          },
                                        );
                                      },
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
    );
  }

  // Muestra un estado vacío cuando no hay notificaciones
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No hay notificaciones',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _showUnreadOnly
                ? 'No tienes notificaciones sin leer'
                : 'Cuando recibas notificaciones, aparecerán aquí',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Abre la pantalla de detalle de notificación
  void _openNotificationDetail(NotificationItem notification) {
    // Marcar como leída al abrir
    if (!notification.isRead) {
      setState(() {
        notification.isRead = true;
      });
    }

    // Navegar a la pantalla de detalle
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotificationDetailScreen(notification: notification),
      ),
    );
  }
}

// Widget para mostrar una notificación individual
class NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;

  const NotificationTile({
    Key? key,
    required this.notification,
    required this.onTap,
    required this.onMarkAsRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = notification.isRead
        ? Colors.transparent
        : Theme.of(context).primaryColor.withOpacity(0.05);

    return InkWell(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono según tipo de notificación
            Container(
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _getNotificationColor(notification.type).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getNotificationIcon(notification.type),
                color: _getNotificationColor(notification.type),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

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
                            fontSize: 16,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.grey[800],
                          ),
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
                      fontSize: 14,
                      height: 1.4,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${notification.time} · ${notification.date}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      const Spacer(),
                      if (!notification.isRead)
                        TextButton(
                          onPressed: onMarkAsRead,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Marcar como leído',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Indicador de no leída
            if (!notification.isRead)
              Container(
                width: 12,
                height: 12,
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

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.appointment:
        return Icons.calendar_today;
      case NotificationType.medication:
        return Icons.medication;
      case NotificationType.results:
        return Icons.description;
      case NotificationType.system:
        return Icons.info;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    const baseColor = Color(0xFF5f89c5);

    switch (type) {
      case NotificationType.appointment:
        return baseColor;
      case NotificationType.medication:
        return Colors.orange;
      case NotificationType.results:
        return Colors.green;
      case NotificationType.system:
        return Color(0xFF8BACE0); // Versión más clara del color principal
    }
  }
}

