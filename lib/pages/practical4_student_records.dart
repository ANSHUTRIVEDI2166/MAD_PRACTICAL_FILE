import 'package:flutter/material.dart';

class Practical4StudentRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical 4: Registration Form',
      home: LoginScreen4(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen4 extends StatelessWidget {
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
                      builder: (_) => DashboardScreen4(userName: name),
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

class DashboardScreen4 extends StatelessWidget {
  final String userName;
  DashboardScreen4({required this.userName});

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
              child: Text('Go to Registration Form'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RegistrationFormScreen(userName: userName),
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

class RegistrationFormScreen extends StatefulWidget {
  final String userName;
  RegistrationFormScreen({required this.userName});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter your name';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter your email';
    if (!value.contains('@')) return 'Enter a valid email';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter your phone number';
    if (value.length < 10) return 'Enter at least 10 digits';
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Registration Successful'),
          content: Text(
              'Name: ${nameCtrl.text}\nEmail: ${emailCtrl.text}\nPhone: ${phoneCtrl.text}'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                if (mounted) {
                Navigator.pop(context);
                _formKey.currentState!.reset();
                nameCtrl.clear();
                emailCtrl.clear();
                phoneCtrl.clear();
            }
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Hello, ${widget.userName}!', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              TextFormField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: 'Name'),
                validator: _validateName,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: 'Email'),
                validator: _validateEmail,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: phoneCtrl,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('Register'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}