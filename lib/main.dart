import 'package:flutter/material.dart';

void main() {
  runApp(ConversionApp());
}

// Root widget
class ConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ConversionHomePage(),
    );
  }
}

// Home page with state
class ConversionHomePage extends StatefulWidget {
  @override
  _ConversionHomePageState createState() => _ConversionHomePageState();
}

class _ConversionHomePageState extends State<ConversionHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _fromUnit = 'Miles';
  String _toUnit = 'Kilometers';
  String _category = 'Distance';
  String _result = '';

  // Categories and their units
  final Map<String, List<String>> categories = {
    'Distance': ['Miles', 'Kilometers'],
    'Weight': ['Kilograms', 'Pounds'],
  };

  // Conversion logic
  void _convert() {
    double input = double.tryParse(_controller.text) ?? 0;
    double result = 0;

    if (_category == 'Distance') {
      if (_fromUnit == 'Miles' && _toUnit == 'Kilometers') result = input * 1.60934;
      else if (_fromUnit == 'Kilometers' && _toUnit == 'Miles') result = input * 0.621371;
      else result = input; // same unit
    } else if (_category == 'Weight') {
      if (_fromUnit == 'Kilograms' && _toUnit == 'Pounds') result = input * 2.20462;
      else if (_fromUnit == 'Pounds' && _toUnit == 'Kilograms') result = input * 0.453592;
      else result = input; // same unit
    }

    setState(() {
      _result = result.toStringAsFixed(2); // 2 decimal places
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unit Converter')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Category Dropdown
            DropdownButton<String>(
              value: _category,
              items: categories.keys.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _category = val!;
                  _fromUnit = categories[_category]![0];
                  _toUnit = categories[_category]![1];
                });
              },
            ),
            SizedBox(height: 16),
            // Input value
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter value'),
            ),
            SizedBox(height: 16),
            // From and To Unit Dropdowns
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _fromUnit,
                  items: categories[_category]!.map((unit) {
                    return DropdownMenuItem(value: unit, child: Text(unit));
                  }).toList(),
                  onChanged: (val) => setState(() => _fromUnit = val!),
                ),
                Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _toUnit,
                  items: categories[_category]!.map((unit) {
                    return DropdownMenuItem(value: unit, child: Text(unit));
                  }).toList(),
                  onChanged: (val) => setState(() => _toUnit = val!),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Convert button
            ElevatedButton(onPressed: _convert, child: Text('Convert')),
            SizedBox(height: 16),
            // Display result
            Text('Result: $_result', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
