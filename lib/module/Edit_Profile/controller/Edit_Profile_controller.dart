import 'package:get/get.dart';
import '../../../data/app_session.dart';
import '../../../shared/util/input/input.dart';
import '../view/Edit_Profile_view.dart';

class EditProfileController extends GetxController {
  EditProfileView? view;

  doEdit() async {
    var photo = Input.get("photo");
    var name = Input.get("name");

    await userCollection.update({
      "name": name,
      "photo": photo,
    });

    Get.back();
  }
}
