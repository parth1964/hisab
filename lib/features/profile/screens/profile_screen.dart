import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisab/features/auth/screens/signin_screen.dart';
import 'package:hisab/features/profile/screens/appinfo_screen.dart';

import 'package:hisab/features/profile/widgets/email.dart';
import 'package:hisab/features/profile/widgets/name.dart';
import 'package:hisab/features/profile/widgets/update_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("user")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Photo(),
                    // const SizedBox(height: 20),
                    Name(
                      fullName: data['name'],
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (builder) => UpdateName(
                            userName: data['name'],
                          ),
                        );
                      },
                    ),
                    Email(email: data['email']),

                    ListTile(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Get.off(() => const SigninScreen());
                      },
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Log out",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(AppinfoScreen());
                      },
                      leading: const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "App info",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
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
    );
  }
}
