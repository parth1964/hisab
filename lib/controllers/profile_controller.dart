import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('user');

  Future<void> updateUser(String name) {
    return users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'name': name})
        .then((value) => null)
        .catchError((error) => null);
  }

  File? image;

  Future pickImage({bool camera = false}) async {
    try {
      final XFile? img;
      camera
          ? img = await ImagePicker().pickImage(source: ImageSource.camera)
          : img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) {
        return;
      } else {
        final imageTemp = File(img.path);

        image = imageTemp;
        await addImage();
      }

    } on PlatformException {
      // print("image pick faild : $e");
    }
  }

  uploadImage() async {
    final path = 'img/$image';
    final ref = FirebaseStorage.instance.ref().child(path).putFile(image!);
    final snap = await ref.whenComplete(() {});
    final imgUrl = await snap.ref.getDownloadURL();
    return imgUrl;
  }

  Future addImage() async {

    FirebaseFirestore.instance
        .collection('user')
        .doc('xyz')
        .update({'image': uploadImage()})
        .then((value) => null)
        .catchError((error) => null);
  }
}
