import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/features/note/widgets/add_note.dart';
import 'package:hisab/features/note/widgets/update_note.dart';

import '/controllers/note_controller.dart';
import '/models/note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final noteCon = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0,
              title: Text("Notes"),
            ),
          ];
        },
        body: StreamBuilder<QuerySnapshot>(
            stream: noteCon.noteStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text(
                  'Something went wrong',
                  style: TextStyle(color: Colors.white),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "Notes not avaible, Add some",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              if (snapshot.hasData) {
                return MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      var data =
                          snapshot.data!.docs[i].data() as Map<String, dynamic>;
                      Note note = Note.fromMap(data);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Card(
                          color: const Color.fromARGB(255, 26, 26, 26),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  useSafeArea: true,
                                  context: context,
                                  builder: (builder) {
                                    return UpdateNote(
                                      note: note,
                                      noteId: snapshot.data!.docs[i].id,
                                    );
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    note.title,
                                    style: const TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    note.note,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AddNote(),
          );
        },
        // backgroundColor: GlobalVariables.primaryColour,
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
