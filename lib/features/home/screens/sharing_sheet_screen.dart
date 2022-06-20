import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/features/home/widgets/share_sheet.dart';

import '../../../constants/utils.dart';
import '/controllers/sheet_controller.dart';
import '../widgets/custom_sheet_card.dart';

class SharingSheetScreen extends SearchDelegate {
  final String sheetId;
  final List share;
  final sheetCon = Get.put(SheetController());

  SharingSheetScreen(this.sheetId, this.share);
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
        Get.back();
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
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final results = snapshot.data!.docs.where(
            (a) => a['name'].toLowerCase().contains(query.toLowerCase()));
        //total expense

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          color: Colors.black,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: results
                .map<Widget>(
                  (a) => CustomSheetCard(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (builder) {
                          return ShareSheet(
                            share: share,
                            uid: a['uid'],
                            onPressed: () {
                              sheetCon.shareSheet(
                                sheetId: sheetId,
                                uid: a['uid'],
                                share: share,
                              );
                              Get.back();
                              Get.back();
                              Get.back();
                              showSnackBar(context, "sheet shared");
                            },
                          );
                        },
                      );
                    },
                    onLongPress: null,
                    sheetName: a['name'],
                    lastExpense: a['email'],
                    date: share.contains(a['uid']) ? "Shared" : "",
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
