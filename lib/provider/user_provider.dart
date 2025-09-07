import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../db/notes_database.dart';

class UserProvider extends ChangeNotifier {
  final ProfileDatabase _db = ProfileDatabase();
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;
  UserProfile? get user => _userProfile; // <-- required for NotePage

  void setUser(UserProfile profile) {
    _userProfile = profile;
    notifyListeners();
  }

  Future<void> loadUserProfile(UserProfile profile) async {
    _userProfile = profile;
    notifyListeners();
  }

  Future<void> saveUserProfile({
    required String userId,
    String? name,
    int? age,
    String? gender,
    double? height,
    double? weight,
  }) async {
    await _db.upsertProfile(
      userId: userId,
      name: name,
      age: age,
      gender: gender,
      height: height,
      weight: weight,
    );
    await loadUserProfile(
      await _db.getProfile(userId) ??
          UserProfile(
            id: userId,
            name: name,
            email: null,
            age: age,
            gender: gender,
            height: height,
            weight: weight,
          ),
    );
  }

  void clearProfile() {
    _userProfile = null;
    notifyListeners();
  }
}
