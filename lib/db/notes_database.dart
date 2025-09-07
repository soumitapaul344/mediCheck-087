import 'package:supabase_flutter/supabase_flutter.dart';

class NotesDatabase {
  final _supabase = Supabase.instance.client;
  final String _tableName = 'notes';

  // ✅ Create Note
  Future<void> createNote(String userId, String content) async {
    await _supabase.from(_tableName).insert({
      'user_id': userId,
      'content': content,
    });
  }

  // ✅ Read Notes (returns list of maps)
  Future<List<Map<String, dynamic>>> getNotes(String userId) async {
    final response = await _supabase
        .from(_tableName)
        .select()
        .eq('user_id', userId);

    // response is already the list of notes
    return (response as List<dynamic>)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
  }

  // ✅ Update Note
  Future<void> updateNote(dynamic id, String content) async {
    await _supabase.from(_tableName).update({'content': content}).eq('id', id);
  }

  // ✅ Delete Note
  Future<void> deleteNote(dynamic id) async {
    await _supabase.from(_tableName).delete().eq('id', id);
  }
}
