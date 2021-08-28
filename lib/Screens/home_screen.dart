//import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:my_shop/provider/product.dart';
import 'package:my_shop/provider/product_provider.dart';

import 'package:my_shop/widgets/productitem.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final bool favproduct;
  HomeScreen({this.favproduct});
  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<ProductProvider>(context);
    List<Product> loadedproduct = favproduct ? pp.favProduct : pp.items;
    return LayoutBuilder(
        builder: (context, constraint) => GridView.builder(
              itemCount: loadedproduct.length,
              padding: const EdgeInsets.all(
                  10), //keep it const so that while building widget it dont change
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraint.maxHeight > 900 ? 4 : 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 11,
                  mainAxisSpacing: 29),
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                //if it dont depand on context use .value or_
                value: loadedproduct[index],
                child: ProductItems(
                    //id: loadedproduct[index].id,
                    //title: loadedproduct[index].title,
                    //imageUrl: loadedproduct[index].imageUrl,
                    ),
              ),
            ));
  }
}
