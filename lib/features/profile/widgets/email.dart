import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  final String email;
  const Email({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.email,
        color: Colors.white,
      ),
      title: Text(
        email,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: const Text(
        "Email",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
