import 'package:flutter/material.dart';

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demostración de Usuarios',
      home: PantallaListaUsuarios(),
    );
  }
}

class Usuario {
  final String nombre;
  final int edad;

  Usuario(this.nombre, this.edad);
}

Future<List<Usuario>> _fetchUsuarios() async {
  await Future.delayed(Duration(seconds: 2)); 
  return [
    Usuario('Juan', 25),
    Usuario('Ana', 30),
    Usuario('Pedro', 28),
    Usuario('María', 22),
    Usuario('Luis', 35),
  ];
}

class PantallaListaUsuarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Usuarios')),
      body: FutureBuilder<List<Usuario>>(
        future: _fetchUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Cargando
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Manejo de errores
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay usuarios disponibles')); // Sin datos
          }

          final usuarios = snapshot.data!;
          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return ListTile(
                title: Text(usuario.nombre),
                subtitle: Text('Edad: ${usuario.edad}'),
              );
            },
          );
        },
      ),
    );
  }
}

class PantallaTablaUsuarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tabla de Usuarios')),
      body: FutureBuilder<List<Usuario>>(
        future: _fetchUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Cargando
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Manejo de errores
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay usuarios disponibles')); // Sin datos
          }

          final usuarios = snapshot.data!;
          return SingleChildScrollView(
            child: DataTable(
              columns: [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Edad')),
              ],
              rows: usuarios.map((usuario) {
                return DataRow(
                  cells: [
                    DataCell(Text(usuario.nombre)),
                    DataCell(Text(usuario.edad.toString())),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
