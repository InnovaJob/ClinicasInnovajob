import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground; // Ruta actualizada
import '../home/home_screen.dart';
import '../appointments/appointments_screen.dart';
import '../messages/messages_screen.dart'; // Añadido
import '../../widgets/side_menu.dart'; // Importar el menú lateral compartido

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({Key? key}) : super(key: key);

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  int _selectedIndex = 2; // Tercera opción seleccionada (Productos)
  int _selectedCategory = 0; // Categoría seleccionada por defecto

  final List<String> _categories = [
    'Todos',
    'Cosméticos',
    'Higiene',
    'Nutrición',
    'Especiales'
  ];

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
                  SideMenu(selectedIndex: _selectedIndex), // Usar el menú compartido
                ],
              ),
            ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Productos',
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
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, size: 20),
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
                            // Categorías
                            _buildCategoriesHeader(),

                            // Lista de productos
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.all(10.0),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Productos destacados',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.2,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          icon: Icon(Icons.sort, size: 20, color: Colors.grey[600]),
                                          onPressed: () {},
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Grid de productos
                                  GridView.count(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    crossAxisCount: isLargeScreen ? 3 : 2,
                                    childAspectRatio: 0.75,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    children: [
                                      _ProductCard(
                                        name: 'Crema Hidratante',
                                        price: '€12.99',
                                        category: 'Cosméticos',
                                        imageUrl: 'assets/images/product1.jpg',
                                      ),
                                      _ProductCard(
                                        name: 'Champú Revitalizante',
                                        price: '€9.50',
                                        category: 'Higiene',
                                        imageUrl: 'assets/images/product2.jpg',
                                        isNew: true,
                                      ),
                                      _ProductCard(
                                        name: 'Colágeno en Cápsulas',
                                        price: '€24.99',
                                        category: 'Nutrición',
                                        imageUrl: 'assets/images/product3.jpg',
                                      ),
                                      _ProductCard(
                                        name: 'Gel Anti-acné',
                                        price: '€15.50',
                                        category: 'Cosméticos',
                                        imageUrl: 'assets/images/product4.jpg',
                                        discount: '10%',
                                      ),
                                      _ProductCard(
                                        name: 'Complemento Vitamínico',
                                        price: '€18.75',
                                        category: 'Nutrición',
                                        imageUrl: 'assets/images/product5.jpg',
                                      ),
                                      _ProductCard(
                                        name: 'Crema Solar',
                                        price: '€22.00',
                                        category: 'Especiales',
                                        imageUrl: 'assets/images/product6.jpg',
                                        isNew: true,
                                      ),
                                    ],
                                  ),

                                  // Espacio para el menú inferior en móviles
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
        child: const Icon(Icons.shopping_cart),
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
                } else if (index == 1) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
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
                  fontFamily: 'Montserrat',
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.grey[800],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


// Tarjeta de producto minimalista
class _ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String category;
  final String imageUrl;
  final String? discount;
  final bool isNew;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.discount,
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xFF5f89c5);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto con posibles etiquetas (nuevo, descuento)
            Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.photo,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                if (isNew)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: baseColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'NUEVO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (discount != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '-$discount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Información del producto
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: 0.1,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: baseColor,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: baseColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 16,
                          ),
                          onPressed: () {},
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
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
