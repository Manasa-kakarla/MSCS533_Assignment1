import 'package:flutter/material.dart';

void main() => runApp(ConversionApp());
//print("App is starting...");
class ConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConversionPage(),
    );
  }
}

class ConversionPage extends StatefulWidget {
  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final _controller = TextEditingController();
  double _convertedValue = 0;
  String _fromUnit = 'Miles';
  String _toUnit = 'Kilometers';

  // Conversion factors for distance (miles to kilometers and vice versa)
  static const double milesToKilometers = 1.60934;
  static const double kilogramsToPounds = 2.20462;
  static const double poundsToKilograms = 0.453592;

  // Conversion function
  void convert() {
    final inputValue = double.tryParse(_controller.text);

    if (inputValue == null || inputValue <= 0) {
      return;
    }

    setState(() {
      if (_fromUnit == 'Miles' && _toUnit == 'Kilometers') {
        _convertedValue = inputValue * milesToKilometers;
      } else if (_fromUnit == 'Kilometers' && _toUnit == 'Miles') {
        _convertedValue = inputValue / milesToKilometers;
      } else if (_fromUnit == 'Kilograms' && _toUnit == 'Pounds') {
        _convertedValue = inputValue * kilogramsToPounds;
      } else if (_fromUnit == 'Pounds' && _toUnit == 'Kilograms') {
        _convertedValue = inputValue * poundsToKilograms;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversion App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input TextField
            TextField(
              controller: _controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter value to convert',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // From Unit Dropdown
            DropdownButton<String>(
              value: _fromUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _fromUnit = newValue!;
                });
              },
              items: <String>['Miles', 'Kilometers', 'Kilograms', 'Pounds']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // To Unit Dropdown
            DropdownButton<String>(
              value: _toUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _toUnit = newValue!;
                });
              },
              items: <String>['Miles', 'Kilometers', 'Kilograms', 'Pounds']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Convert Button
            ElevatedButton(
              onPressed: convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            // Output Display
            Text(
              _controller.text.isEmpty
                  ? 'Enter a value to convert'
                  : 'Converted value: $_convertedValue',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
