import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/note_service.dart';

class NoteDialog extends StatelessWidget {
  final Note? note;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  NoteDialog({super.key, this.note}) {
    if (note != null) {
      _titleController.text = note!.title;
      _descriptionController.text = note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(note == null ? 'Add Notes' : 'Update Notes'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Title: ',
            textAlign: TextAlign.start,
          ),
          TextField(
            controller: _titleController,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Description: ',
            ),
          ),
          TextField(
            controller: _descriptionController,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (note == null) {
              NoteService.addNote(Note(
                      title: _titleController.text,
                      description: _descriptionController.text,))
                  .whenComplete(() {
                Navigator.of(context).pop();
              });
            } else {
              NoteService.updateNote(Note(
                id: note!.id,
                title: _titleController.text, 
                description: _descriptionController.text,
                createdAt: note!.createdAt,))
                  .whenComplete(() => Navigator.of(context).pop());
            }
          },
          child: Text(note == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
