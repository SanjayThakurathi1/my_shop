import 'package:flutter/material.dart';
import 'package:my_shop/provider/orders.dart' show Orders;
import 'package:my_shop/widgets/drawer.dart';
import 'package:my_shop/widgets/orderitem_widget.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order_screen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _orderloading = false;
  @override
  void initState() {
    setState(() {
      _orderloading = true;
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
      setState(() {
        _orderloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order"),
      ),
      drawer: Draweer(),
      body: _orderloading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: order.orderlist.length,
              itemBuilder: (context, index) => Orderitem(
                orderItem: order.orderlist[index],
              ),
            ),
    );
  }
}
