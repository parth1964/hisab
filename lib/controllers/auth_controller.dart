import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hisab/common/widgets/bottom_bar.dart';
import 'package:hisab/constants/utils.dart';
import 'package:hisab/features/auth/screens/signin_screen.dart';

class AuthController extends GetxController {
  var userAuth = FirebaseAuth.instance;

  Future createAccount({required Map<String, dynamic> data, context}) async {
    try {
      await userAuth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data)
          .then((value) => null)
          .catchError((error) => null);

      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
            'uid': FirebaseAuth.instance.currentUser!.uid,
          })
          .then((value) => showSnackBar(context, "User Added"))
          .catchError(
              (error) => showSnackBar(context, "Failed to add user: $error"));
      Get.off(const SigninScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future signIn({required Map<String, dynamic> data, context}) async {
    try {
      await userAuth
          .signInWithEmailAndPassword(
              email: data['email'], password: data['password'])
          .then((value) {
        if (value.user != null) {
          Get.off(() => const BottomBar());
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
      }
    }
  }
}
