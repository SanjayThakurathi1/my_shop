import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_shop/Screens/cart_screen.dart';
import 'package:my_shop/Screens/productdetail.dart';
import 'package:my_shop/provider/cart.dart';
import 'package:my_shop/provider/product.dart';

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
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 29,
                    ),
                    onPressed: () {
                      showSearch(context: context, delegate: Productsearch());
                    }),
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

class Productsearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // final producttag =
    //     Provider.of<ProductProvider>(context, listen: false).items;

    return Center(
      child: Text("No Result Found"),
    );
    // : ListView.builder(
    //     itemCount: producttag.length,
    //     itemBuilder: (context, index) => GestureDetector(
    //         onTap: () {
    //           Navigator.pushNamed(context, ProductDetail.routeName,
    //               arguments: producttag[index].id);
    //         },
    //         child: ListTile(
    //             title: Text(producttag
    //                 .where((element) =>
    //                     element.title.toLowerCase().contains(query))
    //                 .toList()
    //                 .toString()))));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final producttag =
        Provider.of<ProductProvider>(context, listen: false).items;
    final recentproducts =
        Provider.of<ProductProvider>(context, listen: false).favProduct;

    List<Product> suggestionproduct = query.isEmpty
        ? recentproducts
        : producttag
            .where((element) => element.title.toLowerCase().contains(query))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          // showResults(context);
          Navigator.pushNamed(context, ProductDetail.routeName,
              arguments: suggestionproduct[index].id);
          query = suggestionproduct[index].title;
        },
        trailing: Image.network(suggestionproduct[index].imageUrl),
        title:
            //Text(suggestionproduct[index].price.toString()),
            RichText(
                text: TextSpan(
                    text: suggestionproduct[index]
                        .title
                        .toLowerCase()
                        .substring(0, query.length),
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                    children: [
              TextSpan(
                  text: suggestionproduct[index].title.substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ])),
      ),
      itemCount: suggestionproduct.length,
    );
  }
}
