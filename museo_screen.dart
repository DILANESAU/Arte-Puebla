class MuseumScreen extends StatelessWidget {
  const MuseumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Arte Puebla",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Museos"),
        ),
        drawer: MenuLateral(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Encabezado
            Container(
              margin: EdgeInsets.all(2.0),
              padding: EdgeInsets.all(10.0),
              height: 200,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://your-image-url.com/image.jpg'), // Cambia esto por tu URL de imagen
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Center(
                  child: Text(
                    'Museos en Puebla',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Campo de texto
            const Text(
              '¿A dónde quiere ir?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Buscar museo...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            // Lista de museos
            Expanded(
              child: ListView(
                children: [
                  _buildMuseumCard(
                    context,
                    'Museo de la Evolución',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    '45.00',
                    'https://your-image-url.com/museum1.jpg', // Cambia esto por tu URL de imagen
                  ),
                  _buildMuseumCard(
                    context,
                    'Museo Amparo',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    '45.00',
                    'https://your-image-url.com/museum2.jpg', // Cambia esto por tu URL de imagen
                  ),
                  _buildMuseumCard(
                    context,
                    'Museo del Ferrocarril',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    '45.00',
                    'https://your-image-url.com/museum3.jpg', // Cambia esto por tu URL de imagen
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          backgroundColor: Colors.deepPurple,
          selectedItemColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMuseumCard(BuildContext context, String title,
      String description, String price, String imageUrl) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.all(10.0),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image:
                    NetworkImage(imageUrl), // Cambia esto por tu URL de imagen
                fit: BoxFit.cover,
              ),
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
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Text('\$$price',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
