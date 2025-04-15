import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../widgets/input_field.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().getCurrentUser();
    final emailController = TextEditingController(text: user?.email ?? '');

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(controller: emailController, label: "Email"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Firebase doesn't support updating email without re-authentication
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Email update not supported in demo."),
                  ),
                );
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
