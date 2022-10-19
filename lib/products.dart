import 'dart:core';

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
          leading: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sepetim()),
                );
              },
              child: Icon(Icons.shopping_basket)),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 5.w),
                child: Center(
                    child: Text(
                  "Total: " + item.summ.toString(),
                  style: TextStyle(fontSize: 3.h),
                )))
          ],
        ),
        body: SizedBox(
            height: 80.h,
            width: 100.w,
            child: _products.length > 0
                ? Container(
                    height: 80.h,
                    child: ListView.builder(
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.only(bottom: 1.h),
                            
                            height: 15.h,
                            color: Colors.blue,
                            padding: EdgeInsets.only(right: 5.w),
                            child: Row(
                              
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 2.h),
                                  

                                  height: 10.h,
                                  width: 10.h,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              _products[index]["image"]),fit: BoxFit.cover)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _products[index]["id"],
                                        style:
                                            const TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        _products[index]["price"].toString() +
                                            " TL",
                                        style:
                                            const TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    highlightColor: Colors.white,
                                    
                                    onTap: () {
                                      item.addBasket(_products[index]);
                                      
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)
                                      
                                      ),
                                      child: Icon(Icons.shopping_cart_outlined,size: 24,)),
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                  )
                :null),
      );
    });
  }
}
