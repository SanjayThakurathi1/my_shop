import 'package:flutter/foundation.dart';
import 'package:my_shop/provider/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> cartitems;
  final DateTime date;
  OrderItem(
      {@required this.amount,
      @required this.date,
      @required this.id,
      @required this.cartitems});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orderlist = [];

  List<OrderItem> get orderlist {
    return [..._orderlist];
  }

  void addOrder(List<CartItem> cartitem, double total) {
    _orderlist.insert(
        0,
        OrderItem(
            amount: total,
            date: DateTime.now(),
            id: DateTime.now().toString(),
            cartitems: cartitem));
    //adding order to the begining

    notifyListeners();
  }
}
