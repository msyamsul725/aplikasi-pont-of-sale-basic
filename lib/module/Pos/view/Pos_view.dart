import 'package:flutter/material.dart';
import 'package:flutter_hyper_ui/core.dart';
import 'package:flutter_hyper_ui/shared/widget/button/button.dart';

import 'package:get/get.dart';

class PosView extends StatelessWidget {
  const PosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PosController>(
      init: PosController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Pos"),
          ),
          // buat tombol checkout
          bottomNavigationBar: Container(
            height: 110.0,
            padding: const EdgeInsets.all(20.0),
            child: ExButton(
              label: "Checkout",
              onPressed: () => Get.to(const PosCheckoutView()),
            ),
          ),
          //1.  buat dengan card " item_card"
          //2. bungkus dengan ListView cardnya
          //3. kasih padding
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                var item = controller.products[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      backgroundImage: NetworkImage(
                        item["photo"] ?? "https://i.ibb.co/QrTHd59/woman.jpg",
                      ),
                    ),
                    title: Text(item["product_name"]),
                    subtitle: Text(item["price"]),
                    trailing: SizedBox(
                      width: 120.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // control untuk mengurangi item
                          InkWell(
                            onTap: () {
                              // untuk mendeklarasikan apabila null
                              item['qty'] = item['qty'] ?? 0;
                              if (item["qty"] == 0) return;
                              item["qty"]--;
                              controller.update();
                            },
                            child: Card(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              // untuk mengisi jumlah quantity , apabila qty tidak ada maka harus
                              "${item["qty"] ?? 0}",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
// untuk mendeklarasikan apabila nilainya null
                              item["qty"] = item["qty"] ?? 0;
                              item["qty"]++;
                              controller.update();
                            },
                            child: Card(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
