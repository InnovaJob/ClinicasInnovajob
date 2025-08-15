import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;
import '../home/home_screen.dart';
import '../appointments/appointments_screen.dart';
import '../productos/productos_screen.dart';
import '../messages/messages_screen.dart';
import '../../widgets/side_menu.dart';

class MedicamentosScreen extends StatefulWidget {
  const MedicamentosScreen({Key? key}) : super(key: key);

  @override
  State<MedicamentosScreen> createState() => _MedicamentosScreenState();
}

class _MedicamentosScreenState extends State<MedicamentosScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 9; // Índice específico para esta pantalla en el menú lateral
  late TabController _tabController;
  bool _showCompleted = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = MediaQuery.of(context).size.width > 700;
    final primaryColor = Theme.of(context).primaryColor;

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
          'Mis Medicamentos',
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
            icon: const Icon(Icons.calendar_today, size: 22),
            onPressed: () {
              _showMedicationSchedule(context);
            },
          ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.7),
              labelStyle: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              tabs: const [
                Tab(text: 'Actuales'),
                Tab(text: 'Historial'),
                Tab(text: 'Recordatorios'),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          AnimatedBackground(),
          Column(
            children: [
              SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 48),
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
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildCurrentMedicationsTab(),
                            _buildHistoryTab(),
                            _buildRemindersTab(),
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
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          _showAddMedicationDialog(context);
        },
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

  // Tab de medicamentos actuales
  Widget _buildCurrentMedicationsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filtros y búsqueda
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar medicamento',
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              PopupMenuButton<String>(
                icon: Icon(Icons.filter_list, color: Theme.of(context).primaryColor),
                tooltip: 'Filtrar',
                onSelected: (value) {
                  // Implementar filtrado
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'all',
                    child: Text('Todos'),
                  ),
                  const PopupMenuItem(
                    value: 'active',
                    child: Text('Activos'),
                  ),
                  const PopupMenuItem(
                    value: 'almost_finished',
                    child: Text('Por terminar'),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Título de sección - Ajustado para evitar overflow
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Medicamentos Actuales',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        'Mostrar completados',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Switch(
                      value: _showCompleted,
                      onChanged: (value) {
                        setState(() {
                          _showCompleted = value;
                        });
                      },
                      activeColor: Theme.of(context).primaryColor,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Lista de medicamentos
          Expanded(
            child: ListView(
              children: [
                _MedicationCard(
                  name: 'Paracetamol',
                  dosage: '500mg',
                  frequency: 'Cada 8 horas',
                  startDate: '15 Nov 2023',
                  endDate: '22 Nov 2023',
                  remainingDays: 5,
                  instructions: 'Tomar con agua después de las comidas',
                  isTakenToday: true,
                  onTakenToggle: (value) {},
                ),
                _MedicationCard(
                  name: 'Ibuprofeno',
                  dosage: '400mg',
                  frequency: 'Cada 12 horas',
                  startDate: '16 Nov 2023',
                  endDate: '20 Nov 2023',
                  remainingDays: 3,
                  instructions: 'Tomar con alimentos para evitar malestar estomacal',
                  isTakenToday: false,
                  onTakenToggle: (value) {},
                ),
                _MedicationCard(
                  name: 'Amoxicilina',
                  dosage: '250mg',
                  frequency: 'Cada 8 horas',
                  startDate: '12 Nov 2023',
                  endDate: '19 Nov 2023',
                  remainingDays: 2,
                  instructions: 'Completar todo el tratamiento aunque los síntomas mejoren',
                  isTakenToday: false,
                  onTakenToggle: (value) {},
                ),
                _MedicationCard(
                  name: 'Loratadina',
                  dosage: '10mg',
                  frequency: 'Una vez al día',
                  startDate: '10 Nov 2023',
                  endDate: '30 Nov 2023',
                  remainingDays: 13,
                  instructions: 'Tomar preferentemente por la mañana',
                  isTakenToday: true,
                  onTakenToggle: (value) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tab de historial de medicamentos
  Widget _buildHistoryTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Búsqueda
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar en historial',
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Título de sección
          Text(
            'Historial de Medicamentos',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.grey[800],
            ),
          ),

          const SizedBox(height: 16),

          // Lista de medicamentos pasados
          Expanded(
            child: ListView(
              children: [
                _PastMedicationItem(
                  name: 'Azitromicina',
                  dosage: '500mg',
                  period: '15 Oct 2023 - 20 Oct 2023',
                  doctor: 'Dr. Carlos Martínez',
                ),
                _PastMedicationItem(
                  name: 'Diclofenaco',
                  dosage: '100mg',
                  period: '5 Oct 2023 - 12 Oct 2023',
                  doctor: 'Dra. Laura Fernández',
                ),
                _PastMedicationItem(
                  name: 'Cetirizina',
                  dosage: '10mg',
                  period: '1 Sep 2023 - 30 Sep 2023',
                  doctor: 'Dr. Roberto Álvarez',
                ),
                _PastMedicationItem(
                  name: 'Prednisona',
                  dosage: '20mg',
                  period: '10 Ago 2023 - 20 Ago 2023',
                  doctor: 'Dra. María González',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Tab de recordatorios de medicamentos
  Widget _buildRemindersTab() {
    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de sección
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mis Recordatorios',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.grey[800],
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Nuevo'),
                onPressed: () {
                  _showAddReminderDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Texto informativo
          Text(
            'Configura recordatorios personalizados para tus medicamentos',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),

          const SizedBox(height: 24),

          // Lista de recordatorios
          Expanded(
            child: ListView(
              children: [
                _ReminderCard(
                  title: 'Paracetamol - Mañana',
                  time: '08:00',
                  days: const ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
                  isActive: true,
                  onActiveChanged: (value) {},
                ),
                _ReminderCard(
                  title: 'Paracetamol - Tarde',
                  time: '16:00',
                  days: const ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
                  isActive: true,
                  onActiveChanged: (value) {},
                ),
                _ReminderCard(
                  title: 'Paracetamol - Noche',
                  time: '00:00',
                  days: const ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
                  isActive: true,
                  onActiveChanged: (value) {},
                ),
                _ReminderCard(
                  title: 'Ibuprofeno - Mañana',
                  time: '09:00',
                  days: const ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
                  isActive: false,
                  onActiveChanged: (value) {},
                ),
                _ReminderCard(
                  title: 'Ibuprofeno - Noche',
                  time: '21:00',
                  days: const ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'],
                  isActive: true,
                  onActiveChanged: (value) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Mostrar diálogo para añadir un nuevo medicamento
  void _showAddMedicationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Añadir Medicamento'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nombre del medicamento',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Dosis',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Frecuencia',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Instrucciones',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Fecha inicio',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Fecha fin',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implementar lógica para guardar el nuevo medicamento
              Navigator.of(context).pop();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  // Mostrar diálogo para añadir un nuevo recordatorio
  void _showAddReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo Recordatorio'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Medicamento',
                ),
                items: const [
                  DropdownMenuItem(value: 'paracetamol', child: Text('Paracetamol')),
                  DropdownMenuItem(value: 'ibuprofeno', child: Text('Ibuprofeno')),
                  DropdownMenuItem(value: 'amoxicilina', child: Text('Amoxicilina')),
                  DropdownMenuItem(value: 'loratadina', child: Text('Loratadina')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Título del recordatorio',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Hora',
                  suffixIcon: Icon(Icons.access_time),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Días de la semana:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _DayChip(day: 'L', isSelected: true, onSelected: (val) {}),
                  _DayChip(day: 'M', isSelected: true, onSelected: (val) {}),
                  _DayChip(day: 'X', isSelected: true, onSelected: (val) {}),
                  _DayChip(day: 'J', isSelected: true, onSelected: (val) {}),
                  _DayChip(day: 'V', isSelected: true, onSelected: (val) {}),
                  _DayChip(day: 'S', isSelected: true, onSelected: (val) {}),
                  _DayChip(day: 'D', isSelected: true, onSelected: (val) {}),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implementar lógica para guardar el nuevo recordatorio
              Navigator.of(context).pop();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  // Mostrar el horario diario de medicación
  void _showMedicationSchedule(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Horario Diario'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ScheduleItem(
                time: '08:00',
                medications: const ['Paracetamol 500mg', 'Loratadina 10mg'],
                isCompleted: true,
              ),
              _ScheduleItem(
                time: '14:00',
                medications: const ['Amoxicilina 250mg'],
                isCompleted: false,
              ),
              _ScheduleItem(
                time: '16:00',
                medications: const ['Paracetamol 500mg', 'Ibuprofeno 400mg'],
                isCompleted: false,
              ),
              _ScheduleItem(
                time: '22:00',
                medications: const ['Amoxicilina 250mg'],
                isCompleted: false,
              ),
              _ScheduleItem(
                time: '00:00',
                medications: const ['Paracetamol 500mg'],
                isCompleted: false,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

// Widget para mostrar una tarjeta de medicamento actual
class _MedicationCard extends StatelessWidget {
  final String name;
  final String dosage;
  final String frequency;
  final String startDate;
  final String endDate;
  final int remainingDays;
  final String instructions;
  final bool isTakenToday;
  final Function(bool) onTakenToggle;

  const _MedicationCard({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    required this.remainingDays,
    required this.instructions,
    required this.isTakenToday,
    required this.onTakenToggle,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.medication_outlined,
                color: primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          dosage,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    frequency,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$remainingDays días',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: remainingDays <= 3 ? Colors.orange : Colors.grey[700],
                  ),
                ),
                Text(
                  'restantes',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Período',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$startDate - $endDate',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tomado hoy',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                isTakenToday ? Icons.check_circle : Icons.circle_outlined,
                                color: isTakenToday ? Colors.green : Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isTakenToday ? 'Sí' : 'No',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: isTakenToday ? Colors.green : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Instrucciones',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  instructions,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Editar'),
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: BorderSide(color: primaryColor),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: Icon(isTakenToday ? Icons.close : Icons.check, size: 18),
                      label: Text(isTakenToday ? 'Marcar como no tomado' : 'Marcar como tomado'),
                      onPressed: () {
                        onTakenToggle(!isTakenToday);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isTakenToday ? Colors.red : Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para mostrar un elemento del historial de medicamentos
class _PastMedicationItem extends StatelessWidget {
  final String name;
  final String dosage;
  final String period;
  final String doctor;

  const _PastMedicationItem({
    required this.name,
    required this.dosage,
    required this.period,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.medication_outlined,
                color: Colors.grey[700],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          dosage,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.date_range, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        period,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.person, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Recetado por: $doctor',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.info_outline),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                // Mostrar detalles completos
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para mostrar una tarjeta de recordatorio
class _ReminderCard extends StatelessWidget {
  final String title;
  final String time;
  final List<String> days;
  final bool isActive;
  final Function(bool) onActiveChanged;

  const _ReminderCard({
    required this.title,
    required this.time,
    required this.days,
    required this.isActive,
    required this.onActiveChanged,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isActive
                    ? primaryColor.withOpacity(0.1)
                    : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_active,
                color: isActive ? primaryColor : Colors.grey,
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
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    children: days.map((day) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isActive
                              ? primaryColor.withOpacity(0.1)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          day,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            color: isActive ? primaryColor : Colors.grey[700],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Switch(
              value: isActive,
              onChanged: onActiveChanged,
              activeColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para chip de selección de día
class _DayChip extends StatelessWidget {
  final String day;
  final bool isSelected;
  final Function(bool) onSelected;

  const _DayChip({
    required this.day,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return FilterChip(
      label: Text(day),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: primaryColor.withOpacity(0.2),
      checkmarkColor: primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? primaryColor : Colors.grey[700],
      ),
    );
  }
}

// Widget para mostrar un elemento del horario
class _ScheduleItem extends StatelessWidget {
  final String time;
  final List<String> medications;
  final bool isCompleted;

  const _ScheduleItem({
    required this.time,
    required this.medications,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              time,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isCompleted ? Colors.green : Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: medications.map((med) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    children: [
                      Icon(
                        isCompleted ? Icons.check_circle : Icons.circle_outlined,
                        size: 16,
                        color: isCompleted ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        med,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.grey[800],
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          if (!isCompleted)
            IconButton(
              icon: const Icon(Icons.check_circle_outline),
              color: Colors.green,
              onPressed: () {},
              tooltip: 'Marcar como tomado',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}

