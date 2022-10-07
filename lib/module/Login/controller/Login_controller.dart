import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../shared/util/input/input.dart';
import '../../MainNavigation/view/MainNavigation_view.dart';
import '../view/Login_view.dart';

class LoginController extends GetxController {
  LoginView? view;
  static LoginController instance = Get.find();
  late Rx<User?> _user;

  User? get user => _user.value;
  bool isLoging = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late TextEditingController emailID = TextEditingController();
  late TextEditingController passwordID = TextEditingController();

  doLogin() async {
    var email = Input.get("email");
    var password = Input.get("password");

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAll(const MainNavigationView());
    } on Exception catch (_) {
      Get.snackbar(
        "Failed",
        "Wrong username or password",
      );
    }
  }

  loginSubmit() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailID.text,
        password: passwordID.text,
      );
      //----->
      Get.offAll(const MainNavigationView());
    } on Exception catch (_) {
      Get.snackbar("Gagal", "Periksa Email & Password Kembali");
    }
  }

  void googleLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    isLoging = true;

    try {
      googleSignIn.disconnect();
    } catch (e) {}

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleSignInAccount.authentication;
        final crendentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        Get.offAll(const MainNavigationView());
        await auth.signInWithCredential(crendentials);
        getSuccessSnackBar("Successfully logged in as ${_user.value!.email}");
      }
    } on FirebaseAuthException catch (e) {
      getErrorSnackBar("Google Login Failed", e);
    } on PlatformException catch (e) {
      getErrorSnackBar("Google Login Failed", e);
    }
  }

  getErrorSnackBar(String message, _) {
    Get.snackbar(
      "Error",
      "$message\n${_.message}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  getErrorSnackBarNew(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  getSuccessSnackBar(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }
}
