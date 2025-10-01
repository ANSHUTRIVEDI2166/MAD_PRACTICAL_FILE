import 'package:flutter/material.dart';

class Practical2Temperature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical 2: Temperature Converter',
      home: LoginScreen2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen2 extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                String name = nameController.text.trim();
                if (name.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DashboardScreen2(userName: name),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen2 extends StatelessWidget {
  final String userName;
  DashboardScreen2({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $userName!', style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Go to Temperature Converter'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TemperatureConverterScreen(userName: userName),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  final String userName;
  TemperatureConverterScreen({required this.userName});

  @override
  State<TemperatureConverterScreen> createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  final TextEditingController tempController = TextEditingController();
  String result = '';
  bool isCtoF = true;

  void convertTemperature() {
    double? input = double.tryParse(tempController.text);
    if (input == null) {
      setState(() {
        result = 'Please enter a valid number';
      });
      return;
    }
    double output;
    if (isCtoF) {
      output = (input * 9 / 5) + 32;
      setState(() {
        result = '$input °C = ${output.toStringAsFixed(2)} °F';
      });
    } else {
      output = (input - 32) * 5 / 9;
      setState(() {
        result = '$input °F = ${output.toStringAsFixed(2)} °C';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temperature Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, ${widget.userName}!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            TextField(
              controller: tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: isCtoF ? 'Enter °C' : 'Enter °F',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Celsius to Fahrenheit'),
                Switch(
                  value: isCtoF,
                  onChanged: (val) {
                    setState(() {
                      isCtoF = val;
                      result = '';
                      tempController.clear();
                    });
                  },
                ),
                Text('Fahrenheit to Celsius'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Convert'),
              onPressed: convertTemperature,
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 18, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}