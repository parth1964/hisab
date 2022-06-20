import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/controllers/note_controller.dart';
import 'package:hisab/models/note.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});

  final noteCon = Get.put(NoteController());
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  void _addNote() {
    var noteData = Note(
      title: _titleController.text.isEmpty ? "untitled" : _titleController.text,
      note: _noteController.text,
    ).toMap();
    noteCon.addNote(data: noteData);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            hintText: "Title",
            border: InputBorder.none,
          ),
          onChanged: (val) {},
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          child: TextFormField(
            validator: (value) => value!.isEmpty ? "please enter note" : null,
            autofocus: true,
            controller: _noteController,
            maxLines: 8,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: "Take a note..",
              border: InputBorder.none,
            ),
            onChanged: (val) {},
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
                    _addNote();
                  }
                },
                child: const Text("Add"),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }
}
