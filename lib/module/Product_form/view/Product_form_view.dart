import 'package:flutter/material.dart';
import 'package:flutter_hyper_ui/shared/widget/image_picker/image_picker.dart';
import 'package:flutter_hyper_ui/shared/widget/textfield/textarea.dart';
import 'package:flutter_hyper_ui/shared/widget/textfield/textfield.dart';
import '../controller/Product_form_controller.dart';

import 'package:get/get.dart';

class ProductFormView extends StatelessWidget {
  const ProductFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductFormController>(
      init: ProductFormController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("ProductForm"),
            actions: [
              InkWell(
                  onTap: () => controller.doSave(),
                  child: const Padding(
                      padding: EdgeInsets.all(20.0), child: Text("Save"))),
            ],
          ),
          body: SingleChildScrollView(
            controller: ScrollController(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: const [
                  ExImagePicker(
                    id: "photo",
                    label: "Photo",
                  ),
                  ExTextField(
                    id: "product_name",
                    label: "Produt Name",
                  ),
                  ExTextField(
                    id: "price",
                    label: "Price",
                    keyboardType: TextInputType.number,
                    value: "0",
                  ),
                  ExTextArea(
                    id: "description",
                    label: "Description",
                  ),

                  //body
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
