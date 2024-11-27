// UserProfileScreen
import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Galeria.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/museum_screen.dart';
import 'package:flutter_application_1/user_profile_screen.dart';
import 'Favoritos.dart';
import 'Taller.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late PageController _pageController;
  TextEditingController _dateController = TextEditingController(); //fecha
  TextEditingController _timeController = TextEditingController(); //hora
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
      GlobalKey(); //buttonbar
  late Timer _timer;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _dateController.dispose();
    super.dispose();
  }

//Fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now())
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
  }

//Hora
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Galería",
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Galería",
              style: TextStyle(fontFamily: 'MyCustomFont'),
            ),
          ),
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
          body: ListView(
            children: [
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0), // Ajusta los márgenes horizontales
                child: Card(
                  elevation: 8.0, // Añade una elevación al formulario
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: const Text(
                              'Agrega un evento',
                              style: TextStyle(
                                color: Color.fromARGB(255, 184, 181, 181),
                                fontSize: 25.0,
                                fontFamily: 'MyCustomFont',
                              ),
                            ),
                          ),
                          const Text(
                            'Nombre',
                            style: TextStyle(
                              color: Color.fromARGB(255, 183, 181, 181),
                              fontSize: 16.0,
                              fontFamily: 'MyCustomFont',
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 231, 190, 233)
                                  .withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese datos';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          const Text(
                            'Nombre',
                            style: TextStyle(
                              color: Color.fromARGB(255, 183, 181, 181),
                              fontSize: 16.0,
                              fontFamily: 'MyCustomFont',
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 231, 190, 233)
                                  .withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese datos';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Nombre',
                            style: TextStyle(
                              color: Color.fromARGB(255, 183, 181, 181),
                              fontSize: 16.0,
                              fontFamily: 'MyCustomFont',
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 231, 190, 233)
                                  .withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese datos';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Fecha',
                            style: TextStyle(
                              color: Color.fromARGB(255, 183, 181, 181),
                              fontSize: 16.0,
                              fontFamily: 'MyCustomFont',
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 231, 190, 233)
                                  .withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'dd/mm/yyyy',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese una fecha';
                              }
                              return null;
                            },
                            readOnly: true,
                            onTap: () => _selectDate(context),
                          ),
                          const Text(
                            'Hora',
                            style: TextStyle(
                              color: Color.fromARGB(255, 183, 181, 181),
                              fontSize: 16.0,
                              fontFamily: 'MyCustomFont',
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          TextFormField(
                            controller: _timeController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 231, 190, 233)
                                  .withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.access_time),
                                onPressed: () {
                                  _selectTime(context);
                                },
                              ),
                            ),
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese la hora';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Lógica del botón de inicio de sesión
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GaleriaScreen()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 156, 39, 176),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: const Text(
                              'Agregar Galería',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'MyCustomFont',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
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
