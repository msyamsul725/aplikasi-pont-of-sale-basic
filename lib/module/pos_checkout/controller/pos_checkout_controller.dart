import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hyper_ui/core.dart';
import 'package:get/get.dart';
import '../../../shared/util/input/input.dart';

class PosCheckoutController extends GetxController {
  PosCheckoutView? view;

// variabel tersebut akan mengambil nama product yang mempunyai jumlah lebih dari nol
  List products = [];

  @override
  void onInit() {
    super.onInit();
    // ambil list product dari halaman sebelumnya
    PosController posController = Get.find();
    products = posController.products
        .where((i) => i["qty"] != null && i["qty"] > 0)
        .toList();
  }

  // menjumlahkan semua pembelian product
  double get orderTotal {
    var _orderTotal = 0.0;
    for (var product in products) {
      _orderTotal += product["qty"] * double.parse(product["price"]);
    }
    return _orderTotal;
  }

  doCheckout() async {
    var paymentMethod = Input.get("payment_method");
    await FirebaseFirestore.instance.collection("order").add({
      "created_at": Timestamp.now(),
      "payment_method": paymentMethod,
      "item": products,
      "total": orderTotal,
    });
    Get.offAll(const DashboardView());
  }
}
