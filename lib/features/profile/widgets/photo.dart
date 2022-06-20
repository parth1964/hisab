import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hisab/features/profile/widgets/pick_photo.dart';

import '../../../controllers/profile_controller.dart';

class Photo extends StatelessWidget {
  Photo({super.key});
  final profileCon = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Column(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const PickPhoto();
                    },
                  );
                },
                child: ClipOval(
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                    child: profileCon.image != null
                        ? Image.file(
                            profileCon.image!,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
