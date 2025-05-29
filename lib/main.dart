import 'package:flutter/material.dart';

void main() => runApp(TempConverterApp());

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TempConverterHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TempConverterHome extends StatefulWidget {
  @override
  _TempConverterHomeState createState() => _TempConverterHomeState();
}

class _TempConverterHomeState extends State<TempConverterHome> {
  bool isFtoC = true;
  final TextEditingController tempController = TextEditingController();
  String result = '';
  List<String> history = [];

  void convertTemp() {
    double input = double.tryParse(tempController.text) ?? 0.0;
    double output;
    String conversion;

    if (isFtoC) {
      output = (input - 32) * 5 / 9;
      conversion = "F to C: ${input.toStringAsFixed(1)} => ${output.toStringAsFixed(2)}";
    } else {
      output = (input * 9 / 5) + 32;
      conversion = "C to F: ${input.toStringAsFixed(1)} => ${output.toStringAsFixed(2)}";
    }

    setState(() {
      result = output.toStringAsFixed(2);
      history.insert(0, conversion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temperature Converter')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ToggleButtons(
                  isSelected: [isFtoC, !isFtoC],
                  onPressed: (index) {
                    setState(() {
                      isFtoC = index == 0;
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('F → C'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('C → F'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: tempController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter temperature',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: convertTemp,
                  child: const Text('Convert'),
                ),
                const SizedBox(height: 20),
                Text('Result: $result °', style: const TextStyle(fontSize: 20)),
                const Divider(height: 40),
                const Text('Conversion History', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(history[index]),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
