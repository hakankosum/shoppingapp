import 'dart:core';
import 'dart:math';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provicerproject/item.dart';
import 'package:provicerproject/basket.dart';

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dart:convert';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List _products = [];

  Future<void> readJson() async {
    final String res = await rootBundle.loadString("assets/items.json");
    final itemsData = await json.decode(res);
    _products = itemsData["data"];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => readJson());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, Item item, widget) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Container(
                margin: EdgeInsets.only(right: 5.w),
                child: Center(
                    child: Text(
                  "Total: " + item.summ.toString(),
                  style: TextStyle(fontSize: 3.h,color: Colors.black),
                )))
          ],
        ),
        body: SizedBox(
            height: 90.h,
            width: 100.w,
            child: _products.length > 0
                ? Container(
                    height: 80.h,
                    child: GridView.builder(
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 15.h,
                            padding: EdgeInsets.only(right: 5.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 2.h),
                                  height: 10.h,
                                  width: 10.h,
                                  child: FancyShimmerImage(
                                    shimmerDuration:
                                        const Duration(milliseconds: 1000),
                                    boxFit: BoxFit.cover,
                                    width: 8.h,
                                    height: 10.h,
                                    imageUrl: _products[index]["image"],
                                    errorWidget: const Image(
                                        image: NetworkImage(
                                            "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Text(
                                        _products[index]["id"],
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.black,overflow: TextOverflow.fade),
                                      ),
                                      Text(
                                        _products[index]["price"].toString() +
                                            " TL",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          highlightColor: Colors.black,
                                          onTap: () {
                                            item.addBasket(_products[index]);
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(top: 2.h),
                                              decoration: BoxDecoration(
                                                 
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Icon(
                                                Icons
                                                    .add_shopping_cart_outlined,
                                                size: 24,
                                                color: Colors.black,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                    ),
                  )
                : null),
        bottomNavigationBar: Container(
          height: 10.h,
          width: 100.w,
          child: Container(
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => sepetim()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (Text(
                        "Go to Basket",
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      )),
                      SizedBox(
                        width: 3.w,
                      ),
                      Icon(
                        Icons.shopping_cart_checkout,
                        color: Colors.black,
                      )
                    ],
                  ))),
        ),
      );
    });
  }
}
