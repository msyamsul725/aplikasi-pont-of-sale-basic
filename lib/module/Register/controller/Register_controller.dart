import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hyper_ui/core.dart';
import 'package:get/get.dart';
import '../../../service/user_service.dart';
import '../../../shared/util/input/input.dart';

class RegisterController extends GetxController {
  RegisterView? view;

  doRegister() async {
    var email = Input.get("email");
    var password = Input.get("password");
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await UserService.saveCurrentUser();
      Get.offAll(const MainNavigationView());
    } on Exception catch (_) {
      Get.snackbar("Error", "Your Request Failed");
    }
  }
}
