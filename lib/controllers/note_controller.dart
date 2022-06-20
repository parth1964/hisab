import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  CollectionReference sheet = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("note");
  final Stream<QuerySnapshot> noteStream = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('note')
      .snapshots();
  Future addNote({required Map<String, dynamic> data}) async {
    await sheet
        .add(data)
        .then((value) =>null)
        .catchError((error) => null);
  }

  Future updateNote(
      {required Map<String, dynamic> data, required String noteId}) async {
    await sheet
        .doc(noteId)
        .update(data)
        .then((value) => null)
        .catchError((error) => null);
  }
}
