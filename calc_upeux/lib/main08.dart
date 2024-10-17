import 'package:flutter/material.dart';

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diálogos y Snackbars',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diálogos y Snackbars')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Mostrar un diálogo de alerta
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Diálogo de Alerta'),
                      content: Text('Este es un diálogo de alerta.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Cerrar el diálogo
                          },
                          child: Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Mostrar Diálogo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mostrar un Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Este es un Snackbar.'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Deshacer',
                      onPressed: () {
                        print("Acción deshecha");
                      },
                    ),
                  ),
                );
              },
              child: Text('Mostrar Snackbar'),
            ),
          ],
        ),
      ),
    );
  }
}
