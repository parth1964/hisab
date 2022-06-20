import 'package:flutter/material.dart';

class CustomExpenseCard extends StatelessWidget {
  final String expenseName;
  final String date;
  final String money;
  final void Function()? onTap;
  final void Function()? onLongPress;
  const CustomExpenseCard({
    super.key,
    required this.onTap,
    required this.onLongPress,
    required this.expenseName,
    required this.date,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      onTap: onTap,
      title: Text(
        expenseName,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        date,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Text(
        "₹ $money",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
