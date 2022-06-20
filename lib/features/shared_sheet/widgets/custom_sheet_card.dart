import 'package:flutter/material.dart';

class CustomSheetCard extends StatelessWidget {
  final String sheetName;
  final String lastExpense;
  final String date;
  final void Function()? onTap;

  const CustomSheetCard({
    super.key,
    required this.onTap,
    required this.sheetName,
    required this.lastExpense,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        sheetName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        lastExpense,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: Text(
        date,
        style: const TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
