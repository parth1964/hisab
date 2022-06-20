import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hisab/features/home/screens/sharing_sheet_screen.dart';
import 'package:intl/intl.dart';

import '/constants/utils.dart';
import '/models/sheet.dart';
import '../widgets/add_update_sheet.dart';
import '/controllers/sheet_controller.dart';
import '/constants/global_variables.dart';
import '../screens/expense_screen.dart';
import '../widgets/custom_sheet_card.dart';
import '../widgets/delete_sheet.dart';
import '../widgets/option_bottom_sheet.dart';

class SheetScreen extends StatefulWidget {
  const SheetScreen({super.key});

  @override
  State<SheetScreen> createState() => _SheetScreenState();
}

final sheetCon = Get.put(SheetController());

class _SheetScreenState extends State<SheetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.primaryColour,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0,
              title: Text('Hisab'),
            ),
          ];
        },
        body: StreamBuilder<QuerySnapshot>(
            stream: sheetCon.sheetStream,
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
                    "Sheet not avaible, Add some",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              if (snapshot.hasData) {
                return MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (ctx, i) {
                          var data = snapshot.data!.docs[i].data()
                              as Map<String, dynamic>;
                          Sheet sheet = Sheet.fromMap(data);
                          return CustomSheetCard(
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (ctx) {
                                  return OptionBottomSheet(
                                    share: true,
                                    onDelete: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            DeleteSheet(
                                          onPressed: () {
                                            sheetCon.deleteSheet(
                                              sheetId:
                                                  snapshot.data!.docs[i].id,
                                            );
                                            Get.back();
                                            Get.back();
                                            showSnackBar(
                                                context, "Sheet ${sheet.name} deleted");
                                          },
                                        ),
                                      );
                                    },
                                    onUpdate: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AddUpdateSheet(
                                          sheetName: sheet.name,
                                          update: true,
                                          sheetId: snapshot.data!.docs[i].id,
                                        ),
                                      );
                                    },
                                    onShare: () {
                                      showSearch(
                                        context: context,
                                        delegate: SharingSheetScreen(
                                          snapshot.data!.docs[i].id,
                                          snapshot.data!.docs[i]['share'],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            onTap: () {
                              Get.to(
                                () => ExpenseScreen(
                                  sheetName: sheet.name,
                                  sheetId: snapshot.data!.docs[i].id,
                                ),
                              );
                            },
                            sheetName: sheet.name,
                            lastExpense:
                                DateFormat("d MMMM, y").format(sheet.date),
                            date: '',
                          );
                        }),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AddUpdateSheet(),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
