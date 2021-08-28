import 'package:flutter/material.dart';
import 'package:my_shop/Screens/edit_product_screen.dart';
import 'package:my_shop/provider/product_provider.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  UserProductItem({this.title, this.imgUrl, this.id});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,
                      arguments:
                          id); //we have to pass id so that we know which we have to edit
                }),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .deleteproduct(id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Deleted Sucessfully"),
                  ));
                }),
          ],
        ),
      ), //it doesnttake widget sp
    );
  }
}
