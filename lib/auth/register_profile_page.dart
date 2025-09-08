import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';
import '../provider/profile_provider.dart';
import 'package:provider/provider.dart';
import '../pages/home/home_page.dart';

class RegisterProfilePage extends StatefulWidget {
  const RegisterProfilePage({super.key});

  @override
  State<RegisterProfilePage> createState() => _RegisterProfilePageState();
}

class _RegisterProfilePageState extends State<RegisterProfilePage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  void saveProfile() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final profile = {
      'id': user.id,
      'email': user.email,
      'name': _nameController.text,
      'age': int.tryParse(_ageController.text),
      'gender': _genderController.text,
      'height': double.tryParse(_heightController.text),
      'weight': double.tryParse(_weightController.text),
    };

    await supabase.from('users_profiles').insert(profile);

    if (!mounted) return;

    final userProfile = UserProfile(
      id: user.id,
      email: user.email!,
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      gender: _genderController.text,
      height: double.tryParse(_heightController.text) ?? 0,
      weight: double.tryParse(_weightController.text) ?? 0,
    );

    // ✅ Updated: use ProfileProvider instead of UserProvider
    Provider.of<ProfileProvider>(
      context,
      listen: false,
    ).saveProfile(userProfile);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: "Gender"),
              ),
              TextField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: "Height (cm)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: "Weight (kg)"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveProfile,
                child: const Text("Save Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
