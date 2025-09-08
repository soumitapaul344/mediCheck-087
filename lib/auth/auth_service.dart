import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // Sign Up and insert into users_profiles table
  Future<UserProfile?> signUp(
    String email,
    String password, {
    String name = "User",
    int age = 0,
    String gender = "N/A",
    double height = 0,
    double weight = 0,
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) return null;

    final profile = {
      'id': user.id,
      'email': email,
      'name': name,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
    };

    await supabase.from('users_profiles').insert(profile);

    return UserProfile.fromJson(profile);
  }

  // Sign In and fetch profile
  Future<UserProfile?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) return null;

    final profileData = await supabase
        .from('users_profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (profileData == null) {
      return UserProfile(
        id: user.id,
        email: user.email ?? email,
        name: "User",
        age: 0,
        gender: "N/A",
        height: 0,
        weight: 0,
      );
    }

    return UserProfile.fromJson(profileData);
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
