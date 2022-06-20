import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/common/widgets/bottom_bar.dart';

import 'package:hisab/features/auth/screens/signin_screen.dart';
import 'constants/global_variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hisab',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: GlobalVariables.primaryColour,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const BottomBar();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "H i s a b",
                      style: TextStyle(color: Colors.black, fontSize: 50),
                    ),
                    SizedBox(height: 50),
                    CircularProgressIndicator(
                      color: Colors.black54,
                    ),
                  ],
                ),
              );
            }
            return SigninScreen();
          }),
    );
  }
}
