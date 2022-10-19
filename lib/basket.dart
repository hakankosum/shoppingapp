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
        appBar: AppBar(
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
              height: 80.h,
              child: item.basket.isEmpty
                  ? Center(
                      child: Text(
                      "Emtpy!",
                      style: TextStyle(fontSize: 24),
                    ))
                  : ListView.builder(
                      itemCount: item.basket.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.only(left: 1.h, right: 1.h),
                            margin: EdgeInsets.only(bottom: 1.h),
                            alignment: Alignment.centerLeft,
                            height: 10.h,
                            width: 100.w,
                            color: Colors.blue,
                            child: Row(
                              children: [
                                Container(
                                  height: 8.h,
                                  width: 8.h,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              item.basket[index]["image"]))),
                                ),
                                Text(item.basket[index]["id"].toString()),
                                Spacer(),
                                InkWell(
                                    onTap: () {
                                      item.removeBasket(index);
                                    },
                                    child: Icon(Icons.remove_circle)),
                              ],
                            ));
                      },
                    ),
            ),
            InkWell(
                onTap: () {
                  if (item.deleted_item.isNotEmpty){
                    item.addBasket(item.deleted_item);
                    item.removeDeletedItem();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(border:item.deleted_item.isNotEmpty? Border.all():null,
                  borderRadius: BorderRadius.circular(1.h)
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item.deleted_item.isNotEmpty
                        ? item.deleted_item["id"] + " removed, click to undo"
                        : "",style: TextStyle(color: Colors.black,fontSize: 16),),
                  ),
                ),
                
                    )
          ],
        ),
      );
    });
  }
}
