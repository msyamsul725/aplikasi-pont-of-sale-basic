import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hyper_ui/core.dart';

import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      _signOut().then((value) => Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => const LoginView())));
                    },
                    child: const Icon(Icons.highlight_off)),
              ),
            ],
            title: const Text("Dashboard"),
          ),
          body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Builder(
                  builder: (context) {
                    List items = [
                      {
                        "id": 1,
                        "photo":
                            "https://i.ibb.co/6NZ8dGk/Holiday-Travel-Agent-Promotion-Banner-Landscape.png",
                        "onTap": (item) {},
                      },
                      {
                        "id": 2,
                        "photo":
                            "https://i.ibb.co/5xfjdy9/Blue-Modern-Discount-Banner.png",
                        "onTap": (item) {},
                      },
                      {
                        "id": 3,
                        "photo":
                            "https://i.ibb.co/6Rvjyy1/Brown-Yellow-Free-Furniture-Promotion-Banner.png",
                        "onTap": (item) {},
                      }
                    ];

                    return SizedBox(
                      height: 120.0,
                      child: ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var item = items[index];
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              height: 100.0,
                              width: MediaQuery.of(context).size.width * 0.7,
                              margin: const EdgeInsets.only(right: 16.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    item["photo"],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Wrap(
                  children: [
                    InkWell(
                      onTap: () => Get.to(const ProductView()),
                      child: SizedBox(
                        width: (Get.width - 40) / 4,
                        child: Column(
                          children: [
                            Icon(
                              Icons.food_bank,
                              color: Colors.red[400],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Product",
                              style: TextStyle(
                                color: Colors.red[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(const OrderView()),
                      child: SizedBox(
                        width: (Get.width - 40) / 4,
                        child: Column(
                          children: [
                            Icon(
                              Icons.list,
                              color: Colors.purple[400],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Order",
                              style: TextStyle(
                                color: Colors.purple[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(const PosView()),
                      child: SizedBox(
                        width: (Get.width - 40) / 4,
                        child: Column(
                          children: [
                            Icon(
                              Icons.point_of_sale,
                              color: Colors.green[400],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "POS",
                              style: TextStyle(
                                color: Colors.green[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "New Product",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("products")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return const Text("Error");
                      if (snapshot.data == null) return Container();
                      if (snapshot.data!.docs.isEmpty) {
                        return const Text("No Data");
                      }
                      final data = snapshot.data!;
                      return ListView.builder(
                        itemCount: data.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var item = (data.docs[index].data() as Map);
                          item["id"] = data.docs[index].id;

                          return InkWell(
                            onTap: () => Get.to(DetailProductView(item: item)),
                            child: Container(
                              width: 160.0,
                              margin: const EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    item["photo"] ??
                                        "https://i.ibb.co/S32HNjD/no-image.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                color: Colors.blue[400],
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6.0),
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.green[800],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          12.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      item["price"],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8.0,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(16.0),
                                          bottomRight: Radius.circular(16.0),
                                        ),
                                      ),
                                      child: Text(
                                        item["product_name"],
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  width: MediaQuery.of(context).size.width,
                  child: const Text(
                    "Favorite Product",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 140.0,
                  child: ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 140,
                        margin: const EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=710&q=80",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                          color: Colors.blue[400],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6.0),
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.green[800],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    12.0,
                                  ),
                                ),
                              ),
                              child: const Text(
                                "PROMO",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.0,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16.0),
                                    bottomRight: Radius.circular(16.0),
                                  ),
                                ),
                                child: const Text(
                                  "Avocado and Eeg Toast",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
