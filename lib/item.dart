
import 'package:flutter/material.dart';

class Item with ChangeNotifier {
  List basket=[];
  
  double get summ=>getPrice();
  int index;
  final List<int> _cartCount;
  Item(this._cartCount,this.index);
  List<int> get cartCounts => _cartCount;
  Map<String, dynamic> deleted_item = {};
  set cartCount(int value) {
    _cartCount[index] = value;
  }

  void increase() {
    _cartCount[index]++;
    notifyListeners();
  }

  void decrease() {
    _cartCount[index]--;
    notifyListeners();
  }

  void addBasket(Object value) {
    basket.add(value);

    notifyListeners();
  }
  void removeBasket(value) {
    deleted_item=basket[value];

    
    basket.removeAt(value);
    print(deleted_item.toString());
    
    notifyListeners();
  }

  double getPrice(){
    double summ =0;
    for (var i=0;i<basket.length;i++){

      summ+=basket[i]["price"];
    }

    return summ;
  }

  void removeDeletedItem(){
    deleted_item={};
  }

}
