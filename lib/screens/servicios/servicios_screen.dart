import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;
import '../home/home_screen.dart';
import '../appointments/appointments_screen.dart';
import '../productos/productos_screen.dart';
import '../messages/messages_screen.dart';
import '../noticias/noticias_screen.dart';
import '../../widgets/side_menu.dart';

class ServiciosScreen extends StatefulWidget {
  const ServiciosScreen({Key? key}) : super(key: key);

  @override
  State<ServiciosScreen> createState() => _ServiciosScreenState();
}

class _ServiciosScreenState extends State<ServiciosScreen> {
  int _selectedIndex = 5; // Sexta opción seleccionada (Servicios)
  int _selectedCategory = 0; // Categoría seleccionada por defecto

  final List<String> _categories = [
    'Todos',
    'Consultas',
    'Especialidades',
    'Diagnóstico',
    'Tratamientos',
    'Cirugías'
  ];

  final List<_ServiceItem> _serviceItems = [
    _ServiceItem(
      title: 'Consulta de Medicina General',
      description: 'Evaluación médica completa por un médico de medicina general para detectar problemas de salud y proporcionar diagnóstico y tratamiento.',
      price: '€60',
      duration: '30 min',
      imageUrl: 'assets/images/general.jpg',
      category: 'Consultas',
      featured: true,
    ),
    _ServiceItem(
      title: 'Dermatología',
      description: 'Diagnóstico y tratamiento de afecciones de la piel, cabello y uñas por un especialista dermatólogo certificado.',
      price: '€80',
      duration: '45 min',
      imageUrl: 'assets/images/dermatology.jpg',
      category: 'Especialidades',
    ),
    _ServiceItem(
      title: 'Radiografía Digital',
      description: 'Imagen radiográfica de alta resolución que permite visualizar con claridad huesos y estructuras internas para diagnóstico preciso.',
      price: '€75',
      duration: '15 min',
      imageUrl: 'assets/images/xray.jpg',
      category: 'Diagnóstico',
    ),
    _ServiceItem(
      title: 'Fisioterapia',
      description: 'Terapia física personalizada para recuperar movilidad y aliviar dolor muscular y articular con profesionales especializados.',
      price: '€55',
      duration: '60 min',
      imageUrl: 'assets/images/physiotherapy.jpg',
      category: 'Tratamientos',
    ),
    _ServiceItem(
      title: 'Análisis Clínicos Completos',
      description: 'Panel completo de análisis de sangre que incluye hemograma, bioquímica, perfil lipídico y otros parámetros esenciales.',
      price: '€120',
      duration: '10 min',
      imageUrl: 'assets/images/labtest.jpg',
      category: 'Diagnóstico',
    ),
    _ServiceItem(
      title: 'Cardiología',
      description: 'Evaluación cardíaca completa incluyendo electrocardiograma y valoración por cardiólogo especialista.',
      price: '€95',
      duration: '45 min',
      imageUrl: 'assets/images/cardiology.jpg',
      category: 'Especialidades',
    ),
    _ServiceItem(
      title: 'Cirugía Menor',
      description: 'Procedimientos quirúrgicos menores realizados con anestesia local en nuestra clínica sin necesidad de hospitalización.',
      price: '€200',
      duration: '60 min',
      imageUrl: 'assets/images/surgery.jpg',
      category: 'Cirugías',
    ),
    _ServiceItem(
      title: 'Pediatría',
      description: 'Atención médica especializada para niños y adolescentes, con enfoque preventivo y atención de enfermedades pediátricas.',
      price: '€70',
      duration: '40 min',
      imageUrl: 'assets/images/pediatrics.jpg',
      category: 'Especialidades',
    ),
  ];

