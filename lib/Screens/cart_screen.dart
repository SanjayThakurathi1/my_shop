import 'package:flutter/material.dart';
import 'package:my_shop/provider/cart.dart' show Cart;
import 'package:my_shop/provider/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/cartitem.dart' as widgett;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart_screen';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 1.0,
                  ),
                  Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Chip(
                    label: Text(
                      "\रू   ${cart.totalsumofproduct.toStringAsFixed(2) ?? "Loading sum........"}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.cartitems.length,
            itemBuilder: (context, index) => widgett.CartItem(
                productid: cart.cartitems.keys.toList()[index],
                id: cart.cartitems.values.toList()[index].id,
                price: cart.cartitems.values.toList()[index].price,
                quantity: cart.cartitems.values.toList()[index].quantity,
                title: cart.cartitems.values.toList()[index].title),
          ))
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isloading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: (widget.cart.totalsumofproduct <= 0 || _isloading)
            ? null
            : () async {
                setState(() {
                  _isloading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.cartitems.values.toList(),
                    widget.cart.totalsumofproduct);
                setState(() {
                  _isloading = false;
                });
                widget.cart.clearCart();
              },
        child: _isloading ? CircularProgressIndicator() : Text("Order Now"));
  }
}
