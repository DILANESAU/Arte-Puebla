import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Form.dart';
import 'package:flutter_application_1/Taller.dart';
import 'package:flutter_application_1/museum_screen.dart';
import 'package:flutter_application_1/user_profile_screen.dart';
import 'Favoritos.dart';
import 'Home.dart';

class GaleriaScreen extends StatefulWidget {
  const GaleriaScreen({super.key});

  @override
  _GaleriaScreenState createState() => _GaleriaScreenState();
}

class _GaleriaScreenState extends State<GaleriaScreen> {
  late PageController _pageController;
  int _page = 1;
  List<bool> _isExpanded = [false, false, false]; // Expansión de la tarjeta
  bool _pinned = true;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: MenuLateral(),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 1,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.favorite, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.person, size: 30),
          ],
          color: Colors.deepPurple,
          buttonBackgroundColor: Colors.purple,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });

            // Navegar a la página correspondiente según el índice seleccionado
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoritosScreen()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfileScreen()),
                );
                break;
            }
          },
          letIndexChange: (index) => true,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: _pinned, 
              expandedHeight: 300.0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Stack(
                  children: <Widget>[
                    // Texto con borde negro
                    Text(
                      "Galerías",
                      style: TextStyle(
                        fontFamily: 'MyCustomFont',
                        fontSize: 30,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = const Color.fromARGB(255, 101, 101, 101),
                      ),
                    ),
                    // Texto blanco encima
                    const Text(
                      "Galerías",
                      style: TextStyle(
                        fontFamily: 'MyCustomFont',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/galeria.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        const Color.fromARGB(255, 228, 193, 193)
                            .withOpacity(0.8),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    '¿A dónde quiere ir?',
                    style: TextStyle(fontSize: 18, fontFamily: 'MyCustomFont'),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      style: TextStyle(fontFamily: 'MyCustomFont'),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Buscar museo...',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      _buildMuseumCard(
                        context,
                        0,
                        'Museo de la Evolución',
                        'Este museo explora la historia evolutiva de la Tierra y sus seres vivos.',
                        '45.00',
                        'assets/images/fachadamuseoevo.jpg',
                        'Este museo explora los 14 mil millones de años que ha experimentado el planeta tierra, comenzando con los organismos unicelulares del periodo Arcaico y las especies animales. Sin embargo, en este museo también hallarás temáticas como el calentamiento global, la responsabilidad humana y los cambios de temperatura mundial, con el propósito de reflexionar sobre la especie humana y su lugar en la evolución.',
                      ),
                      _buildMuseumCard(
                        context,
                        1,
                        'Museo Amparo',
                        'Este museo presenta una colección de arte prehispánico y contemporáneo.',
                        '85.00',
                        'assets/images/fachadamuseoamapa.jpg',
                        'Considerado uno de los centros culturales y de exhibición más importantes de México. Cuenta con salas para la exhibición de su acervo de arte prehispánico, uno de los más importantes en México en una institución privada. Además de la colección de obras de arte virreinal y de los siglos XIX y XX, presenta un programa permanente de exposiciones temporales nacionales e internacionales, al igual que un intenso programa de actividades académicas, artísticas, educativas y lúdicas dirigidas a todo tipo de públicos.',
                      ),
                      _buildMuseumCard(
                        context,
                        2,
                        'Museo del Ferrocarril',
                        'Este museo recorre la historia del ferrocarril en México.',
                        '19.00',
                        'assets/images/fachadamuseoferro.jpg',
                        'Uno de los museos que pertenecen a la Secretaría de Cultura de México. Se fundó en el año de 1988, en un espacio histórico, donde operaron las antiguas estaciones del Ferrocarril Mexicano y el Mexicano del Sur. Este museo conserva y exhibe valiosas colecciones del patrimonio ferroviario del país, de distintas épocas, entre las que destacan locomotoras, coches de carga y carros de pasajeros; además, ofrece a sus visitantes exposiciones, visitas guiadas dramatizadas, presentaciones artísticas y de libros, talleres y conversatorios, entre otras actividades culturales. Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormScreen()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.purple,
          tooltip: 'Agregar un Evento',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildMuseumCard(
      BuildContext context,
      int index,
      String title,
      String description,
      String price,
      String imageUrl,
      String extendedDescription) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded[index] = !_isExpanded[index];
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MyCustomFont'),
                          ),
                          const SizedBox(height: 4),
                          Text(description,
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 8),
                          Text('\$$price',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MyCustomFont',
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_isExpanded[index])
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      extendedDescription,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Ink(
            color: const Color.fromARGB(255, 114, 110, 205),
            child: const ListTile(
              title: Text(
                "Menú",
                style:
                    TextStyle(color: Colors.white, fontFamily: 'MyCustomFont'),
              ),
            ),
          ),
          _buildMenuButton(
            context,
            icon: Icons.home,
            label: "Inicio",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext) => const HomeScreen()),
              );
            },
          ),
          _buildMenuButton(
            context,
            icon: Icons.museum,
            label: "Museos",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext) => MuseumScreen()),
              );
            },
          ),
          _buildMenuButton(
            context,
            icon: Icons.favorite,
            label: "Favoritos",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext) => const FavoritosScreen()),
              );
            },
          ),
          _buildMenuButton(
            context,
            icon: Icons.brush,
            label: "Talleres",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext) => const TallerScreen()),
              );
            },
          ),
          _buildMenuButton(
            context,
            icon: Icons.palette,
            label: "Galerías",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext) => const GaleriaScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
