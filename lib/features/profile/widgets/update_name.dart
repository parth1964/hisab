import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controllers/profile_controller.dart';
import '../../auth/widgets/custom_text_form_field.dart';
import '/constants/utils.dart';

class UpdateName extends StatelessWidget {
  final String userName;

  UpdateName({super.key, required this.userName});

  final profileCon = Get.put(ProfileController());

  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
//updating sheet
  void _updateName(BuildContext context) {
    profileCon.updateUser(_nameController.text);
    //firebase query
    showSnackBar(context, "name updated");
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = userName;
    _nameController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: userName.length,
    );
    return AlertDialog(
      title: const Text('Update Name'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        child: Form(
          key: _formKey,
          child: CustomTextFormField(
            autofocus: true,
            label: "Sheet Name*",
            controller: _nameController,
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
              _updateName(context);
            }
          },
          child: const Text('Update'),
        ),
        const SizedBox(width: 8)
      ],
    );
  }
}
