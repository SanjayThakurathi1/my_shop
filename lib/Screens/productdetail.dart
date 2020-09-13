import 'package:flutter/material.dart';
import 'package:my_shop/provider/product_provider.dart';

import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/productDetail';
  @override
  Widget build(BuildContext context) {
    String productid = ModalRoute.of(context).settings.arguments as String;
    final loadedproducts = Provider.of<ProductProvider>(context, listen: false)
        .getProductById(productid);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(loadedproducts.title ?? ""),
      ),
    );
  }
}
