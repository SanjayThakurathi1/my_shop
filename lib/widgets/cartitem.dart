import 'package:flutter/material.dart';
import 'package:my_shop/provider/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String id;
  final String productid;
  final double price;
  final int quantity;
  CartItem({this.id, this.price, this.quantity, this.title, this.productid});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        child: Icon(
          Icons.delete,
          size: 40,
        ),
        color: Theme.of(context).errorColor,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are u Sure ?"),
                  content: Text("Do you want to remove from Cart "),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text("NO")),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text("YES")),
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).deleteitemfromcart(productid);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: FittedBox(
                    child: Text(
                  "  रू $price   ",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ))),
            title: Text("$title"),
            subtitle: Text('Total =${(price * quantity)}'),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
