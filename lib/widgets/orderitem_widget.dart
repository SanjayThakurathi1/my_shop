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
    return Card(
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
                icon: Icon(expands ? Icons.expand_more : Icons.expand_less),
                onPressed: () {
                  setState(() {
                    expands = !expands;
                  });
                }),
          ),
          if (expands)
            Container(
              height: min(widget.orderItem.cartitems.length * 20.0 + 100, 180),
              child: ListView(
                children: widget.orderItem.cartitems
                    .map((cartitemss) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(cartitemss.title ?? ''),
                            SizedBox(
                              height: 12,
                            ),
                            Text(cartitemss.price.toString() ?? ""),
                            SizedBox(
                              height: 12,
                            ),
                            Text('${cartitemss.quantity ?? ""}x'),
                          ],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
