// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/note_controller.dart';
import '/models/note.dart';

class UpdateNote extends StatelessWidget {
  Note note;
  final String noteId;
  UpdateNote({
    Key? key,
    required this.note,
    required this.noteId,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final noteCon = Get.put(NoteController());

  var _title = "";
  var _note = "";

  void _updateNote() {
    var noteData = Note(title: _title, note: _note).toMap();
    noteCon.updateNote(data: noteData, noteId: noteId);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    _title = note.title;
    _note = note.note;
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: TextFormField(
          initialValue: note.title,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            hintText: "Title",
            border: InputBorder.none,
          ),
          onSaved: (val) {
            _title = val!;
          },
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          child: TextFormField(
            initialValue: note.note,
            autofocus: true,
            maxLines: 8,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: "Take a note..",
              border: InputBorder.none,
            ),
            onSaved: (val) {
              _note = val!;
            },
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Cancel"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _updateNote();
                  }
                },
                child: const Text("Update"),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }
}
