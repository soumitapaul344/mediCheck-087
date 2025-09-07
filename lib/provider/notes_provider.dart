import 'package:flutter/material.dart';
import '../db/notes_database.dart';

class NotesProvider with ChangeNotifier {
  final NotesDatabase _db = NotesDatabase();

  List<Map<String, dynamic>> _notes = [];
  List<Map<String, dynamic>> get notes => _notes;

  // Load notes for a user
  Future<void> loadNotes(String userId) async {
    try {
      final result = await _db.getNotes(userId);
      _notes = result;
      notifyListeners();
    } catch (e) {
      // for beginner: you can log or rethrow
      debugPrint('loadNotes error: $e');
      rethrow;
    }
  }

  // Add a new note (requires userId)
  Future<void> addNote(String userId, String content) async {
    try {
      await _db.createNote(userId, content);
      await loadNotes(userId);
    } catch (e) {
      debugPrint('addNote error: $e');
      rethrow;
    }
  }

  // Update an existing note (id can be int or String depending on DB)
  Future<void> updateNote(dynamic id, String content, String userId) async {
    try {
      await _db.updateNote(id, content);
      await loadNotes(userId);
    } catch (e) {
      debugPrint('updateNote error: $e');
      rethrow;
    }
  }

  // Delete note by id
  Future<void> deleteNote(dynamic id, String userId) async {
    try {
      await _db.deleteNote(id);
      await loadNotes(userId);
    } catch (e) {
      debugPrint('deleteNote error: $e');
      rethrow;
    }
  }
}
