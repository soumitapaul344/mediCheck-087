import 'package:supabase_flutter/supabase_flutter.dart';

class NotesDatabase {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String _tableName = 'notes';

  // Create Note
  Future<void> createNote(String userId, String content) async {
    try {
      await _supabase.from(_tableName).insert({
        'user_id': userId,
        'content': content,
      });
    } catch (e) {
      throw Exception('Failed to create note: $e');
    }
  }

  // Read Notes
  Future<List<Map<String, dynamic>>> getNotes(String userId) async {
    try {
      final List<dynamic> data = await _supabase
          .from(_tableName)
          .select()
          .eq('user_id', userId);

      return data
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch notes: $e');
    }
  }

  // Update Note
  Future<void> updateNote(int id, String content) async {
    try {
      await _supabase
          .from(_tableName)
          .update({'content': content})
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  // Delete Note
  Future<void> deleteNote(int id) async {
    try {
      await _supabase.from(_tableName).delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }
}
