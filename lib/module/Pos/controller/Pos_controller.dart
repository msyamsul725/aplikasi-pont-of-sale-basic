import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../view/Pos_view.dart';

class PosController extends GetxController {
  PosView? view;
  // semua data produk
  List products = [];

  @override
  void onInit() async {
    super.onInit();
    await loadData();
  }

  loadData() async {
    var snapshot =
        await FirebaseFirestore.instance.collection("products").get();

    for (var doc in snapshot.docs) {
      var d = doc.data();
      products.add({
        "id": doc.id,
        "photo": d["photo"],
        "product_name": d["product_name"],
        "price": d["price"],
        "description": d["description"],
      });
    }

    update();
  }
}
