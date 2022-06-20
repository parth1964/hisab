import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_expense_card.dart';

class ShareadExpenseSearchDelegate extends SearchDelegate {
  final String sheetId;
  ShareadExpenseSearchDelegate(this.sheetId);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white38,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
    return theme;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('sheet')
          .doc(sheetId)
          .collection("expense")
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final results = snapshot.data!.docs.where(
            (a) => a['name'].toLowerCase().contains(query.toLowerCase()));
        //total expense
        var total = 0.0;
        results.forEach((element) {
          total += (element['total']);
        });
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          color: Colors.black,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(color: Colors.grey, fontSize: 24),
                    ),
                    Text(
                      "₹ $total",
                      style: const TextStyle(color: Colors.white, fontSize: 33),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              ...results
                  .map<Widget>(
                    (a) => CustomExpenseCard(
                      onTap: null,
                      expenseName: a['name'],
                      date: DateFormat("d MMMM, y").format(a['date'].toDate()),
                      money: a['total'].toString(),
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      },
    );
  }
}
