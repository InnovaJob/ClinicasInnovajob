import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;
import '../home/home_screen.dart';
import '../appointments/appointments_screen.dart';
import '../productos/productos_screen.dart';
import '../messages/messages_screen.dart';
import '../../widgets/side_menu.dart';

class NoticiasScreen extends StatefulWidget {
  const NoticiasScreen({Key? key}) : super(key: key);

  @override
  State<NoticiasScreen> createState() => _NoticiasScreenState();
}

class _NoticiasScreenState extends State<NoticiasScreen> {
  int _selectedIndex = 4; // Quinta opción seleccionada (Noticias)
  int _selectedCategory = 0; // Categoría seleccionada por defecto

  final List<String> _categories = [
    'Todas',
    'Salud',
    'Eventos',
    'Servicios',
    'Promociones'
  ];

  final List<_NewsItem> _newsItems = [
    _NewsItem(
      title: 'Inauguramos nuevo servicio de fisioterapia avanzada',
      summary: 'Nuestro centro ahora ofrece sesiones de fisioterapia con tecnología de última generación para tratar lesiones deportivas y problemas posturales.',
      date: '15 Nov 2023',
      imageUrl: 'assets/images/fisio.jpg',
      category: 'Servicios',
      featured: true,
    ),
    _NewsItem(
      title: 'Campaña de prevención del cáncer de piel',
      summary: 'Durante todo el mes de diciembre, ofreceremos revisiones gratuitas para detectar signos tempranos de cáncer de piel. Solicite su cita previa.',
      date: '10 Nov 2023',
      imageUrl: 'assets/images/skin.jpg',
      category: 'Salud',
    ),
    _NewsItem(
      title: 'Se une a nuestro equipo la Dra. Carmen Rodríguez',
      summary: 'Especialista en pediatría con más de 15 años de experiencia, la Dra. Rodríguez refuerza nuestro departamento infantil.',
      date: '5 Nov 2023',
      imageUrl: 'assets/images/doctor.jpg',
      category: 'Servicios',
    ),
    _NewsItem(
      title: 'Charla informativa: "Cómo prevenir la diabetes"',
      summary: 'El próximo 20 de noviembre a las 18:00h, nuestro equipo de nutricionistas ofrecerá una charla gratuita sobre la prevención de la diabetes tipo 2.',
      date: '1 Nov 2023',
      imageUrl: 'assets/images/diabetes.jpg',
      category: 'Eventos',
    ),
    _NewsItem(
      title: '20% de descuento en análisis clínicos',
      summary: 'Durante las próximas dos semanas, todos nuestros pacientes podrán beneficiarse de un 20% de descuento en análisis clínicos completos.',
      date: '28 Oct 2023',
      imageUrl: 'assets/images/lab.jpg',
      category: 'Promociones',
    ),
    _NewsItem(
      title: 'Consejos para mantener una buena salud mental',
      summary: 'La salud mental es tan importante como la física. Nuestros psicólogos comparten 5 consejos para cuidar tu bienestar emocional en el día a día.',
      date: '22 Oct 2023',
      imageUrl: 'assets/images/mental.jpg',
      category: 'Salud',
    ),
  ];

