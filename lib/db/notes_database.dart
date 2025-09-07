import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';

class ProfileDatabase {
  final supabase = Supabase.instance.client;

  // Get user profile by ID
  Future<UserProfile?> getProfile(String userId) async {
    final profile = await supabase
        .from('users_profiles')
        .select()
        .eq('id', userId)
        .maybeSingle(); // returns single row or null

    if (profile == null) return null;

    return UserProfile.fromJson(profile as Map<String, dynamic>);
  }

  // Insert or update profile
  Future<void> upsertProfile({
    required String userId,
    String? name,
    int? age,
    String? gender,
    double? height,
    double? weight,
  }) async {
    final data = {
      'id': userId,
      'name': name,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
    };

    await supabase.from('users_profiles').upsert(data, onConflict: 'id');
  }
}

// Notes Database for CRUD
class NotesDatabase {
  final supabase = Supabase.instance.client;

  // Get all notes for a user
  Future<List<Map<String, dynamic>>> getNotes(String userId) async {
    final result = await supabase
        .from('signinup')
        .select()
        .eq('user_id', userId);

    return List<Map<String, dynamic>>.from(result);
  }

  // Create a new note
  Future<void> createNote(String userId, String content) async {
    await supabase.from('signinup').insert({
      'user_id': userId,
      'content': content,
    });
  }

  // Update an existing note
  Future<void> updateNote(dynamic id, String content) async {
    await supabase.from('signinup').update({'content': content}).eq('id', id);
  }

  // Delete a note
  Future<void> deleteNote(dynamic id) async {
    await supabase.from('signinup').delete().eq('id', id);
  }
}
