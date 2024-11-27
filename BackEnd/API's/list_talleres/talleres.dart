import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Talleres',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TalleresScreen(),
    );
  }
}

class Taller {
  final String titulo;
  final String fecha;
  final String hora;
  final String lugar;
  final String descripcion;
  final int cupos;
  final String? enlaceRegistro;

  Taller({
    required this.titulo,
    required this.fecha,
    required this.hora,
    required this.lugar,
    required this.descripcion,
    required this.cupos,
    this.enlaceRegistro,
  });
}

class TalleresScreen extends StatelessWidget {
  final List<Taller> talleres = [
    Taller(
      titulo: 'Taller de Flutter',
      fecha: '01/12/2024',
      hora: '10:00 AM',
      lugar: 'Ciudad de México',
      descripcion: 'Aprende a crear aplicaciones móviles con Flutter.',
      cupos: 20,
      enlaceRegistro: 'https://example.com/registro_flutter',
    ),
    Taller(
      titulo: 'Taller de Dart',
      fecha: '05/12/2024',
      hora: '2:00 PM',
      lugar: 'Puebla',
      descripcion: 'Domina el lenguaje de programación Dart.',
      cupos: 15,
      enlaceRegistro: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Talleres'),
      ),
      body: ListView.builder(
        itemCount: talleres.length,
        itemBuilder: (context, index) {
          final taller = talleres[index];
          return ListTile(
            title: Text(taller.titulo),
            subtitle: Text('${taller.fecha} - ${taller.hora}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TallerDetalleScreen(taller: taller),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TallerDetalleScreen extends StatelessWidget {
  final Taller taller;

  TallerDetalleScreen({required this.taller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taller.titulo),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha: ${taller.fecha}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Hora: ${taller.hora}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Lugar: ${taller.lugar}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Descripción:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              taller.descripcion,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Cupos: ${taller.cupos}',
              style: TextStyle(fontSize: 18),
            ),
            if (taller.enlaceRegistro != null)
              ElevatedButton(
                onPressed: () async {
                  final url = taller.enlaceRegistro!;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'No se pudo abrir el enlace $url';
                  }
                },
                child: Text('Registrarse'),
              ),
          ],
        ),
      ),
    );
  }
}
