import 'package:flutter/material.dart';

class AppinfoScreen extends StatelessWidget {
  AppinfoScreen({super.key});
  var style = const TextStyle(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("This is hisab app!")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              """- this is 'hisab' app in this app you can add sheet,
- in this sheet you can add your expenses,
- there is one onother option for save an some impotant nots in this app,
- all opration perform in this expenses, sheets and nots.""",
              style: style,
            )
          ],
        ),
      ),
    );
  }
}
