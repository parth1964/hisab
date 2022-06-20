import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  final String name;
  final String filter;
  final void Function()? onPressed;
  const Filter({
    super.key,
    required this.name,
    required this.onPressed,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: filter == name.toLowerCase()
                ? Colors.white
                : Colors.grey.shade900,
            style: BorderStyle.solid,
          ),
          primary: filter == name.toLowerCase() ? Colors.white : Colors.black,
        ),
        onPressed: onPressed,
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
