import 'package:flutter/material.dart';

void main() {
  runApp(const MeasuresConverterApp());
}

class MeasuresConverterApp extends StatelessWidget {
  const MeasuresConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Measures Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConverterPage(),
    );
  }
}

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final TextEditingController _controller = TextEditingController();

  final List<String> measures = [
    'meters',
    'kilometers',
    'feet',
    'miles',
    'kilograms',
    'pounds'
  ];

  String fromMeasure = 'meters';
  String toMeasure = 'feet';

  String result = '';

  // Conversion logic
  double convert(String from, String to, double value) {
    // Distance conversions
    if (from == 'meters' && to == 'feet') {
      return value * 3.28084;
    }

    if (from == 'feet' && to == 'meters') {
      return value / 3.28084;
    }

    if (from == 'kilometers' && to == 'miles') {
      return value * 0.621371;
    }

    if (from == 'miles' && to == 'kilometers') {
      return value / 0.621371;
    }

    // Weight conversions
    if (from == 'kilograms' && to == 'pounds') {
      return value * 2.20462;
    }

    if (from == 'pounds' && to == 'kilograms') {
      return value / 2.20462;
    }

    return value;
  }

  void performConversion() {
    double input = double.tryParse(_controller.text) ?? 0;

    double convertedValue = convert(fromMeasure, toMeasure, input);

    setState(() {
      result =
      '$input $fromMeasure are ${convertedValue.toStringAsFixed(3)} $toMeasure';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Value Label
            const Text(
              'Value',
              style: TextStyle(fontSize: 28),
            ),

            // Input Field
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 30),

            // From Label
            const Text(
              'From',
              style: TextStyle(fontSize: 28),
            ),

            DropdownButton<String>(
              value: fromMeasure,
              isExpanded: true,
              items: measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  fromMeasure = newValue!;
                });
              },
            ),

            const SizedBox(height: 30),

            // To Label
            const Text(
              'To',
              style: TextStyle(fontSize: 28),
            ),

            DropdownButton<String>(
              value: toMeasure,
              isExpanded: true,
              items: measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  toMeasure = newValue!;
                });
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: performConversion,
              child: const Text('Convert'),
            ),

            const SizedBox(height: 30),

            Text(
              result,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}