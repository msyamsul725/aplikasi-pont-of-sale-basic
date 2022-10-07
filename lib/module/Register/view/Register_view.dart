import 'package:flutter/material.dart';
import '../../../shared/widget/button/button.dart';
import '../../../shared/widget/textfield/textfield.dart';
import '../../Login/view/Login_view.dart';
import '../controller/Register_controller.dart';

import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        controller.view = this;
        return Scaffold(
          backgroundColor: Colors.blueGrey[900],
          body: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const ExTextField(
                          id: "email",
                          label: "Email",
                        ),
                        const ExTextField(
                          id: "password",
                          label: "Password",
                          textFieldType: TextFieldType.password,
                        ),
                        ExButton(
                          label: "Register",
                          onPressed: () => controller.doRegister(),
                        ),
                        InkWell(
                          onTap: () => Get.to(const LoginView()),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Back to login"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
