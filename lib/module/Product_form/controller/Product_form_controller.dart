import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../shared/util/input/input.dart';
import '../view/Product_form_view.dart';

class ProductFormController extends GetxController {
  ProductFormView? view;

  doSave() async {
    var photo = Input.get("photo");
    var productName = Input.get("product_name");
    var price = Input.get("price");
    var description = Input.get("description");

    await FirebaseFirestore.instance.collection("products").add({
      "photo": photo,
      "product_name": productName,
      "price": price,
      "description": description,
    });

    Get.back();
  }
}
