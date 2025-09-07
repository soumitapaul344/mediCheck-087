import 'package:flutter/material.dart';
import '../db/notes_database.dart';

class NotesProvider with ChangeNotifier {
  final NotesDatabase _db = NotesDatabase();

  List<Map<String, dynamic>> _notes = [];
  List<Map<String, dynamic>> get notes => _notes;

  Future<void> loadNotes(String userId) async {
    try {
      _notes = await _db.getNotes(userId);
      notifyListeners();
    } catch (e) {
      debugPrint('loadNotes error: $e');
      rethrow;
    }
  }

  Future<void> addNote(String userId, String content) async {
    await _db.createNote(userId, content);
    await loadNotes(userId);
  }

  Future<void> updateNote(dynamic id, String content, String userId) async {
    await _db.updateNote(id, content);
    await loadNotes(userId);
  }

  Future<void> deleteNote(dynamic id, String userId) async {
    await _db.deleteNote(id);
    await loadNotes(userId);
  }
}
