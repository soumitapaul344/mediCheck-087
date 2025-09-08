import 'package:flutter/material.dart';
import 'package:medicheck_app/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import '../../db/profile_database.dart';
import '../../models/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    final userProvider = Provider.of<ProfileProvider>(context, listen: false);
    final user = userProvider.userProfile;

    if (user != null) {
      _nameController.text = user.name ?? '';
      _ageController.text = user.age.toString();
      _genderController.text = user.gender ?? '';
      _heightController.text = user.height.toString();
      _weightController.text = user.weight.toString();
    }
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);

    try {
      final userProvider = Provider.of<ProfileProvider>(context, listen: false);
      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId == null) throw Exception("User not authenticated");

      final updatedProfile = UserProfile(
        id: userId,
        email: userProvider.userProfile!.email,
        name: _nameController.text,
        age: int.tryParse(_ageController.text) ?? 0,
        gender: _genderController.text,
        height: double.tryParse(_heightController.text) ?? 0.0,
        weight: double.tryParse(_weightController.text) ?? 0.0,
      );

      await ProfileDatabase().upsertProfile(
        userId: updatedProfile.id,
        name: updatedProfile.name,
        age: updatedProfile.age,
        gender: updatedProfile.gender,
        height: updatedProfile.height,
        weight: updatedProfile.weight,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save profile: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // DELETE profile function
  Future<void> _deleteProfile() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    setState(() => _isLoading = true);

    try {
      await ProfileDatabase().deleteProfile(userId);

      // Clear the text fields
      _nameController.clear();
      _ageController.clear();
      _genderController.clear();
      _heightController.clear();
      _weightController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile deleted successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete profile: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileProvider>(context).userProfile;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("User Profile"),
          backgroundColor: Colors.cyan,
        ),
        body: const Center(child: Text("No profile data found.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: "Delete Profile",
            onPressed: () async {
              // Confirm before deleting
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text(
                    'Are you sure you want to delete your profile?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                _deleteProfile();
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _genderController,
                    decoration: const InputDecoration(labelText: 'Gender'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Save Profile',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
