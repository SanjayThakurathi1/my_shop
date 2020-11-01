import 'package:flutter/material.dart';
import 'package:my_shop/Screens/4.1%20auth_screen.dart.dart';
import 'package:my_shop/Screens/order_screen.dart';
import 'package:my_shop/Screens/user_product_screen.dart';
import 'package:my_shop/provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../provider/auth_user.dart';

class Draweer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hey Friends!"),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            trailing: Icon(Icons.expand_more),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Product"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              // Navigator.pop(context);
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed('/');
              // Navigator.pushNamed(context, AuthScreen.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
