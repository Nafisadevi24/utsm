import 'package:flutter/material.dart';
import '../repository/data_repository.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final repo = DataRepository();
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String error = '';

  void _tryLogin() {
    if (_formKey.currentState!.validate()) {
      final user = repo.authenticate(username.trim(), password);
      if (user != null) {
        Navigator.pushReplacementNamed(context, MainPage.routeName,
            arguments: user.username);
      } else {
        setState(() {
          error = 'Username atau password salah';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFBBDEFB),
              Color(0xFF90CAF9),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      onChanged: (v) => username = v,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Isi username' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                      onChanged: (v) => password = v,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Isi password' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _tryLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(
                          context, SignupPage.routeName), 
                      child: const Text(
                        'Daftar Akun Baru',
                        style: TextStyle(color: Color(0xFF1E88E5)),
                      ),
                    ),
                    if (error.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(error, style: const TextStyle(color: Colors.red)),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
