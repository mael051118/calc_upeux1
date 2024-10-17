import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Asegúrate de importar la librería http
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart'; // Importa la librería de conectividad
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async'; // Importa para manejar StreamSubscription

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ejemplo de Conexiones',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _data = '';
  String _connectionStatus = 'Unknown';
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://echo.websocket.org'),
  );
  final TextEditingController _controller = TextEditingController();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    fetchData();
    checkConnectivity();
    // Observa los cambios de conectividad
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      updateConnectionStatus(result);
    });
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body)['title'];
        });
      } else {
        setState(() {
          _data = 'Failed to load data';
        });
      }
    } catch (e) {
      setState(() {
        _data = 'Error: $e';
      });
    }
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    updateConnectionStatus(connectivityResult);
  }

  void updateConnectionStatus(ConnectivityResult result) {
    String status;
    if (result == ConnectivityResult.mobile) {
      status = 'Connected to Mobile Network';
    } else if (result == ConnectivityResult.wifi) {
      status = 'Connected to WiFi';
    } else {
      status = 'No Internet Connection';
    }
    setState(() {
      _connectionStatus = status;
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejemplo de Conexiones')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text('HTTP GET Data: $_data'),
            SizedBox(height: 20),
            Text('Connection Status: $_connectionStatus'),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message'),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Text('Connection closed');
                } else {
                  return Text(snapshot.hasData ? '${snapshot.data}' : '');
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  channel.sink.add(_controller.text);
                  _controller.clear();
                }
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
