import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;
import '../home/home_screen.dart';
import '../appointments/appointments_screen.dart';
import '../productos/productos_screen.dart';
import '../messages/messages_screen.dart';
import '../../widgets/side_menu.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({Key? key}) : super(key: key);

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  int _selectedIndex = 6; // Séptima opción seleccionada (Historial)
  int _selectedFilter = 0; // Filtro seleccionado por defecto

  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'Todos',
    'Consultas',
    'Pruebas',
    'Tratamientos',
    'Cirugías'
  ];

  final List<_HistorialItem> _historialItems = [
    _HistorialItem(
      fecha: '15 Nov 2023',
      tipo: 'Consulta',
      especialidad: 'Medicina General',
      doctor: 'Dr. Juan Martínez',
      diagnostico: 'Gripe estacional',
      descripcion: 'Paciente presenta síntomas de gripe estacional con fiebre moderada, dolor de garganta y congestión nasal. Se recomienda reposo y tratamiento sintomático.',
      tratamiento: 'Paracetamol 500mg cada 8 horas. Abundantes líquidos. Reposo 48 horas.',
      estado: 'Completado',
      tieneDocumentos: true,
    ),
    _HistorialItem(
      fecha: '28 Oct 2023',
      tipo: 'Prueba',
      especialidad: 'Laboratorio',
      doctor: 'Dra. María López',
      diagnostico: 'Análisis de sangre completo',
      descripcion: 'Análisis de sangre rutinario para control anual. Valores dentro de los rangos normales excepto ligera elevación de colesterol.',
      tratamiento: 'Seguimiento en 6 meses. Recomendaciones dietéticas.',
      estado: 'Completado',
      tieneDocumentos: true,
    ),
    _HistorialItem(
      fecha: '10 Sep 2023',
      tipo: 'Tratamiento',
      especialidad: 'Fisioterapia',
      doctor: 'Dr. Carlos Ruiz',
      diagnostico: 'Contractura lumbar',
      descripcion: 'Sesión de fisioterapia para tratar contractura muscular en zona lumbar. Se aplicaron técnicas de masaje y estiramientos.',
      tratamiento: 'Serie de ejercicios diarios. Aplicación de calor local. Próxima sesión en 7 días.',
      estado: 'En curso',
      tieneDocumentos: false,
    ),
    _HistorialItem(
      fecha: '05 Ago 2023',
      tipo: 'Consulta',
      especialidad: 'Dermatología',
      doctor: 'Dra. Laura Sánchez',
      diagnostico: 'Dermatitis atópica',
      descripcion: 'Paciente presenta brote de dermatitis atópica en zona de pliegues de brazos y cuello. Irritación moderada y picor intenso.',
      tratamiento: 'Crema de corticoides de baja potencia durante 7 días. Evitar irritantes y usar jabón neutro.',
      estado: 'Completado',
      tieneDocumentos: true,
    ),
    _HistorialItem(
      fecha: '20 Jul 2023',
      tipo: 'Cirugía',
      especialidad: 'Cirugía Menor',
      doctor: 'Dr. Alberto Torres',
      diagnostico: 'Extirpación de nevus',
      descripcion: 'Procedimiento quirúrgico menor para extirpación de nevus en región dorsal. Se envió muestra a anatomía patológica.',
      tratamiento: 'Curas locales cada 48h. Retirada de puntos en 10 días. Evitar exposición solar directa.',
      estado: 'Completado',
      tieneDocumentos: true,
    ),
    _HistorialItem(
      fecha: '02 Jun 2023',
      tipo: 'Prueba',
      especialidad: 'Radiología',
      doctor: 'Dr. Javier Gómez',
      diagnostico: 'Radiografía de tórax',
      descripcion: 'Radiografía de tórax para descartar patología pulmonar. No se observan hallazgos significativos.',
      tratamiento: 'No requiere tratamiento específico.',
      estado: 'Completado',
      tieneDocumentos: true,
    ),
  ];

  List<_HistorialItem> get _filteredHistorial {
    List<_HistorialItem> filtered = _historialItems;

    if (_selectedFilter != 0) {
      String filterType = _filters[_selectedFilter];
      filtered = filtered.where((item) => item.tipo == filterType).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((item) =>
        item.especialidad.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        item.doctor.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        item.diagnostico.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

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
                  SideMenu(selectedIndex: _selectedIndex),
                ],
              ),
            ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Historial Médico',
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
            icon: const Icon(Icons.file_download_outlined, size: 20),
            onPressed: () {
              _showExportOptions(context);
            },
            tooltip: 'Exportar historial',
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
                        color: Colors.white,
                        child: Column(
                          children: [
                            // Filtros y búsqueda
                            _buildSearchAndFilterBar(),

                            // Título y resumen
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(  // Envuelvo esta columna en Expanded para darle prioridad de espacio
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Historial médico',
                                          style: textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Consulta tu historial de visitas y resultados',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),  // Espacio entre las columnas
                                  ConstrainedBox(  // Limitar el ancho máximo de la tarjeta de resumen
                                    constraints: const BoxConstraints(maxWidth: 150),
                                    child: _ResumenCard(
                                      total: _historialItems.length,
                                      consultas: _historialItems.where((item) => item.tipo == 'Consulta').length,
                                      pruebas: _historialItems.where((item) => item.tipo == 'Prueba').length,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Línea de tiempo
                            Expanded(
                              child: _filteredHistorial.isEmpty
                                ? _buildEmptyState()
                                : ListView.builder(
                                    padding: const EdgeInsets.all(16),
                                    itemCount: _filteredHistorial.length,
                                    itemBuilder: (context, index) {
                                      final item = _filteredHistorial[index];
                                      return _HistorialTimelineItem(
                                        historialItem: item,
                                        onTap: () => _showHistorialDetails(context, item),
                                        isFirst: index == 0,
                                        isLast: index == _filteredHistorial.length - 1,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
        child: const Icon(Icons.add),
        tooltip: 'Nueva cita',
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

  Widget _buildSearchAndFilterBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      color: Colors.grey[50],
      child: Row(
        children: [
          // Barra de búsqueda
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar en historial...',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = "";
                            });
                          },
                          child: Icon(Icons.clear, color: Colors.grey[400], size: 20),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Filtro
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: PopupMenuButton<int>(
              offset: const Offset(0, 40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(Icons.filter_list, size: 18, color: Colors.grey[700]),
                    const SizedBox(width: 4),
                    Text(
                      _filters[_selectedFilter],
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
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
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No se encontraron resultados',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta con otros filtros o términos de búsqueda',
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

  void _showHistorialDetails(BuildContext context, _HistorialItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _getTipoColor(item.tipo).withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Modificado: Envolví la fila en Flexible para evitar overflow
                      Flexible(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _getTipoIcon(item.tipo),
                                color: _getTipoColor(item.tipo),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item.tipo} - ${item.especialidad}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    item.fecha,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 24),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero, // Reducir padding
                        constraints: BoxConstraints.tightFor(width: 32, height: 32), // Tamaño fijo más pequeño
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getEstadoColor(item.estado).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getEstadoColor(item.estado),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      item.estado,
                      style: TextStyle(
                        color: _getEstadoColor(item.estado),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Contenido
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor
                    _DetailSection(
                      title: 'Doctor',
                      content: item.doctor,
                      icon: Icons.person,
                    ),

                    const SizedBox(height: 16),

                    // Diagnóstico
                    _DetailSection(
                      title: 'Diagnóstico',
                      content: item.diagnostico,
                      icon: Icons.medical_information,
                    ),

                    const SizedBox(height: 16),

                    // Descripción
                    _DetailSection(
                      title: 'Descripción',
                      content: item.descripcion,
                      icon: Icons.description,
                    ),

                    const SizedBox(height: 16),

                    // Tratamiento
                    _DetailSection(
                      title: 'Tratamiento',
                      content: item.tratamiento,
                      icon: Icons.healing,
                    ),

                    if (item.tieneDocumentos) ...[
                      const SizedBox(height: 24),

                      // Documentos adjuntos
                      const Text(
                        'Documentos adjuntos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Lista de documentos
                      _DocumentItem(
                        nombre: 'Informe_${item.tipo}_${item.fecha.replaceAll(' ', '_')}.pdf',
                        tamano: '0.5 MB',
                        icono: Icons.picture_as_pdf,
                        color: Colors.red,
                      ),

                      if (item.tipo == 'Prueba') ...[
                        _DocumentItem(
                          nombre: 'Resultados_Laboratorio_${item.fecha.replaceAll(' ', '_')}.pdf',
                          tamano: '1.2 MB',
                          icono: Icons.analytics,
                          color: Colors.blue,
                        ),
                      ],

                      if (item.tipo == 'Radiografía' || item.tipo == 'Prueba') ...[
                        _DocumentItem(
                          nombre: 'Imagen_${item.fecha.replaceAll(' ', '_')}.jpg',
                          tamano: '3.4 MB',
                          icono: Icons.image,
                          color: Colors.green,
                        ),
                      ],
                    ],

                    const SizedBox(height: 30),

                    // Botones de acción - Modificados para evitar overflow
                    const SizedBox(height: 30),

                    Column(  // Cambiado de Row a Column para evitar overflow
                      children: [
                        SizedBox(  // Botón Compartir a ancho completo
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.share, size: 16),
                            label: const Text('Compartir'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                              side: BorderSide(color: Colors.grey[300]!),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(  // Botón Descargar a ancho completo
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.file_download, size: 16),
                            label: const Text('Descargar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExportOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exportar historial médico'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Selecciona el formato en el que deseas exportar tu historial médico',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            _ExportOption(
              title: 'PDF',
              description: 'Documento portable con formato',
              icon: Icons.picture_as_pdf,
              color: Colors.red,
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exportando a PDF...')),
                );
              },
            ),
            _ExportOption(
              title: 'Excel',
              description: 'Hoja de cálculo editable',
              icon: Icons.table_chart,
              color: Colors.green,
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exportando a Excel...')),
                );
              },
            ),
            _ExportOption(
              title: 'Texto',
              description: 'Archivo de texto plano',
              icon: Icons.text_snippet,
              color: Colors.blue,
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exportando a texto plano...')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  Color _getTipoColor(String tipo) {
    switch (tipo) {
      case 'Consulta':
        return Colors.blue;
      case 'Prueba':
        return Colors.purple;
      case 'Tratamiento':
        return Colors.orange;
      case 'Cirugía':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getTipoIcon(String tipo) {
    switch (tipo) {
      case 'Consulta':
        return Icons.medical_services;
      case 'Prueba':
        return Icons.science;
      case 'Tratamiento':
        return Icons.healing;
      case 'Cirugía':
        return Icons.cut;
      default:
        return Icons.event_note;
    }
  }

  Color _getEstadoColor(String estado) {
    switch (estado) {
      case 'Completado':
        return Colors.green;
      case 'En curso':
        return Colors.orange;
      case 'Pendiente':
        return Colors.blue;
      case 'Cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _HistorialItem {
  final String fecha;
  final String tipo;
  final String especialidad;
  final String doctor;
  final String diagnostico;
  final String descripcion;
  final String tratamiento;
  final String estado;
  final bool tieneDocumentos;

  _HistorialItem({
    required this.fecha,
    required this.tipo,
    required this.especialidad,
    required this.doctor,
    required this.diagnostico,
    required this.descripcion,
    required this.tratamiento,
    required this.estado,
    required this.tieneDocumentos,
  });
}

class _HistorialTimelineItem extends StatelessWidget {
  final _HistorialItem historialItem;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;

  const _HistorialTimelineItem({
    required this.historialItem,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    Color tipoColor = _getTipoColor(historialItem.tipo);

    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Línea de tiempo
          SizedBox(
            width: 40,
            child: Column(
              children: [
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: tipoColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: tipoColor,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    _getTipoIcon(historialItem.tipo),
                    size: 12,
                    color: tipoColor,
                  ),
                ),
                if (!isLast)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: 2,
                      height: 60,
                      color: Colors.grey[300],
                    ),
                  ),
              ],
            ),
          ),

          // Contenido
          Expanded(
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fecha y tipo
                    Row(
                      children: [
                        Text(
                          historialItem.fecha,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: tipoColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            historialItem.tipo,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: tipoColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getEstadoColor(historialItem.estado).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: _getEstadoColor(historialItem.estado),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            historialItem.estado,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getEstadoColor(historialItem.estado),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Especialidad y doctor - MODIFICADO PARA EVITAR OVERFLOW
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            historialItem.especialidad,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '·',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            historialItem.doctor,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Diagnóstico
                    Text(
                      historialItem.diagnostico,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),

                    // Descripción
                    Text(
                      historialItem.descripcion,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Documentos e iconos
                    Row(
                      children: [
                        if (historialItem.tieneDocumentos) ...[
                          Icon(
                            Icons.attach_file,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Documentos adjuntos',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTipoColor(String tipo) {
    switch (tipo) {
      case 'Consulta':
        return Colors.blue;
      case 'Prueba':
        return Colors.purple;
      case 'Tratamiento':
        return Colors.orange;
      case 'Cirugía':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getTipoIcon(String tipo) {
    switch (tipo) {
      case 'Consulta':
        return Icons.medical_services;
      case 'Prueba':
        return Icons.science;
      case 'Tratamiento':
        return Icons.healing;
      case 'Cirugía':
        return Icons.cut;
      default:
        return Icons.event_note;
    }
  }

  Color _getEstadoColor(String estado) {
    switch (estado) {
      case 'Completado':
        return Colors.green;
      case 'En curso':
        return Colors.orange;
      case 'Pendiente':
        return Colors.blue;
      case 'Cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const _DetailSection({
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[800],
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final String nombre;
  final String tamano;
  final IconData icono;
  final Color color;

  const _DocumentItem({
    required this.nombre,
    required this.tamano,
    required this.icono,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icono,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          nombre,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          tamano,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        // Modificado: Se ha eliminado el tamaño fijo y ahora usamos un wrap para los botones
        trailing: Wrap(
          spacing: 4, // Espacio entre los iconos
          children: [
            IconButton(
              icon: Icon(
                Icons.visibility,
                color: Colors.grey[600],
                size: 20,
              ),
              onPressed: () {},
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
            ),
            IconButton(
              icon: Icon(
                Icons.file_download,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              onPressed: () {},
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExportOption extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ExportOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumenCard extends StatelessWidget {
  final int total;
  final int consultas;
  final int pruebas;

  const _ResumenCard({
    required this.total,
    required this.consultas,
    required this.pruebas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),  // Reduje el padding horizontal de 12 a 8
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$total registros',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Theme.of(context).primaryColor,
            ),
            overflow: TextOverflow.ellipsis,  // Añadido para prevenir desbordamiento
          ),
          // Modificado para mostrar en dos líneas en lugar de usar FittedBox
          Text(
            '$consultas consultas',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryColor.withOpacity(0.8),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '$pruebas pruebas',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryColor.withOpacity(0.8),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
