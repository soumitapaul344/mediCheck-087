import 'package:supabase_flutter/supabase_flutter.dart';

class NotesDatabase {
  final _table = Supabase.instance.client.from('notes');

  // Create Note
  Future<void> createNote(String userId, String content) async {
    await _table.insert({'user_id': userId, 'content': content});
  }

  // Read Notes
  Future<List<Map<String, dynamic>>> getNotes(String userId) async {
    final response = await _table.select().eq('user_id', userId).execute();
    return (response.data as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  // Update Note
  Future<void> updateNote(int id, String content) async {
    await _table.update({'content': content}).eq('id', id);
  }

  // Delete Note
  Future<void> deleteNote(int id) async {
    await _table.delete().eq('id', id);
  }
}
