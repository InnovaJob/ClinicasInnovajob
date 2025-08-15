import 'package:flutter/material.dart';
import 'notifications_screen.dart';

class NotificationDetailScreen extends StatefulWidget {
  final NotificationItem notification;

  const NotificationDetailScreen({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  State<NotificationDetailScreen> createState() => _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  late NotificationItem _notification;

  @override
  void initState() {
    super.initState();
    _notification = widget.notification;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle de notificación',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          // Botón para marcar como leída/no leída
          IconButton(
            icon: Icon(_notification.isRead ? Icons.mark_email_unread : Icons.mark_email_read),
            tooltip: _notification.isRead ? 'Marcar como no leída' : 'Marcar como leída',
            onPressed: _toggleReadStatus,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con icono y título
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getNotificationColor(_notification.type).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getNotificationIcon(_notification.type),
                    color: _getNotificationColor(_notification.type),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _notification.title,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${_notification.time} · ${_notification.date}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // Contenido completo de la notificación
            Text(
              _notification.fullContent,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                height: 1.6,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey[800],
              ),
            ),

            const SizedBox(height: 32),

            // Botones de acción según el tipo de notificación
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  // Cambia el estado de leída/no leída
  void _toggleReadStatus() {
    setState(() {
      _notification.isRead = !_notification.isRead;
    });

    String message = _notification.isRead
        ? 'Notificación marcada como leída'
        : 'Notificación marcada como no leída';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Construye botones de acción según el tipo de notificación
  Widget _buildActionButtons() {
    switch (_notification.type) {
      case NotificationType.appointment:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.event),
              label: const Text('Ver detalles de la cita'),
              onPressed: () {
                // Navegar a la pantalla de detalles de cita
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.edit_calendar),
              label: const Text('Reprogramar'),
              onPressed: () {
                // Navegar a la pantalla de reprogramación
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        );

      case NotificationType.medication:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.check_circle),
              label: const Text('Marcar como tomada'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Medicación marcada como tomada'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.info_outline),
              label: const Text('Ver información del medicamento'),
              onPressed: () {
                // Navegar a la pantalla de información del medicamento
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        );

      case NotificationType.results:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.visibility),
              label: const Text('Ver resultados'),
              onPressed: () {
                // Navegar a la pantalla de resultados
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text('Descargar PDF'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Descargando resultados...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        );

      case NotificationType.system:
        return Center(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.check_circle),
            label: const Text('Entendido'),
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
          ),
        );
    }
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

