import 'package:flutter/material.dart';
import 'package:my_shop/provider/orders.dart' show Orders;
import 'package:my_shop/widgets/drawer.dart';
import 'package:my_shop/widgets/orderitem_widget.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order_screen';
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order"),
      ),
      drawer: Draweer(),
      body: ListView.builder(
        itemCount: order.orderlist.length,
        itemBuilder: (context, index) => Orderitem(
          orderItem: order.orderlist[index],
        ),
      ),
    );
  }
}
