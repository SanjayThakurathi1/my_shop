import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/Screens/productdetail.dart';
import 'package:my_shop/provider/product.dart';

import 'package:provider/provider.dart';
import '../provider/cart.dart';

class ProductItems extends StatelessWidget {
  //static const routeName = '/productitem';
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItems({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final productloading = Provider.of<Product>(context,
        listen: false); //if i do this the build will not run
    final cartt = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          footer: GridTileBar(
              leading: Consumer<Product>(
                builder: (context, toglevalue, child) => IconButton(
                    icon:
                        //using here a consumer widget we just want to rebuild this part only

                        Icon(
                      toglevalue.favourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 30,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      toglevalue.favtoggle();
                    }),
              ),
              trailing: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                  onPressed: () {
                    cartt.additem(
                      productloading.id,
                      productloading.title,
                      productloading.price,
                    );

                    //Scaffold.of(context).openDrawer();
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Added item to Cart",
                        textAlign: TextAlign.center,
                      ),
                      action: SnackBarAction(
                          label: "UNDO",
                          onPressed: () {
                            cartt.deletesingleitemfromcart(productloading.id);
                          }),
                    ));
                  }),
              backgroundColor: Colors.black87,
              title: Text(
                productloading.title ?? '',
                textAlign: TextAlign.center,
              )),
          header: Text(productloading.id ?? ""),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, ProductDetail.routeName,
                arguments: productloading.id),
            child: Image.network(
              productloading.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return Image.asset("Assets/spinner.gif");
                }

                return child;
              },
            ),
          )),
    );
  }
}
