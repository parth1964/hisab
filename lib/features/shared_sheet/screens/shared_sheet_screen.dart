import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hisab/features/shared_sheet/screens/shared_expense_screen.dart';

import 'package:intl/intl.dart';

import '/models/sheet.dart';

import '/controllers/sheet_controller.dart';
import '/constants/global_variables.dart';

import '../widgets/custom_sheet_card.dart';

class SharedSheetScreen extends StatefulWidget {
  const SharedSheetScreen({super.key});

  @override
  State<SharedSheetScreen> createState() => _SharedSheetScreenState();
}

final sheetCon = Get.put(SheetController());

class _SharedSheetScreenState extends State<SharedSheetScreen> {
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
            stream: FirebaseFirestore.instance
                .collection('sheet')
                .where('share',
                    arrayContains: FirebaseAuth.instance.currentUser!.uid)
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
                    "Shared sheet not avaible",
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
                            onTap: () {
                              Get.to(
                                () => SharedExpenseScreen(
                                  sheetName: sheet.name,
                                  sheetId: snapshot.data!.docs[i].id,
                                ),
                              );
                            },
                            sheetName: sheet.name,
                            lastExpense:
                                DateFormat("d MMMM, y").format(sheet.date),
                            date: "",
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
    );
  }
}
