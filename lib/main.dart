import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:my_shop/Screens/login_screen.dart';
import 'package:my_shop/Screens/termandcondition.dart';
import 'package:my_shop/provider/auth_user.dart';
import 'package:my_shop/Screens/4.1%20auth_screen.dart.dart';
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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        //    Platform.isIOS
        //     ? ChangeNotifierProvider(
        //         create: (_) =>
        //             ProductProvider(), //if the data doesnt depand on context then  we can use _or the alternative is value
        //         child: CupertinoApp(
        //           title: "MyShop",
        //           theme: CupertinoThemeData(primaryColor: Colors.lightBlue),
        //           home: Scaffoldscreen(),
        //         ),
        //       )
        //     :
        MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),

        ChangeNotifierProxyProvider<Auth, ProductProvider>(
            create: null,
            update: (ctx, auth, pp) => ProductProvider(
                auth.userId, pp == null ? [] : pp.items, auth.tokens)),

        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: null,
            update: (ctx, auth, order) => Orders(
                order == null ? [] : order.orderlist,
                auth.tokens,
                auth.userId)),

        //ChangeNotifierProvider.value(value: Orders()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.lightBlue,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          title: "MyShop",
          home: auth.isAuth
              ? Scaffoldscreen()
              : FutureBuilder(
                  future: auth.tryautologin(),
                  builder: (context, authresultsnapshot) =>
                      authresultsnapshot.connectionState ==
                              ConnectionState.waiting
                          ? CircularProgressIndicator()
                          : AuthScreen()),
          // home: Scaffoldscreen(),
          routes: {
            ProductDetail.routeName: (context) => ProductDetail(),
            CartScreen.routeName: (context) => CartScreen(),
            OrderScreen.routeName: (context) => OrderScreen(),
            UserProductScreen.routeName: (context) => UserProductScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
            WelcomeScreen.routeName: (context) => WelcomeScreen(),
            Termandcondition.routeName: (context) => Termandcondition(),
          },
        ),
      ),
    );
  }
}
