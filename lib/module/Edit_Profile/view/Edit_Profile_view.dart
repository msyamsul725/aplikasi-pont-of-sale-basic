import 'package:flutter/material.dart';
import '../../../data/app_session.dart';
import '../../../shared/widget/image_picker/image_picker.dart';
import '../../../shared/widget/textfield/textfield.dart';
import '../controller/Edit_Profile_controller.dart';

import 'package:get/get.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) {
        controller.view = this;
        return Scaffold(
          appBar: AppBar(
            title: const Text("EditProfile"),
            actions: [
              InkWell(
                onTap: () => controller.doEdit(),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Save"),
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const ExImagePicker(
                  id: "photo",
                  label: "Photo",
                ),
                const ExTextField(
                  id: "name",
                  label: "Name",
                ),
                ExTextField(
                  id: "email",
                  label: "Email",
                  value: currentUser.email,
                  enabled: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
