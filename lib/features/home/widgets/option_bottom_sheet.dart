import 'package:flutter/material.dart';

class OptionBottomSheet extends StatelessWidget {
  final void Function()? onDelete;
  final void Function()? onUpdate;
  final void Function()? onShare;
  final bool share;
  const OptionBottomSheet({
    super.key,
    required this.onDelete,
    required this.onUpdate,
    this.onShare,
    this.share = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: share ? 240 : 170,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 6,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: onDelete,
              title: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
              subtitle: const Text(
                "Permanently delete",
                style: TextStyle(color: Colors.white60),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onTap: onUpdate,
              title: const Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                "Update your contant",
                style: TextStyle(color: Colors.white60),
              ),
            ),
            share
                ? ListTile(
                    leading: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onTap: onShare,
                    title: const Text(
                      "Share",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      "Share sheet with friends",
                      style: TextStyle(color: Colors.white60),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
