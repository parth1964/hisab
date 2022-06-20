import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class SheetController extends GetxController {
  CollectionReference sheet = FirebaseFirestore.instance.collection("sheet");

  final Stream<QuerySnapshot> sheetStream = FirebaseFirestore.instance
      .collection('sheet')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  Future addSheet({
    required Map<String, dynamic> data,
  }) async {
    await sheet
        .add(data)
        .then((value) => null)
        .catchError((error) => null);
  }

  Future updateSheet(
      {required Map<String, dynamic> data, required String sheetId}) async {
    await sheet
        .doc(sheetId)
        .update(data)
        .then((value) => null)
        .catchError((error) => null);
  }

  Future deleteSheet({required String sheetId}) async {
    await sheet
        .doc(sheetId)
        .delete()
        .then((value) => null)
        .catchError((error) => null);
  }

  Future<void> shareSheet({
    required String sheetId,
    required String uid,
    required List share,
  }) async {
    try {
      if (share.contains(uid)) {
        await sheet.doc(sheetId).update({
          'share': FieldValue.arrayRemove([uid])
        });
      } else {
        await sheet.doc(sheetId).update({
          'share': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      // print(e.toString());
    }
  }
}
