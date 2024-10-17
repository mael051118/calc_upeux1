import 'package:flutter/material.dart';

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demostración de Widgets')),
      body: ListView(
        children: [
          WidgetTexto(),
          WidgetTextoFormulario(),
          WidgetCheckbox(),
          WidgetSwitch(),
          WidgetRadioButton(),
          WidgetSlider(),
          WidgetDropdownButton(),
        ],
      ),
    );
  }
}

class WidgetTexto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nombre',
          hintText: 'Escribe tu nombre',
        ),
        onChanged: (texto) {
          print('Texto ingresado: $texto');
        },
      ),
    );
  }
}

class WidgetTextoFormulario extends StatefulWidget {
  @override
  _WidgetTextoFormularioState createState() => _WidgetTextoFormularioState();
}

class _WidgetTextoFormularioState extends State<WidgetTextoFormulario> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) {
                _email = valor;
              },
              validator: (valor) {
                if (valor == null || valor.isEmpty) {
                  return 'Por favor, ingrese un correo';
                }
                if (!emailRegex.hasMatch(valor)) {
                  return 'Ingrese un correo válido';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('Correo ingresado: $_email');
                }
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetCheckbox extends StatefulWidget {
  @override
  _WidgetCheckboxState createState() => _WidgetCheckboxState();
}

class _WidgetCheckboxState extends State<WidgetCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? valor) {
            setState(() {
              _isChecked = valor ?? false;
            });
          },
        ),
        Text('Acepto los términos y condiciones'),
      ],
    );
  }
}

class WidgetSwitch extends StatefulWidget {
  @override
  _WidgetSwitchState createState() => _WidgetSwitchState();
}

class _WidgetSwitchState extends State<WidgetSwitch> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Switch(
        value: _switchValue,
        onChanged: (bool valor) {
          setState(() {
            _switchValue = valor;
          });
          print('Switch: $_switchValue');
        },
      ),
    );
  }
}

class WidgetRadioButton extends StatefulWidget {
  @override
  _WidgetRadioButtonState createState() => _WidgetRadioButtonState();
}

class _WidgetRadioButtonState extends State<WidgetRadioButton> {
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ListTile(
          title: Text('Opción 1'),
          leading: Radio<int>(
            value: 1,
            groupValue: _selectedValue,
            onChanged: (int? valor) {
              setState(() {
                _selectedValue = valor!;
              });
              print("Seleccionado: $_selectedValue");
            },
          ),
        ),
        ListTile(
          title: Text('Opción 2'),
          leading: Radio<int>(
            value: 2,
            groupValue: _selectedValue,
            onChanged: (int? valor) {
              setState(() {
                _selectedValue = valor!;
              });
              print("Seleccionado: $_selectedValue");
            },
          ),
        ),
      ],
    );
  }
}

class WidgetSlider extends StatefulWidget {
  @override
  _WidgetSliderState createState() => _WidgetSliderState();
}

class _WidgetSliderState extends State<WidgetSlider> {
  double _sliderValue = 20.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(
            value: _sliderValue,
            min: 0,
            max: 100,
            divisions: 10,
            label: _sliderValue.round().toString(),
            onChanged: (double valor) {
              setState(() {
                _sliderValue = valor;
              });
              print("Valor: $_sliderValue");
            },
          ),
          Text('Valor seleccionado: ${_sliderValue.round()}'),
        ],
      ),
    );
  }
}

class WidgetDropdownButton extends StatefulWidget {
  @override
  _WidgetDropdownButtonState createState() => _WidgetDropdownButtonState();
}

class _WidgetDropdownButtonState extends State<WidgetDropdownButton> {
  final List<Map<String, String>> _dropdownItems = [
    {'label': 'Opción A', 'value': '1'},
    {'label': 'Opción B', 'value': '2'},
    {'label': 'Opción C', 'value': '3'},
  ];
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        value: _selectedValue,
        hint: Text('Seleccione una opción'),
        items: _dropdownItems.map((item) {
          return DropdownMenuItem<String>(
            value: item['value'],
            child: Text(item['label']!),
          );
        }).toList(),
        onChanged: (String? nuevoValor) {
          setState(() {
            _selectedValue = nuevoValor!;
          });
          print('Valor seleccionado: $_selectedValue');
        },
      ),
    );
  }
}