  // Añadir contenido completo para las noticias
  final Map<String, String> _newsContent = {
    'Inauguramos nuevo servicio de fisioterapia avanzada':
      'Nos complace anunciar la inauguración de nuestro nuevo servicio de fisioterapia avanzada, '
      'diseñado para ofrecer tratamientos especializados utilizando la tecnología más innovadora del sector médico.\n\n'
      'Nuestro departamento de fisioterapia cuenta ahora con equipos de última generación que permiten '
      'realizar tratamientos más precisos y eficaces para diversas dolencias:\n\n'
      '• Terapia con ondas de choque para lesiones tendinosas\n'
      '• Equipos de electroterapia avanzada\n'
      '• Plataformas de equilibrio computarizadas\n'
      '• Sistemas de análisis de la marcha\n'
      '• Dispositivos de terapia láser para reducción del dolor\n\n'
      'Todos los tratamientos son realizados por fisioterapeutas altamente cualificados con formación especializada '
      'en rehabilitación deportiva, tratamiento de lesiones crónicas y recuperación postquirúrgica.\n\n'
      'Los pacientes que acudan a nuestro servicio recibirán una evaluación inicial completa, '
      'tras la cual se diseñará un plan de tratamiento personalizado adaptado a sus necesidades específicas.\n\n'
      'Para celebrar la inauguración, ofrecemos un 15% de descuento en la primera sesión a todos los pacientes '
      'que reserven cita durante el primer mes.',

    'Campaña de prevención del cáncer de piel':
      'La Clínica Médica lanza una campaña de prevención del cáncer de piel que se desarrollará durante todo el mes de diciembre.\n\n'
      'El cáncer de piel es uno de los tipos de cáncer más comunes, pero también uno de los que presenta mayores tasas de curación '
      'cuando se detecta en sus fases iniciales. Por este motivo, hemos decidido poner en marcha esta importante iniciativa.\n\n'
      'Durante la campaña, nuestros dermatólogos realizarán revisiones gratuitas para detectar posibles signos de cáncer de piel. '
      'Las revisiones incluirán:\n\n'
      '• Examen visual completo de la piel\n'
      '• Dermatoscopia digital para análisis detallado de lunares sospechosos\n'
      '• Asesoramiento personalizado sobre protección solar\n'
      '• Recomendaciones para el autoexamen periódico\n\n'
      'Además de las revisiones, organizaremos charlas informativas sobre la importancia de la protección solar '
      'y los factores de riesgo asociados al cáncer de piel.\n\n'
      'Para participar en la campaña, es necesario solicitar cita previa a través de nuestra web o por teléfono. '
      'Las plazas son limitadas, por lo que recomendamos reservar lo antes posible.',

    'Se une a nuestro equipo la Dra. Carmen Rodríguez':
      'Tenemos el placer de anunciar la incorporación de la Dra. Carmen Rodríguez a nuestro equipo médico. '
      'La Dra. Rodríguez es especialista en pediatría con más de 15 años de experiencia en el tratamiento '
      'de patologías infantiles.\n\n'
      'Licenciada en Medicina por la Universidad Complutense de Madrid y con especialización en Pediatría '
      'por el Hospital La Paz, la Dra. Rodríguez ha desarrollado su carrera profesional en centros de '
      'referencia nacionales e internacionales.\n\n'
      'Su incorporación supone un importante refuerzo para nuestro departamento de pediatría, permitiéndonos '
      'ampliar la oferta de servicios y mejorar la atención a nuestros pacientes más jóvenes.\n\n'
      'La Dra. Rodríguez atenderá consultas de pediatría general y cuenta con formación específica en '
      'alergología infantil, trastornos del desarrollo y nutrición pediátrica.\n\n'
      'Las citas con la Dra. Rodríguez ya pueden solicitarse a través de nuestros canales habituales.',

    // Añade el contenido para las demás noticias...
  };