  List<_ServiceItem> get _filteredServices {
    if (_selectedCategory == 0) {
      return _serviceItems;
    } else {
      return _serviceItems.where((item) => item.category == _categories[_selectedCategory]).toList();
    }
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
          'Servicios',
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
          IconButton(
            icon: const Icon(Icons.filter_list, size: 20),
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
                            SideMenu(selectedIndex: _selectedIndex),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            // Categorías
                            _buildCategoriesHeader(),

                            // Servicio destacado
                            if (_filteredServices.any((item) => item.featured))
                              _FeaturedServiceCard(
                                serviceItem: _filteredServices.firstWhere((item) => item.featured),
                                onTap: () => _showServiceDetails(context, _filteredServices.firstWhere((item) => item.featured)),
                              ),

                            // Lista de servicios
                            Expanded(
                              child: isLargeScreen
                                ? _buildServiceGrid()
                                : _buildServiceList(),
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
          // Navegar a la pantalla de citas para agendar un nuevo servicio
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
        child: const Icon(Icons.add_circle_outline),
        tooltip: 'Agendar servicio',
      ),
      bottomNavigationBar: isLargeScreen
          ? null
          : BottomNavigationBar(
              currentIndex: 0, // Siempre mostrar Home como seleccionado en esta pantalla
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

  void _showServiceDetails(BuildContext context, _ServiceItem service) {
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
            // Imagen del servicio
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  // Aquí iría la imagen real
                  Center(
                    child: Icon(
                      Icons.medical_services_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                  ),
                  // Botón para cerrar
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.close, size: 18, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  // Categoría
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        service.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Contenido
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título y precio
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            service.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            service.price,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Duración
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Duración: ${service.duration}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Descripción
                    const Text(
                      'Descripción',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Información adicional
                    const Text(
                      'Información adicional',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _InfoItem(
                      icon: Icons.verified_user_outlined,
                      title: 'Profesionales certificados',
                      description: 'Todos nuestros especialistas cuentan con certificaciones y amplia experiencia.',
                    ),
                    _InfoItem(
                      icon: Icons.medical_services_outlined,
                      title: 'Equipamiento moderno',
                      description: 'Utilizamos tecnología de última generación para todos nuestros procedimientos.',
                    ),
                    _InfoItem(
                      icon: Icons.healing_outlined,
                      title: 'Atención personalizada',
                      description: 'Adaptamos nuestros servicios a las necesidades específicas de cada paciente.',
                    ),

                    const SizedBox(height: 32),

                    // Botón de reserva
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Reservar cita',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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

  Widget _buildServiceList() {
    final nonFeaturedServices = _filteredServices.where((item) => !item.featured).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: nonFeaturedServices.length,
      itemBuilder: (context, index) {
        return _ServiceCard(
          serviceItem: nonFeaturedServices[index],
          onTap: () => _showServiceDetails(context, nonFeaturedServices[index]),
        );
      },
    );
  }

  Widget _buildServiceGrid() {
    final nonFeaturedServices = _filteredServices.where((item) => !item.featured).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: nonFeaturedServices.length,
      itemBuilder: (context, index) {
        return _ServiceGridCard(
          serviceItem: nonFeaturedServices[index],
          onTap: () => _showServiceDetails(context, nonFeaturedServices[index]),
        );
      },
    );
  }

  Widget _buildCategoriesHeader() {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Text(
                _categories[index],
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.grey[800],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ServiceItem {
  final String title;
  final String description;
  final String price;
  final String duration;
  final String imageUrl;
  final String category;
  final bool featured;

  _ServiceItem({
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
    required this.imageUrl,
    required this.category,
    this.featured = false,
  });
}

class _ServiceCard extends StatelessWidget {
  final _ServiceItem serviceItem;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.serviceItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icono o imagen
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              const SizedBox(width: 16),

              // Contenido
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categoría
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        serviceItem.category,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Título
                    Text(
                      serviceItem.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Descripción breve
                    Text(
                      serviceItem.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Precio y duración
                    Row(
                      children: [
                        Icon(
                          Icons.euro,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          serviceItem.price.substring(1), // Quitar el símbolo de euro para evitar duplicación
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          serviceItem.duration,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Flecha
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

class _ServiceGridCard extends StatelessWidget {
  final _ServiceItem serviceItem;
  final VoidCallback onTap;

  const _ServiceGridCard({
    required this.serviceItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icono y categoría
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.medical_services_outlined,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      serviceItem.category,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Título
              Text(
                serviceItem.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Precio y duración
              Row(
                children: [
                  Icon(
                    Icons.euro,
                    size: 14,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    serviceItem.price.substring(1),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 2),
                  Text(
                    serviceItem.duration,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Botón
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Ver detalles'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedServiceCard extends StatelessWidget {
  final _ServiceItem serviceItem;
  final VoidCallback onTap;

  const _FeaturedServiceCard({
    required this.serviceItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen destacada
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: Icon(
                        Icons.medical_services_outlined,
                        size: 60,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'DESTACADO',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.euro,
                              color: Theme.of(context).primaryColor,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              serviceItem.price.substring(1),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Contenido
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categoría y duración
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            serviceItem.category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          serviceItem.duration,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Título
                    Text(
                      serviceItem.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Descripción
                    Text(
                      serviceItem.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 16),

                    // Botón de reserva
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Reservar ahora',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).primaryColor,
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

