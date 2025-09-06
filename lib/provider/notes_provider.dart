import 'package:flutter/material.dart';
import '../db/notes_database.dart';

class NotesProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _notes = [];
  final NotesDatabase _notesDatabase = NotesDatabase();

  List<Map<String, dynamic>> get notes => _notes;

  Future<void> loadNotes(String userId) async {
    try {
      _notes = await _notesDatabase.getNotes(userId);
      notifyListeners();
    } catch (e) {
      print('Error loading notes: $e');
    }
  }

  Future<void> addNote(String userId, String content) async {
    try {
      await _notesDatabase.createNote(userId, content);
      await loadNotes(userId); // Reload notes to get the updated list
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  Future<void> updateNote(int id, String content) async {
    try {
      await _notesDatabase.updateNote(id, content);
      // Update the local list
      final index = _notes.indexWhere((note) => note['id'] == id);
      if (index != -1) {
        _notes[index]['content'] = content;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating note: $e');
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await _notesDatabase.deleteNote(id);
      // Remove from local list
      _notes.removeWhere((note) => note['id'] == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}
