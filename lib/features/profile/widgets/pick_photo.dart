import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hisab/controllers/profile_controller.dart';

class PickPhoto extends StatefulWidget {
  const PickPhoto({super.key});

  @override
  State<PickPhoto> createState() => _PickPhotoState();
}

class _PickPhotoState extends State<PickPhoto> {
  final profileCon = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      color: Colors.black,
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profile Photo",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 20),
              Column(
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () => profileCon.pickImage(camera: true),
                    child: const Icon(Icons.camera_alt),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Camera",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(width: 40),
              Column(
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () => profileCon.pickImage(),
                    child: const Icon(Icons.photo),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Gallery",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
