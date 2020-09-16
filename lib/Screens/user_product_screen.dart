import 'package:flutter/material.dart';
import 'package:my_shop/Screens/edit_product_screen.dart';
import 'package:my_shop/provider/product_provider.dart';
import 'package:my_shop/widgets/user_product_items.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/user_product_screen";
  @override
  Widget build(BuildContext context) {
    final productitems = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yours Products"),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                //Navigator.of(context).pushNamed(EditProductScreen.routeName);
                Navigator.pushNamed(context, EditProductScreen.routeName);
              })
        ],
      ),
      drawer: Draweer(), //title and icon will not rebuilt
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: productitems.items.length,
              itemBuilder: (_, index) => UserProductItem(
                id: productitems.items[index].id,
                imgUrl: productitems.items[index].imageUrl,
                title: productitems.items[index].title,
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
