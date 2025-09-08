import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../db/profile_database.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileDatabase _db = ProfileDatabase();
  UserProfile? _profile;

  UserProfile? get userProfile => _profile;

  Future<void> loadProfile(String userId) async {
    _profile = await _db.getProfile(userId);
    notifyListeners();
  }

  Future<void> saveProfile(UserProfile profile) async {
    await _db.upsertProfile(
      userId: profile.id,
      name: profile.name,
      age: profile.age,
      gender: profile.gender,
      height: profile.height,
      weight: profile.weight,
    );
    _profile = profile;
    notifyListeners();
  }

  Future<void> deleteProfile(String userId) async {
    await _db.deleteProfile(userId);
    _profile = null;
    notifyListeners();
  }
}
