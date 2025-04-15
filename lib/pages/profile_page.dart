import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import 'edit_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().getCurrentUser();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body:
          user == null
              ? const Center(child: Text("No user logged in."))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Text(
                        user.email![0].toUpperCase(),
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Email: ${user.email}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text("Edit Profile"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditProfilePage(),
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
