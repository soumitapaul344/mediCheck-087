import 'package:supabase_flutter/supabase_flutter.dart';

class NotesDatabase {
  final _supabase = Supabase.instance.client;
  final String _tableName = 'notes';

  // Create Note
  Future<void> createNote(String userId, String content) async {
    final response = await _supabase.from(_tableName).insert({
      'user_id': userId,
      'content': content,
    });

    if (response.error != null) {
      throw Exception('Failed to create note: ${response.error!.message}');
    }
  }

  // Read Notes
  Future<List<Map<String, dynamic>>> getNotes(String userId) async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .eq('user_id', userId);

    if (response.error != null) {
      throw Exception('Failed to fetch notes: ${response.error!.message}');
    }

    return (response.data as List<dynamic>)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  // Update Note
  Future<void> updateNote(int id, String content) async {
    final response = await _supabase
        .from(_tableName)
        .update({'content': content})
        .eq('id', id);

    if (response.error != null) {
      throw Exception('Failed to update note: ${response.error!.message}');
    }
  }

  // Delete Note
  Future<void> deleteNote(int id) async {
    final response = await _supabase.from(_tableName).delete().eq('id', id);

    if (response.error != null) {
      throw Exception('Failed to delete note: ${response.error!.message}');
    }
  }
}
