import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  CalculadoraPageState createState() => CalculadoraPageState();
}

class CalculadoraPageState extends State<CalculadoraPage> {
  String _output = '0';
  String _currentValue = '0';
  String _operator = '';
  double _firstOperand = 0;

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _output = '0';
        _currentValue = '0';
        _operator = '';
        _firstOperand = 0;
      } else if (value == '+' || value == '-' || value == '×' || value == '÷') {
        _firstOperand = double.parse(_output);
        _operator = value;
        _currentValue = '0';
      } else if (value == '=') {
        double secondOperand = double.parse(_currentValue);
        switch (_operator) {
          case '+':
            _output = (_firstOperand + secondOperand).toString();
            break;
          case '-':
            _output = (_firstOperand - secondOperand).toString();
            break;
          case '×':
            _output = (_firstOperand * secondOperand).toString();
            break;
          case '÷':
            _output = (_firstOperand / secondOperand).toString();
            break;
        }
        _currentValue = _output;
        _operator = '';
      } else {
        if (_currentValue == '0') {
          _currentValue = value;
        } else {
          _currentValue += value;
        }
        _output = _currentValue;
      }
    });
  }

  Widget _buildButton(String label, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(label),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            shape: const CircleBorder(),
            backgroundColor: color,
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Center( // Centrar el Container en la pantalla
        child: Container(
          width: 300, // Ajusta el ancho del Container
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Hace que la columna ocupe solo el espacio necesario
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerRight,
                child: Text(
                  _output,
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Column(
                children: [
                  Row(
                    children: [
                      _buildButton('7', Colors.blueGrey),
                      _buildButton('8', Colors.blueGrey),
                      _buildButton('9', Colors.blueGrey),
                      _buildButton('÷', Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('4', Colors.blueGrey),
                      _buildButton('5', Colors.blueGrey),
                      _buildButton('6', Colors.blueGrey),
                      _buildButton('×', Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('1', Colors.blueGrey),
                      _buildButton('2', Colors.blueGrey),
                      _buildButton('3', Colors.blueGrey),
                      _buildButton('-', Colors.orange),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('C', Colors.red),
                      _buildButton('0', Colors.blueGrey),
                      _buildButton('=', Colors.green),
                      _buildButton('+', Colors.orange),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
