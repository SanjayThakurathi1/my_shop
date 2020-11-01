import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_shop/provider/orders.dart';
import 'dart:math';

class Orderitem extends StatefulWidget {
  final OrderItem orderItem;
  Orderitem({this.orderItem});

  @override
  _OrderitemState createState() => _OrderitemState();
}

class _OrderitemState extends State<Orderitem> {
  bool expands = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: expands
          ? min(widget.orderItem.cartitems.length * 20.0 + 180, 320)
          : 110,
      duration: Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
      child: Card(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title: Text(widget.orderItem.amount.toString()),
              subtitle:
                  // Text(DateFormat('dd/mm/yyyy hh:mm').format(orderItem.date)),
                  Text(
                DateFormat.yMEd().add_jms().format(widget.orderItem.date),
              ),
              trailing: IconButton(
                  icon: Icon(expands ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      expands = !expands;
                    });
                  }),
            ),
            AnimatedContainer(
              duration: Duration(
                milliseconds: 300,
              ),
              curve: Curves.easeIn,
              height: expands
                  ? min(widget.orderItem.cartitems.length * 20.0 + 80, 320)
                  : 0,
              child: ListView(
                children: widget.orderItem.cartitems
                    .map((cartitemss) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(cartitemss.title ?? ''),
                            SizedBox(
                              height: 22,
                            ),
                            Text(cartitemss.price.toString() ?? ""),
                            SizedBox(
                              height: 22,
                            ),
                            Text('${cartitemss.quantity ?? ""}x'),
                          ],
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
