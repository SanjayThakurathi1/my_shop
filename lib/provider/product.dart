import 'dart:convert';

import 'package:flutter/foundation.dart'; //for required properties
import 'package:http/http.dart' as https;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  bool favourite;

  Product(
      {@required this.id, //names argunebt with{}
      @required this.description,
      this.favourite = false,
      @required this.price,
      @required this.imageUrl,
      @required this.title});

  void _setfavValue(bool newValue) {
    favourite = newValue;
    notifyListeners();
  }

  Future<void> favtoggle() async {
    final oldStatus = favourite;
    favourite = !favourite;
    final url = 'https://myshop-7287e.firebaseio.com/products/$id.json';
    try {
      final response =
          await https.patch(url, body: jsonEncode({'isFavourite': favourite}));
      if (response.statusCode >= 400) {
        // favourite = oldStatus;
        _setfavValue(oldStatus);
      }
      notifyListeners();
    } catch (e) {
      _setfavValue(oldStatus);
    }
  }
}
