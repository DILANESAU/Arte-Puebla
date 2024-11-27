import 'package:flutter/material.dart';
import 'user_profile_screen.dart';
import 'Favoritos.dart';
import 'Taller.dart';
import 'museum_screen.dart';
import 'package:artepuebla/Home.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Panel de Administración",
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Panel de Administración",
            style: TextStyle(fontFamily: 'MyCustomFont'),
          ),
        ),
        drawer: const MenuLateral(),
        body: Center(
          child: _getScreenContent(_currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Panel de control',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'CRUD Usuarios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Usuario',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.deepPurple,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _getScreenContent(int index) {
    switch (index) {
      case 0:
        return AdminDashboard();
      case 1:
        return SettingsScreen();
      case 2:
        return const UserProfileScreen();
      default:
        return AdminDashboard();
    }
  }
}

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Ink(
            color: const Color.fromARGB(255, 114, 110, 205),
            child: const ListTile(
              title: Text(
                "Arte Puebla",
                style: TextStyle(color: Colors.white, fontFamily: 'MyCustomFont'),
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
          _buildMenuButton( //Admin
            context,
            icon: Icons.home,
            label: "Admin",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext) => const AdminScreen()),
              );
            },
          ),//Admin
          _buildMenuButton(
            context,
            icon: Icons.museum,
            label: "Museos",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext) => const MuseumScreen()),
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
                MaterialPageRoute(builder: (BuildContext) => const FavoritosScreen()),
              );
            },
          ),
          
          _buildMenuButton(
            context,
            icon: Icons.brush,
            label: "Taller",
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext) => const TallerScreen()),
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


class AdminDashboard extends StatelessWidget {AdminDashboard({super.key});

  // Simulación de datos obtenidos del Formulario - API
  final List<Map<String, String>> requests = [
    {
      'field1': 'Solicitud 1 - Información',
      'field2': 'Más detalles 1',
      'field3': 'Más detalles adicionales 1',
    },
    {
      'field1': 'Solicitud 2 - Información',
      'field2': 'Más detalles 2',
      'field3': 'Más detalles adicionales 2',
    },
    //Dilan aqui se agregan mas campos o segun yo se deberia hacer una clase
    //aparte para almacenar las solicitudes
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Título
            const Text(
              'Peticiones de Publicaciones',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Tabla de solicitudes
            Expanded(
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Columna de la izquierda con la información del formulario
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Campo 1: ${request['field1']}'), //Segun se codifique el API
                                Text('Campo 2: ${request['field2']}'),
                                Text('Campo 3: ${request['field3']}'),
                              ],
                            ),
                          ),
                          //Botones
                          Row(
                            children: [
                              // Botón para aceptar la solicitud
                              IconButton(
                                icon: const Icon(Icons.check, color: Colors.green),
                                onPressed: () {
                                  // Lógica para aceptar la solicitud
                                  
                                },
                              ),
                              // Botón para eliminar la solicitud
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Lógica para eliminar la solicitud
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});

  //  Simulación de datos obtenidos de la base de datos
  final List<Map<String, String>> users = [
    {
      'id': '1',
      'name': 'Luis Sanchez',
      'email': 'sanchezmluism@gmail.com',
    },
    {
      'id': '2',
      'name': 'Dilan Palafox',
      'email': 'dilan.palafox@gmail.com',
    },
    {
      'id': '3',
      'name': 'Arlette Perez',
      'email': 'arlette.perezz@gmail.com',
    },
    //Dilan haces tu magia xdxd
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración del Panel de Administración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Título de la pantalla
            const Text(
              'Usuarios Registrados',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Tabla de usuarios
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Columna izquierda: Información del usuario
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID: ${user['id']}'),
                                Text('Nombre: ${user['name']}'),
                                Text('Correo: ${user['email']}'),
                              ],
                            ),
                          ),
                          // Columna derecha: Botones para editar y eliminar
                          Row(
                            children: [
                              // Botón para editar el usuario
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  // Lógica para editar el usuario
                                },
                              ),
                              // Botón para eliminar el usuario
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  //Lógica para eliminar al usuario
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}