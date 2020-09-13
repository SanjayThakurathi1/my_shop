import 'package:flutter/foundation.dart'; //for required properties

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

  void favtoggle() {
    favourite = !favourite;
    notifyListeners();
  }
}
