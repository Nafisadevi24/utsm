import 'package:flutter/material.dart';
import '../repository/data_repository.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup';
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final repo = DataRepository();
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String info = '';

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (repo.usernameExists(username.trim())) {
        setState(() => info = 'Username sudah digunakan');
      } else {
        try {
          await repo.registerUser(username.trim(), password);
          
          if (!mounted) return;
          
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Registrasi berhasil! Silakan login.'),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          if (!mounted) return;
          
          setState(() => info = 'Error: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFF81D4FA), Color(0xFF0288D1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  TextFormField(
                    decoration: _input('Username'),
                    onChanged: (v) => username = v,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Isi username' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    decoration: _input('Password'),
                    obscureText: true,
                    onChanged: (v) => password = v,
                    validator: (v) => v == null || v.length < 4
                        ? 'Minimal 4 karakter'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1565C0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      child: Text(
                        'Daftar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  
                  if (info.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        info,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _input(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      );
}