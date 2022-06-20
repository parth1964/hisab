import 'package:flutter/material.dart';

class Name extends StatelessWidget {
  final String fullName;
  final void Function()? onTap;
  const Name({
    super.key,
    required this.fullName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(
        Icons.person,
        color: Colors.white,
      ),
      title: Text(
        fullName,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: const Text(
        "Name",
        style: TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
  }
}
