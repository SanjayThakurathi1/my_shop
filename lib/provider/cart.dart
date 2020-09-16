import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  CartItem(
      {@required this.id,
      @required this.price,
      @required this.quantity,
      @required this.title});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartitems = {};

  int get itemcount {
    return _cartitems.length;
  }

  double get totalsumofproduct {
    var total = 0.0;
    _cartitems.forEach((key, cartitem) {
      total = total + cartitem.quantity * cartitem.price;
    });

    return total;
  }

  Map<String, CartItem> get cartitems {
    return {..._cartitems}; //added to new map to return a copy
  }

  void additem(
    String productid,
    String title,
    double price,
  ) {
    if (_cartitems.containsKey(productid)) {
      _cartitems.update(
          productid,
          (existingCartitem) => CartItem(
              id: existingCartitem.id,
              price: existingCartitem.price,
              quantity: existingCartitem.quantity + 1,
              title:
                  existingCartitem.title)); //we r updating our map of cart item
    } else {
      _cartitems.putIfAbsent(
          productid,
          () => CartItem(
              id: DateTime.now().toString(),
              price: price,
              quantity: 1,
              title: title));
      //this is added to a map
    }

    notifyListeners();
  }

  void deleteitemfromcart(String productId) {
    _cartitems.remove(productId);
    notifyListeners();
  }

  void deletesingleitemfromcart(String productId) {
    if (!_cartitems.containsKey(productId)) {
      return; //it just cancel the execution of function if it doesnot contain
    }
    if (_cartitems[productId].quantity > 1) {
      _cartitems.update(
          productId,
          (existingcartitem) => CartItem(
              id: existingcartitem.id,
              price: existingcartitem.price,
              quantity: existingcartitem.quantity - 1,
              title: existingcartitem.title));
    } else {
      _cartitems.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartitems = {};
    notifyListeners();
  }
}
