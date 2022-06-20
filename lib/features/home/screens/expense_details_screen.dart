import 'package:flutter/material.dart';
import 'package:hisab/models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  final Expense expense;
  const ExpenseDetailsScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Details")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: double.infinity,
          // height: 220,
          child: Card(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                          width: 150,
                          child: Text(
                            "Name",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )),
                      Text(
                        expense.name,
                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(
                          width: 150,
                          child: Text(
                            "Price",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )),
                      Text(
                        "₹ ${expense.price.toString().split(".").last == "0" ? expense.price.toString().split('.').first : expense.price.toString()}",
                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(
                          width: 150,
                          child: Text(
                            "Quantity",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )),
                      Text(
                        expense.quantity.toString(),
                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(
                          width: 150,
                          child: Text(
                            "Total",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )),
                      Text(
                        "₹ ${expense.total.toString().split(".").last == "0" ? expense.total.toString().split('.').first : expense.total.toString()}",
                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(
                          width: 150,
                          child: Text(
                            "Date",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )),
                      Text(
                        DateFormat("d MMMM, y").format(expense.date),
                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(
                          width: 150,
                          child: Text(
                            "Details",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )),
                      expense.detail != ""
                          ? Text(
                              expense.detail.toString(),
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            )
                          : const Text(
                              " - ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
