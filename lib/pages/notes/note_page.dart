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
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      Provider.of<NotesProvider>(context, listen: false).loadNotes(user.id);
    }
  }

  void addNote() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == null) return;

    final content = _noteController.text;
    if (content.isEmpty) return;

    await Provider.of<NotesProvider>(
      context,
      listen: false,
    ).addNote(user.id, content);
    _noteController.clear();
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
                IconButton(onPressed: addNote, icon: const Icon(Icons.add)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (_, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note['content']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      final user = Provider.of<UserProvider>(
                        context,
                        listen: false,
                      ).user;
                      if (user != null) {
                        Provider.of<NotesProvider>(
                          context,
                          listen: false,
                        ).deleteNote(note['id'], user.id);
                      }
                    },
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
