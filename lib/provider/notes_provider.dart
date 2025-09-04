import 'package:flutter/material.dart';
import '../db/notes_database.dart';

class NotesProvider with ChangeNotifier {
  final NotesDatabase _db = NotesDatabase();
  List<Map<String, dynamic>> _notes = [];

  List<Map<String, dynamic>> get notes => _notes;

  Future<void> loadNotes(String userId) async {
    final response = await _db.getNotes(userId);
    _notes = response;
    notifyListeners();
  }

  Future<void> addNote(String userId, String content) async {
    await _db.createNote(userId, content);
    await loadNotes(userId);
  }

  Future<void> updateNote(int id, String content, String userId) async {
    await _db.updateNote(id, content);
    await loadNotes(userId);
  }

  Future<void> deleteNote(int id, String userId) async {
    await _db.deleteNote(id);
    await loadNotes(userId);
  }
}
