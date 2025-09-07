import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import '../../auth/sign_in_page.dart';
import '../../services/auth_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _signOut() async {
    await AuthService().signOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SignInPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user != null) ...[
              Text('Email: ${user.email}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Name: ${user.name}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Age: ${user.age}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Gender: ${user.gender}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Height: ${user.height}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Weight: ${user.weight}', style: const TextStyle(fontSize: 16)),
            ] else ...[
              const Text('No user signed in', style: TextStyle(fontSize: 16)),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _signOut,
                child: const Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

