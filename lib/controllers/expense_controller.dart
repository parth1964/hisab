import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class ExpenseController extends GetxController {
  CollectionReference sheet = FirebaseFirestore.instance.collection("sheet");
  Future addExpense(
      {required Map<String, dynamic> data, required String sheetId}) async {
    await sheet
        .doc(sheetId)
        .collection("expense")
        .add(data)
        .then((value) => null)
        .catchError((error) => null);
  }

  Future updateExpense({
    required Map<String, dynamic> data,
    required String sheetId,
    required String expenseId,
  }) async {
    await sheet
        .doc(sheetId)
        .collection("expense")
        .doc(expenseId)
        .update(data)
        .then((value) => null)
        .catchError((error) => null);
  }

  Future deleteExpense({
    required String sheetId,
    required String expenseId,
  }) async {
    await sheet.doc(sheetId).collection("expense").doc(expenseId).delete();
  }
}
