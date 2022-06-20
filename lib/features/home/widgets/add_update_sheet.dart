import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/controllers/sheet_controller.dart';
import 'package:hisab/models/sheet.dart';

import '/constants/utils.dart';
import 'custom_text_form_field.dart';

class AddUpdateSheet extends StatelessWidget {
  final bool update;
  final String sheetName;
  final String sheetId;
  AddUpdateSheet({
    super.key,
    this.update = false,
    this.sheetName = "",
    this.sheetId = "",
  });
  final sheetCon = Get.put(SheetController());
  final _formKey = GlobalKey<FormState>();
  final _sheetController = TextEditingController();
//add sheet
  void _addSheet(BuildContext context) {
    var sheetData = Sheet(
      uid: FirebaseAuth.instance.currentUser!.uid,
      name: _sheetController.text,
      date: DateTime.parse(DateTime.now().toString()),
      share: [],
    ).toMap();
    //firebase query
    sheetCon.addSheet(data: sheetData);
    showSnackBar(context, "Sheet created");

    Get.back();
    Get.back();
  }

//updating sheet
  void _updateSheet(BuildContext context) {
    var sheetData = {
      "name": _sheetController.text,
    };
    //firebase query
    sheetCon.updateSheet(data: sheetData, sheetId: sheetId);
    showSnackBar(context, "Sheet updated");
    Get.back();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    _sheetController.text = sheetName;
    _sheetController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: sheetName.length,
    );
    return AlertDialog(
      title: update ? const Text('Update Sheet') : const Text('Add Sheet'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        child: Form(
          key: _formKey,
          child: CustomTextFormField(
            autofocus: true,
            label: "Sheet Name*",
            controller: _sheetController,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              update == true ? _updateSheet(context) : _addSheet(context);
            }
          },
          child: update ? const Text('Update') : const Text('Add'),
        ),
        SizedBox(width: update ? 8 : 0)
      ],
    );
  }
}
