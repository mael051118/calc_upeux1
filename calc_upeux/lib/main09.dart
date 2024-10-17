import 'package:flutter/material.dart';

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejemplo de Scroll',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ejemplo de Scroll'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'SingleChildScrollView'),
              Tab(text: 'ListView'),
              Tab(text: 'GridView'),
              Tab(text: 'ScrollController'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollViewExample(),
            ListViewExample(),
            GridViewExample(),
            ScrollControllerExample(),
          ],
        ),
      ),
    );
  }
}

class SingleChildScrollViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: List.generate(20, (index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(20),
            color: Colors.blueAccent,
            child: Text(
              'Item $index',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }),
      ),
    );
  }
}

class ListViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: 50, // Número de ítems
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Elemento $index'),
        );
      },
    );
  }
}

class GridViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Número de columnas
      padding: const EdgeInsets.all(16.0),
      children: List.generate(20, (index) {
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
    );
  }
}

class ScrollControllerExample extends StatefulWidget {
  @override
  _ScrollControllerExampleState createState() => _ScrollControllerExampleState();
}

class _ScrollControllerExampleState extends State<ScrollControllerExample> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          print('Top of list');
        } else {
          print('End of list');
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ScrollController')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Item $index'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 2),
            curve: Curves.easeOut,
          );
        },
        child: Icon(Icons.arrow_downward),
      ),
    );
  }
}
