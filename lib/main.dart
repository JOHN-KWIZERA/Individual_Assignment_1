import 'package:flutter/material.dart';

void main() => runApp(TempConverterApp());

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temp Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
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
      conversion = "F to C: ${input.toStringAsFixed(1)} → ${output.toStringAsFixed(2)} °C";
    } else {
      output = (input * 9 / 5) + 32;
      conversion = "C to F: ${input.toStringAsFixed(1)} → ${output.toStringAsFixed(2)} °F";
    }

    setState(() {
      result = output.toStringAsFixed(2);
      history.insert(0, conversion);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🌡️ Temp Converter'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Toggle
            Center(
              child: ToggleButtons(
                isSelected: [isFtoC, !isFtoC],
                onPressed: (index) {
                  setState(() {
                    isFtoC = index == 0;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                selectedColor: Colors.white,
                fillColor: Colors.blueAccent,
                color: Colors.black87,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("F → C"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("C → F"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Input field
            TextField(
              controller: tempController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter temperature',
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Convert Button
            ElevatedButton(
              onPressed: convertTemp,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Convert", style: TextStyle(fontSize: 18)),
            ),

            const SizedBox(height: 20),

            // Result Display
            Center(
              child: Column(
                children: [
                  const Text("Converted Value", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    "$result °",
                    style: const TextStyle(fontSize: 32, color: Colors.black87),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text("Conversion History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Container(
              height: isLandscape ? 150 : 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
              ),
              child: history.isEmpty
                  ? const Center(child: Text("No history yet"))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.history, size: 20, color: Colors.grey),
                          title: Text(history[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
