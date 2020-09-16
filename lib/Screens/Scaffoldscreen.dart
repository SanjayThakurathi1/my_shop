import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_shop/Screens/cart_screen.dart';
import 'package:my_shop/provider/cart.dart';

import 'package:my_shop/provider/product_provider.dart';
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
  var _isinit = true;
  var _loadingproduct = false;
  @override
  void initState() {
    //.of(context) things dont work in initstate
    //oneway is
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductProvider>(context, listen: false).fetchAndSetProduct();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _loadingproduct = true;
    });
    if (_isinit) {
      Provider.of<ProductProvider>(context, listen: false)
          .fetchAndSetProduct()
          .then((_) {
        setState(() {
          _loadingproduct = false;
        });
      });
    }
    setState(() {
      _isinit = false;
    });
    super.didChangeDependencies();
  }

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
            body: _loadingproduct
                ? Center(
                    child: Image.asset("Assets/ripple.gif"),
                  )
                : HomeScreen(
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
