import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Practical9LoginAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical 9: Login Auth',
      home: SplashScreen9(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Splash screen to check session
class SplashScreen9 extends StatefulWidget {
  @override
  State<SplashScreen9> createState() => _SplashScreen9State();
}

class _SplashScreen9State extends State<SplashScreen9> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName');
    if (userName != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen9(userName: userName)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen9()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class LoginScreen9 extends StatefulWidget {
  @override
  State<LoginScreen9> createState() => _LoginScreen9State();
}

class _LoginScreen9State extends State<LoginScreen9> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMsg;

  Future<void> _login() async {
    setState(() {
      isLoading = true;
      errorMsg = null;
    });

    // Mock API endpoint for demonstration
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      body: {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      },
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Save session (for demo, just save email as userName)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', emailController.text.trim());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardScreen9(userName: emailController.text.trim()),
        ),
      );
    } else {
      setState(() {
        errorMsg = "Invalid credentials!";
      });
    }
  }

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
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (errorMsg != null)
              Text(errorMsg!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 10),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    child: Text('Login'),
                    onPressed: _login,
                  ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen9 extends StatelessWidget {
  final String userName;
  DashboardScreen9({required this.userName});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userName');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen9()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $userName!', style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Go to Profile'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileScreen9(userName: userName),
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

class ProfileScreen9 extends StatelessWidget {
  final String userName;
  ProfileScreen9({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Text('Profile Page\nUser: $userName', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
      ),
    );
  }
}