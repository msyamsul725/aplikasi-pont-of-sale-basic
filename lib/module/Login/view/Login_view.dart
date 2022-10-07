import 'package:flutter/material.dart';
import 'package:flutter_hyper_ui/core.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../shared/widget/button/button.dart';
import '../../../shared/widget/textfield/textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
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
                            "Login",
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
                          label: "Login",
                          onPressed: () => controller.doLogin(),
                        ),
                        InkWell(
                          onTap: () => Get.to(const RegisterView()),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Register"),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                                icon: const Icon(MdiIcons.google),
                                label: const Text("Google"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () => controller.googleLogin()),
                            const SizedBox(
                              width: 10.0,
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(MdiIcons.facebook),
                              label: const Text("Facebook"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        )
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
