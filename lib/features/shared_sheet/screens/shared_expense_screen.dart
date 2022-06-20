import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:hisab/features/home/screens/expense_details_screen.dart';
import 'package:hisab/features/home/widgets/filter.dart';
import 'package:hisab/models/expense.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_expense_card.dart';

import '/constants/global_variables.dart';
import 'shared_expense_search_delegate.dart';

class SharedExpenseScreen extends StatefulWidget {
  final String sheetName;
  final String sheetId;
  const SharedExpenseScreen(
      {super.key, required this.sheetName, required this.sheetId});

  @override
  State<SharedExpenseScreen> createState() => _SharedExpenseScreenState();
}

// double total = 0.0;
String _filter = "date";

class _SharedExpenseScreenState extends State<SharedExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.primaryColour,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // expandedHeight: 140,
              floating: true,
              snap: true,
              elevation: 0,
              title: Text(widget.sheetName),
            ),
          ];
        },
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('sheet')
                .doc(widget.sheetId)
                .collection('expense')
                .orderBy(_filter, descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text(
                  'Something went wrong',
                  style: TextStyle(color: Colors.white),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No expense avaible, add some",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              var total = 0.0;
              snapshot.data!.docs.forEach(
                (element) {
                  total += (element['total']);
                },
              );
              if (snapshot.hasData) {
                return MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 24),
                              ),
                              Text(
                                "₹ $total",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 33),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    showSearch(
                                      context: context,
                                      delegate: ShareadExpenseSearchDelegate(
                                          widget.sheetId),
                                    );
                                  },
                                  child: TextField(
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 19),
                                      hintText: "Find in expenses",
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade800),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      enabled: false,
                                    ),
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                                set) {
                                          return Container(
                                            padding: const EdgeInsets.all(18),
                                            color: Colors.black,
                                            height: 300,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 6,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                const Text(
                                                  "Filter By",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Filter(
                                                    filter: _filter,
                                                    name: "Date",
                                                    onPressed: () {
                                                      set(() {});
                                                      setState(() =>
                                                          _filter = "date");
                                                    }),
                                                Filter(
                                                    name: "Name",
                                                    filter: _filter,
                                                    onPressed: () {
                                                      set(() {});
                                                      setState(() =>
                                                          _filter = "name");
                                                    }),
                                                Filter(
                                                    name: "Total",
                                                    filter: _filter,
                                                    onPressed: () {
                                                      set(() {});
                                                      setState(() =>
                                                          _filter = "total");
                                                    }),
                                                Filter(
                                                    name: "quantity",
                                                    filter: _filter,
                                                    onPressed: () {
                                                      set(() {});
                                                      setState(() =>
                                                          _filter = "quantity");
                                                    }),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  "filter",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, i) {
                            var data = snapshot.data!.docs[i].data()
                                as Map<String, dynamic>;
                            Expense expense = Expense.fromMap(data);
                            return CustomExpenseCard(
                              onTap: () {
                                Get.to(
                                  () => ExpenseDetailsScreen(
                                    expense: expense,
                                  ),
                                );
                              },
                              expenseName: expense.name,
                              date:
                                  DateFormat("d MMMM, y").format(expense.date),
                              money: expense.total.toString().split(".").last ==
                                      "0"
                                  ? expense.total.toString().split('.').first
                                  : expense.total.toString(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            }),
      ),
    );
  }
}
