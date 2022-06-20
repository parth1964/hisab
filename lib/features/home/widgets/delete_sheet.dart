import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteSheet extends StatelessWidget {
  final void Function()? onPressed;
  const DeleteSheet({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Sheet'),
      content: const Text("Are you sure you want to delete sheet?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: onPressed,
          child: const Text(
            'Delete',
            // style: TextStyle(color: Colors.red),
          ),
        ),
        const SizedBox(width: 1)
      ],
    );
  }
}
