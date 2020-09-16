import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_shop/Screens/cart_screen.dart';
import 'package:my_shop/provider/cart.dart';
import 'package:my_shop/widgets/badge.dart';
import 'package:my_shop/widgets/drawer.dart';
import 'package:provider/provider.dart';

import '../Screens/home_screen.dart';

enum filteroptions {
  favourite,
  all,
}

class Scaffoldscreen extends StatefulWidget {
  @override
  _ScaffoldscreenState createState() => _ScaffoldscreenState();
}

class _ScaffoldscreenState extends State<Scaffoldscreen> {
  bool favproducts = false;
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: Text("MyShop"),
              actions: [
                Consumer<Cart>(
                  builder: (_, cart, ch) => Badge(
                    child: ch,
                    value: cart.itemcount.toString(),
                    //amount of items in the cart
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      icon: Icon(Icons
                          .shopping_cart)), //here this iconbutton doesnt build again
                ),
                PopupMenuButton(
                    onSelected: (filteroptions selectedvalue) {
                      if (selectedvalue == filteroptions.favourite) {
                        setState(() {
                          favproducts = true;
                        });
                      } else if (selectedvalue == filteroptions.all) {
                        setState(() {
                          favproducts = false;
                        });
                      }
                    },
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (_) => [
                          PopupMenuItem(
                            child: Text("Only Favourites"),
                            value: filteroptions.favourite,
                          ),
                          PopupMenuItem(
                            child: Text("Show All"),
                            value: filteroptions.all,
                          )
                        ]),
              ],
              centerTitle: true,
            ),
            drawer: Draweer(),
            body: HomeScreen(
              favproduct: favproducts,
            ),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: Colors.lightBlue,
              middle: Text("MyShop"),
            ),
            child: HomeScreen(),
          );
  }
}
