import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';

class ProfileDatabase {
  final supabase = Supabase.instance.client;

  // CREATE / UPDATE profile
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

  // READ profile
  Future<UserProfile?> getProfile(String userId) async {
    final profile = await supabase
        .from('users_profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (profile == null) return null;

    return UserProfile.fromJson(profile);
  }

  // DELETE profile
  Future<void> deleteProfile(String userId) async {
    await supabase.from('users_profiles').delete().eq('id', userId);
  }
}
