import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign In
  Future<Session?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.session;
  }

  // Sign Up
  Future<void> signUpWithEmailPassword(String email, String password) async {
    await _supabase.auth.signUp(email: email, password: password);
  }

  // Sign Out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Current User Email
  String? getCurrentUserEmail() {
    return _supabase.auth.currentUser?.email;
  }

  // Current User ID
  String? getCurrentUserId() {
    return _supabase.auth.currentUser?.id;
  }
}
