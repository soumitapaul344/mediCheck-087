import 'package:flutter/material.dart';
import '../db/notes_database.dart';

class NotesProvider extends ChangeNotifier {
  final NotesDatabase _database = NotesDatabase();
  List<Map<String, dynamic>> _notes = [];

  List<Map<String, dynamic>> get notes => _notes;

  Future<void> loadNotes(String userId) async {
    _notes = await _database.getNotes(userId);
    notifyListeners();
  }

  Future<void> addNote(String userId, String content) async {
    await _database.createNote(userId, content);
    await loadNotes(userId);
  }

  Future<void> deleteNote(int id, String userId) async {
    await _database.deleteNote(id);
    await loadNotes(userId);
  }
}
