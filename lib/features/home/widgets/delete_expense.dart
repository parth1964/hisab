import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DeleteExpense extends StatelessWidget {
  final void Function()? onPressed;

  const DeleteExpense({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Expense'),
      content: const Text("Are you sure you want to delete expense?"),
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
      ],
    );
  }
}
