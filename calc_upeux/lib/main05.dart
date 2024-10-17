import 'package:flutter/material.dart';

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demostración de Widgets',
      home: PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Widgets en Flutter')),
      body: ListView(
        children: [
          WidgetContainer(),
          WidgetRowColumn(),
          WidgetStack(),
          WidgetPadding(),
          WidgetCenter(),
          WidgetExpanded(),
          WidgetListView(),
          WidgetGridView(),
          WidgetGridViewUsuarios(),
        ],
      ),
    );
  }
}

class WidgetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Text(
        'Hola, Soy un Container',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}

class WidgetRowColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Este es un texto arriba'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(color: Colors.red, height: 50, width: 50),
              Container(color: Colors.green, height: 50, width: 50),
              Container(color: Colors.blue, height: 50, width: 50),
            ],
          ),
          SizedBox(height: 20),
          Text('Este es un texto abajo'),
        ],
      ),
    );
  }
}

class WidgetStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack')),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blueAccent,
          ),
          Positioned(
            top: 50,
            left: 50,
            child: Container(width: 100, height: 100, color: Colors.red),
          ),
          Positioned(
            bottom: 50,
            right: 50,
            child: Container(width: 100, height: 100, color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class WidgetPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Padding')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.blueAccent,
          child: Center(
            child: Text(
              'Texto con Padding',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Center Widget')),
      body: Center(
        child: Container(
          width: 200,
          height: 100,
          color: Colors.green,
          child: Center(
            child: Text(
              'Texto centrado',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetExpanded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expanded Widget')),
      body: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.red,
              child: Text('Elemento 1', textAlign: TextAlign.center),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
              child: Text('Elemento 2', textAlign: TextAlign.center),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Text('Elemento 3', textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListView')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Container(color: Colors.red, height: 100),
          Container(color: Colors.green, height: 100),
          Container(color: Colors.blue, height: 100),
          Container(color: Colors.orange, height: 100),
          Container(color: Colors.purple, height: 100),
        ],
      ),
    );
  }
}

class Usuario {
  final String nombre;
  final int edad;
  Usuario(this.nombre, this.edad);
}

final List<Usuario> usuarios = [
  Usuario('Juan', 25),
  Usuario('Ana', 30),
  Usuario('Pedro', 28),
  Usuario('María', 22),
  Usuario('Luis', 35),
  Usuario('Sofía', 27),
  Usuario('Javier', 33),
  Usuario('Lucía', 29),
  Usuario('Carlos', 31),
];

class WidgetListaUsuarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Usuarios")),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16.0),
            color: Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    usuario.nombre,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Edad: ${usuario.edad}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class WidgetGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GridView')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: List.generate(9, (index) {
          return Container(
            margin: EdgeInsets.all(8.0),
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                'Item $index',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class WidgetGridViewUsuarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GridView de Usuarios')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          return Container(
            margin: EdgeInsets.all(8.0),
            color: Colors.blueAccent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    usuario.nombre,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Edad: ${usuario.edad}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