  List<_NewsItem> get _filteredNews {
    if (_selectedCategory == 0) {
      return _newsItems;
    } else {
      return _newsItems.where((item) => item.category == _categories[_selectedCategory]).toList();
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
          'Noticias',
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
            icon: const Icon(Icons.notifications_outlined, size: 20),
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

                            // Noticia destacada
                            if (_filteredNews.any((item) => item.featured))
                              _FeaturedNewsCard(
                                newsItem: _filteredNews.firstWhere((item) => item.featured),
                              ),

                            // Lista de noticias
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.all(16.0),
                                itemCount: _filteredNews.where((item) => !item.featured).length,
                                itemBuilder: (context, index) {
                                  final nonFeaturedNews = _filteredNews.where((item) => !item.featured).toList();
                                  return _NewsCard(
                                    newsItem: nonFeaturedNews[index],
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
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
        child: const Icon(Icons.share),
        tooltip: 'Compartir',
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

  // Método para mostrar el detalle de una noticia
  void _showNewsDetail(BuildContext context, _NewsItem newsItem) {
    // Buscar el contenido completo de la noticia o usar un texto por defecto
    String fullContent = _newsContent[newsItem.title] ??
        'Contenido completo de la noticia no disponible. ' + newsItem.summary;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
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
            // Imagen de portada
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.5),
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      newsItem.category,
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

            // Contenido
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fecha
                    Text(
                      newsItem.date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Título
                    Text(
                      newsItem.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Contenido completo
                    Text(
                      fullContent,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.grey[800],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Botones de acción
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Compartir noticia
                            },
                            icon: const Icon(Icons.share, size: 18),
                            label: const Text('Compartir'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(color: Colors.grey[300]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Guardar o marcar como favorito
                            },
                            icon: const Icon(Icons.bookmark_border, size: 18),
                            label: const Text('Guardar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Noticias relacionadas
                    const Text(
                      'Noticias relacionadas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Lista horizontal de noticias relacionadas
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _newsItems
                            .where((item) =>
                                item.category == newsItem.category &&
                                item.title != newsItem.title)
                            .length,
                        itemBuilder: (context, index) {
                          final relatedNews = _newsItems
                              .where((item) =>
                                  item.category == newsItem.category &&
                                  item.title != newsItem.title)
                              .toList();

                          if (relatedNews.isEmpty) return const SizedBox.shrink();

                          return _RelatedNewsCard(
                            newsItem: relatedNews[index],
                            onTap: () {
                              Navigator.pop(context);
                              _showNewsDetail(context, relatedNews[index]);
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
    );
  }
}

// ignore: must_be_immutable
class _NewsItem {
  final String title;
  final String summary;
  final String date;
  final String imageUrl;
  final String category;
  final bool featured;

  _NewsItem({
    required this.title,
    required this.summary,
    required this.date,
    required this.imageUrl,
    required this.category,
    this.featured = false,
  });
}

class _NewsCard extends StatelessWidget {
  final _NewsItem newsItem;

  const _NewsCard({
    required this.newsItem,
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
        onTap: () {
          // Cuando se pulsa en la noticia, mostrar el detalle
          (_NoticiasScreenState? state) => state?._showNewsDetail(context, newsItem);
          context.findAncestorStateOfType<_NoticiasScreenState>()
              ?._showNewsDetail(context, newsItem);
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                  ),
                ),

                // Contenido
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Categoría y fecha
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                newsItem.category,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              newsItem.date,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Título
                        Text(
                          newsItem.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Resumen
                        Text(
                          newsItem.summary,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Botones de acción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // Lógica para compartir
                    },
                    icon: const Icon(Icons.share, size: 16),
                    label: const Text('Compartir'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Mostrar el detalle al hacer clic en "Leer más"
                      context.findAncestorStateOfType<_NoticiasScreenState>()
                          ?._showNewsDetail(context, newsItem);
                    },
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('Leer más'),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedNewsCard extends StatelessWidget {
  final _NewsItem newsItem;

  const _FeaturedNewsCard({
    required this.newsItem,
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
          onTap: () {
            // Cuando se pulsa en la noticia destacada, mostrar el detalle
            context.findAncestorStateOfType<_NoticiasScreenState>()
                ?._showNewsDetail(context, newsItem);
          },
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen destacada
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  color: Colors.grey[200],
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Icon(
                        Icons.image,
                        size: 60,
                        color: Colors.grey[400],
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
                    ],
                  ),
                ),
              ),

              // Contenido
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categoría y fecha
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            newsItem.category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          newsItem.date,
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
                      newsItem.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Resumen
                    Text(
                      newsItem.summary,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Botones de acción
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Lógica para compartir
                              },
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Mostrar el detalle al hacer clic en "Leer artículo"
                                context.findAncestorStateOfType<_NoticiasScreenState>()
                                    ?._showNewsDetail(context, newsItem);
                              },
                              icon: const Icon(Icons.visibility, size: 16),
                              label: const Text('Leer artículo'),
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

// Widget para mostrar una noticia relacionada
class _RelatedNewsCard extends StatelessWidget {
  final _NewsItem newsItem;
  final VoidCallback onTap;

  const _RelatedNewsCard({
    required this.newsItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            // Miniatura
            Container(
              width: 60,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: const Icon(
                Icons.image,
                color: Colors.grey,
              ),
            ),
            // Información
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsItem.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      newsItem.date,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      newsItem.category,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
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
}
