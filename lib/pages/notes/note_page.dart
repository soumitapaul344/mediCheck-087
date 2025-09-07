import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/notes_provider.dart';
import '../../provider/user_provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _noteController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // load notes if user exists
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      Provider.of<NotesProvider>(context, listen: false).loadNotes(user.id);
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> addNote() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == null) return;

    final content = _noteController.text.trim();
    if (content.isEmpty) return;

    setState(() => _loading = true);
    try {
      await Provider.of<NotesProvider>(
        context,
        listen: false,
      ).addNote(user.id, content);
      _noteController.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Add note failed: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> deleteNote(dynamic note) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == null) return;

    // get id safely
    final id = note['id'];
    if (id == null) return;

    setState(() => _loading = true);
    try {
      await Provider.of<NotesProvider>(
        context,
        listen: false,
      ).deleteNote(id, user.id);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesProvider>(context).notes;

    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(hintText: "Add note"),
                  ),
                ),
                _loading
                    ? const SizedBox(
                        width: 48,
                        height: 48,
                        child: CircularProgressIndicator(),
                      )
                    : IconButton(
                        onPressed: addNote,
                        icon: const Icon(Icons.add),
                      ),
              ],
            ),
          ),
          Expanded(
            child: notes.isEmpty
                ? const Center(child: Text("No notes yet"))
                : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (_, index) {
                      final note = notes[index];
                      final content = (note['content'] ?? '').toString();
                      return ListTile(
                        title: Text(content),
                        subtitle: Text('id: ${note['id']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteNote(note),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
