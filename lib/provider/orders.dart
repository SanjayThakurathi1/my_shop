import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_shop/provider/cart.dart';
import 'package:http/http.dart' as https;

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
  final String _token;
  final String _userId;
  Orders(this._orderlist, this._token, this._userId);

  List<OrderItem> get orderlist {
    return [..._orderlist];
  }

  String get userId {
    return _userId;
  }

  Future<void> fetchAndSetOrder() async {
    final url =
        'https://myshop-7287e.firebaseio.com/orders/$userId.json?auth=$_token';

    try {
      final response = await https.get(url);
      print(jsonDecode(response.body));
      List<OrderItem> orderitem = [];
      var jsondata = json.decode(response.body) as Map<String, dynamic>;
      if (jsondata == null) {
        return; //terminate the fxn if this condn matches
      }
      jsondata.forEach((key, orderitems) {
        orderitem.add(OrderItem(
            amount: orderitems['totalAmount'],
            date: DateTime.parse(orderitems['dateTime']),
            id: key,
            cartitems: (orderitems['cartItems'] as List<dynamic>)
                .map((cart) => CartItem(
                    id: cart['id'],
                    price: cart['price'],
                    quantity: cart['quantity'],
                    title: cart['title']))
                .toList()));
      });
      _orderlist = orderitem.reversed.toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addOrder(List<CartItem> cartitem, double total) async {
    final url =
        'https://myshop-7287e.firebaseio.com/orders/$userId.json?auth=$_token';
    final timeStamp = DateTime.now();
    try {
      final response = await https.post(url,
          body: jsonEncode({
            'cartItems': cartitem
                .map((cartitems) => {
                      'id': cartitems.id,
                      'title': cartitems.title,
                      'quantity': cartitems.quantity,
                      'price': cartitems.price
                    })
                .toList(),
            'totalAmount': total,
            'dateTime': timeStamp.toIso8601String()
          }));
      print(jsonDecode(response.body));

      _orderlist.insert(
          0,
          OrderItem(
              amount: total,
              date: timeStamp,
              id: jsonDecode(response.body)['name'],
              cartitems: cartitem));
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
    //adding order to the begining
  }
}
