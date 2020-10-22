import 'package:flutter/material.dart';
import 'package:my_shop/provider/orders.dart' show Orders;
import 'package:my_shop/widgets/drawer.dart';
import 'package:my_shop/widgets/orderitem_widget.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order_screen';

//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//
  // @override
  // void initState() {
  //   setState(() {
  //     _orderloading = true;
  //   });
  //   Future.delayed(Duration.zero).then((_) {
  //     Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
  //     setState(() {
  //       _orderloading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final order = Provider.of<Orders>(context);
    print("building orders");

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order"),
      ),
      drawer: Draweer(),
      body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.error != null) {
              return Center(
                child: Text("An Error Occured"),
              );
            } else
              return Consumer<Orders>(
                builder: (context, order, child) => ListView.builder(
                  itemCount: order.orderlist.length,
                  itemBuilder: (context, index) => Orderitem(
                    orderItem: order.orderlist[index],
                  ),
                ),
              );
          }),
    );
  }
}
