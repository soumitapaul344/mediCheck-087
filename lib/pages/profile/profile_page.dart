import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../db/notes_database.dart'; // Import your ProfileDatabase
import '../../provider/user_provider.dart';
import '../../models/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// This page allows the user to view and edit their profile details.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Controllers for the input fields
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  // A boolean to track the loading state (e.g., when saving data)
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // A helper function to load data from the UserProvider and
  // populate the text controllers.
  void _loadProfileData() {
    // We use `listen: false` because we only need the data once
    // and don't need to rebuild the widget when the provider changes.
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.userProfile;

    if (user != null) {
      // Fix for `String?` not assignable to `String` error
      _nameController.text = user.name ?? '';
      _ageController.text = user.age.toString();
      // Fix for `String?` not assignable to `String` error
      _genderController.text = user.gender ?? '';
      _heightController.text = user.height.toString();
      _weightController.text = user.weight.toString();
    }
  }

  // Function to handle saving the profile data to Supabase.
  Future<void> _saveProfile() async {
    // Set loading state to true to show the progress indicator.
    setState(() {
      _isLoading = true;
    });

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId == null) {
        throw Exception("User is not authenticated.");
      }

      // Create a new UserProfile object from the form data.
      final updatedProfile = UserProfile(
        id: userId,
        email: userProvider.userProfile!.email,
        name: _nameController.text,
        age: int.tryParse(_ageController.text) ?? 0,
        gender: _genderController.text,
        height: double.tryParse(_heightController.text) ?? 0.0,
        weight: double.tryParse(_weightController.text) ?? 0.0,
      );

      // Use the ProfileDatabase to save the data to Supabase.
      await ProfileDatabase().upsertProfile(
        userId: updatedProfile.id,
        name: updatedProfile.name,
        age: updatedProfile.age,
        gender: updatedProfile.gender,
        height: updatedProfile.height,
        weight: updatedProfile.weight,
      );

      // Show a success message.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (e) {
      // Show an error message if saving fails.
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save profile: $e')));
      }
    } finally {
      // Set loading state to false.
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // We listen to the UserProvider to automatically update the UI
    // when the user profile changes.
    final user = Provider.of<UserProvider>(context).userProfile;

    // Handle the case where no user data is available yet.
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
          backgroundColor: Colors.cyan,
        ),
        body: Center(child: Text("No profile data found.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: Colors.cyan,
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

  // Dispose of the controllers to prevent memory leaks.
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
