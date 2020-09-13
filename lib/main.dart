import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:my_shop/Screens/Scaffoldscreen.dart';
import 'package:my_shop/Screens/productdetail.dart';
import 'package:my_shop/provider/cart.dart';
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
              ChangeNotifierProvider.value(value: Cart())
            ],
            child: MaterialApp(
              theme: ThemeData(
                  primarySwatch: Colors.lightBlue,
                  accentColor: Colors.deepOrange,
                  fontFamily: 'Lato'),
              title: "MyShop",
              home: Scaffoldscreen(),
              routes: {ProductDetail.routeName: (context) => ProductDetail()},
            ),
          );
  }
}
