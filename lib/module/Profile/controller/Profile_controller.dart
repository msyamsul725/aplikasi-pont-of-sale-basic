import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../Login/view/Login_view.dart';
import '../view/Profile_view.dart';

class ProfileController extends GetxController {
  ProfileView? view;

  doLogout() async {
    await FirebaseAuth.instance.signOut();
    await Get.deleteAll();
    Get.offAll(const LoginView());
  }
}
