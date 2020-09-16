import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:my_shop/Screens/Scaffoldscreen.dart';
import 'package:my_shop/Screens/cart_screen.dart';
import 'package:my_shop/Screens/edit_product_screen.dart';
import 'package:my_shop/Screens/order_screen.dart';
import 'package:my_shop/Screens/productdetail.dart';
import 'package:my_shop/Screens/user_product_screen.dart';
import 'package:my_shop/provider/cart.dart';
import 'package:my_shop/provider/orders.dart';
import 'package:my_shop/provider/product_provider.dart';

import 'package:provider/provider.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? ChangeNotifierProvider(
            create: (_) =>
                ProductProvider(), //if the data doesnt depand on context then  we can use _or the alternative is value
            child: CupertinoApp(
              title: "MyShop",
              theme: CupertinoThemeData(primaryColor: Colors.lightBlue),
              home: Scaffoldscreen(),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: ProductProvider(),
              ),
              ChangeNotifierProvider.value(value: Cart()),
              ChangeNotifierProvider.value(value: Orders()),
            ],
            child: MaterialApp(
              theme: ThemeData(
                  primarySwatch: Colors.lightBlue,
                  accentColor: Colors.deepOrange,
                  fontFamily: 'Lato'),
              title: "MyShop",
              home: Scaffoldscreen(),
              routes: {
                ProductDetail.routeName: (context) => ProductDetail(),
                CartScreen.routeName: (context) => CartScreen(),
                OrderScreen.routeName: (context) => OrderScreen(),
                UserProductScreen.routeName: (context) => UserProductScreen(),
                EditProductScreen.routeName: (context) => EditProductScreen()
              },
            ),
          );
  }
}
