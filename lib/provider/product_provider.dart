import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:my_shop/provider/product.dart';
import 'package:http/http.dart' as https;

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  //var _showFavouriteOnly = false;
  List<Product> get items {
    // if (_showFavouriteOnly) {
    //   return _items
    //       .where((element) => element.favourite)
    //       .toList(); //if fav= true the the element is added int o list//if we use this approach it  creates probs in future
    // }
    return [..._items];
    //it return copy of items.. All the object in flutter are reference type
  }

  List<Product> get favProduct {
    return _items.where((element) => element.favourite).toList();
  }

  // void showfavouriteonly() {
  //   _showFavouriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouriteOnly = false;
  //   notifyListeners();
  // }

  Product getProductById(String id) {
    return _items.firstWhere(
      (element) => element.id == id,
      orElse: () => null,
    );
  }

  Future<void> addProduct(Product product) {
    const url = 'https://myshop-7287e.firebaseio.com/products';
    return https
        .post(url,
            body: json.encode({
              'title': product.title,
              'price': product.price,
              'description': product.description,
              'imgUrl': product.imageUrl,
              'isFavourite': product.favourite,
            }))
        .then((response) {
      //print(json.decode(response.body)['name']);
      _items.add(Product(
          id: json
              .decode(response.body)['name'], //unique id generated by server
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          title: product.title));
      notifyListeners();
    }).catchError((error) {
      throw error;
    }); //we cant pass product directly here

    // _items.insert(0, Product(id: null, description: null, price: null, imageUrl: null, title: null)) if want to insert at first
  }

  void updateProduct(String id, Product product) {
    final prodindex = _items.indexWhere((prod) => prod.id == id);
    if (prodindex > 0) {
      _items[prodindex] = product;
    }
    notifyListeners();
  }

  void deleteproduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
