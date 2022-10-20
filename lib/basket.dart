import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provicerproject/item.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class sepetim extends StatefulWidget {
  sepetim({super.key});

  @override
  State<sepetim> createState() => _sepetimState();
}

class _sepetimState extends State<sepetim> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, Item item, widget) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
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
        body: Column(
          children: [
            SizedBox(
              width: 100.w,
              height: 85.h,
              child: item.basket.isEmpty
                  ? Center(
                      child: Text(
                      "Emtpy!",
                      style: TextStyle(fontSize: 24),
                    ))
                  : ListView.builder(
                      itemCount: item.basket.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background:Container(color: Colors.white) ,
                          onDismissed: (direction) {
                            item.removeBasket(index);
                          },
                          key: UniqueKey(),
                          child: Container(
                              padding: EdgeInsets.only(left: 1.h, right: 1.h),
                              alignment: Alignment.centerLeft,
                              height: 10.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  color: Colors.black, border: Border.all(color: Colors.grey)),
                              child: Row(
                                children: [
                                  Container(
                                    height: 8.h,
                                    width: 8.h,
                                    child: FancyShimmerImage(
                                        height: 10.h,
                                        width: 8.h,
                                        boxFit: BoxFit.cover,
                                        imageUrl: item.basket[index]["image"]),
                                  ),
                                  Text(item.basket[index]["id"].toString(),style: TextStyle(color: Colors.white),),
                                  Spacer(),
                                  InkWell(
                                      onTap: () {
                                        item.removeBasket(index);
                                      },
                                      child: Icon(Icons.delete_forever,color: Colors.white,)),
                                ],
                              )),
                        );
                      },
                    ),
            ),
            InkWell(
              
              onTap: () {
                if (item.deleted_item.isNotEmpty) {
                  item.addBasket(item.deleted_item);
                  item.removeDeletedItem();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    border: item.deleted_item.isNotEmpty ? Border.all(color: Colors.grey.withOpacity(0.5)) : null,
                    borderRadius: BorderRadius.circular(1.h)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.deleted_item.isNotEmpty
                        ? item.deleted_item["id"] + " removed, click to undo"
                        : "",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),  
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
