import 'package:flutter/material.dart';
import 'package:flutter_hyper_ui/core.dart';
import 'package:flutter_hyper_ui/shared/widget/button/button.dart';
import 'package:flutter_hyper_ui/shared/widget/radio/radio.dart';

import 'package:get/get.dart';

class PosCheckoutView extends StatelessWidget {
  const PosCheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PosCheckoutController>(
      init: PosCheckoutController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Checkout"),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // nampilin list product untuk pembayaran
                  Expanded(
                    child: Container(
                        child: ListView.builder(
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        var item = controller.products[index];
// menjumlahkan product  antara jumlah dan harga
                        var total = double.parse(item["qty"].toString()) *
                            double.parse(item["price"]);

                        // jangan lupa kasih row sebagai dalamanya
                        return Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: Colors.grey[400]!.withOpacity(0.4),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                // deklarasi algoritma produk
                                child: Text("${item["product_name"]}"),
                              ),
                              Text("${item["qty"]} x \$${item["price"]}"),
                              const SizedBox(
                                width: 20.0,
                              ),
                              SizedBox(
                                width: 60.0,
                                child: Text(
                                  "\$$total",
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                  ),
                  // total keseluruhan pembelian
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "\$${controller.orderTotal}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  //body
                  // membuat payment method
                  const ExRadio(
                    id: "payment_method",
                    label: "Payment Method",
                    items: [
                      {
                        "label": "Cash",
                        "value": "Cash",
                      },
                      {
                        "label": "Gopay",
                        "value": "Gopay",
                      },
                      {
                        "label": "Ovo",
                        "value": "Ovo",
                      },
                      {
                        "label": "Bank Transfer",
                        "value": "Bank Transfer",
                      },
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ExButton(
                    label: "Checkout",
                    onPressed: () => controller.doCheckout(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
