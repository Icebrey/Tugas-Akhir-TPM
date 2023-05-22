import 'dart:convert';
import 'package:currencyconverter/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:crypto/crypto.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final loginBox = Hive.box('loginBox');
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();

    if (loginBox.containsKey(username)) {
      final storedPassword = loginBox.get(username);
      if (hashedPassword == storedPassword) {
        // Login successful
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );
      } else {
        // Invalid password
        _showSnackbar('Invalid Password');
      }
    } else {
      // Username not found
      _showSnackbar('Username Not Found');
    }
  }

  Future<void> _register() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final loginBox = Hive.box('loginBox');
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();

    if (loginBox.containsKey(username)) {
      // Username already exists
      _showSnackbar('Username already exists');
    } else {
      loginBox.put(username, hashedPassword);
      // Registration successful
      _showSnackbar('Registration Successful');
    }
  }

  void _showSnackbar(String message) {
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}