import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _genderController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user!;
    _nameController = TextEditingController(text: user.name);
    _ageController = TextEditingController(text: user.age.toString());
    _genderController = TextEditingController(text: user.gender);
    _heightController = TextEditingController(text: user.height.toString());
    _weightController = TextEditingController(text: user.weight.toString());
  }

  void updateProfile() async {
    final user = Provider.of<UserProvider>(context, listen: false).user!;
    final updatedProfile = {
      'name': _nameController.text,
      'age': int.tryParse(_ageController.text),
      'gender': _genderController.text,
      'height': double.tryParse(_heightController.text),
      'weight': double.tryParse(_weightController.text),
    };

    await Supabase.instance.client
        .from('users_profiles')
        .update(updatedProfile)
        .eq('id', user.id);

    final newUserProfile = user.copyWith(
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? user.age,
      gender: _genderController.text,
      height: double.tryParse(_heightController.text) ?? user.height,
      weight: double.tryParse(_weightController.text) ?? user.weight,
    );

    Provider.of<UserProvider>(context, listen: false).setUser(newUserProfile);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profile Updated")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
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
                onPressed: updateProfile,
                child: const Text("Update Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
