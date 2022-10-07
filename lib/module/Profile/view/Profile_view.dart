import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../data/app_session.dart';
import '../../Edit_Profile/view/Edit_Profile_view.dart';
import '../controller/Profile_controller.dart';

import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            actions: [
              InkWell(
                onTap: () => Get.to(const EditProfileView()),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Edit"),
                ),
              ),
              InkWell(
                onTap: () => controller.doLogout(),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Logout"),
                ),
              ),
            ],
          ),
          body: StreamBuilder<DocumentSnapshot<Object?>>(
            stream: userCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return const Text("Error");
              if (!snapshot.hasData) return const Text("No Data");
              Map item = (snapshot.data!.data() as Map);

              return Container(
                padding: const EdgeInsets.all(20.0),
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: Get.width / 6,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(
                        item["photo"] ??
                            "https://i.ibb.co/S32HNjD/no-image.jpg",
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "${item["name"]}",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      "${item["email"]}",
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
