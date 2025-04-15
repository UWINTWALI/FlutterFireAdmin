import 'package:flutter/material.dart';
import 'auth_service.dart';
import '../widgets/input_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signup() async {
    try {
      final user = await AuthService().signUp(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        Navigator.pop(context); // Return to login after signup
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signup failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(controller: _emailController, label: "Email"),
            InputField(
              controller: _passwordController,
              label: "Password",
              obscure: true,
            ),
            ElevatedButton(onPressed: _signup, child: const Text("Sign Up")),
          ],
        ),
      ),
    );
  }
}
