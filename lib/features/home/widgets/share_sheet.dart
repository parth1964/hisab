import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareSheet extends StatelessWidget {
  final void Function()? onPressed;
  final List share;
  final String uid;
  const ShareSheet(
      {super.key,
      required this.onPressed,
      required this.share,
      required this.uid});

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(color: Colors.black);
    return AlertDialog(
      title: share.contains(uid)
          ? Text(
              'Unshare Sheet',
              style: style,
            )
          : Text(
              'Share Sheet',
              style: style,
            ),
      content: share.contains(uid)
          ? Text(
              "Are you sure you want to unshare sheet?",
              style: style,
            )
          : Text(
              "Are you sure you want to share sheet?",
              style: style,
            ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'Cancel',
            style: style,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: onPressed,
          child: share.contains(uid)
              ? const Text('Unshare')
              : const Text(
                  'Share',
                ),
        ),
        const SizedBox(width: 1)
      ],
    );
  }
}
