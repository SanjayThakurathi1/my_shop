import 'package:flutter/material.dart';
import 'package:my_shop/provider/product_provider.dart';

import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = '/productDetail';
  @override
  Widget build(BuildContext context) {
    String productid = ModalRoute.of(context).settings.arguments as String;
    final loadedproducts = Provider.of<ProductProvider>(context, listen: false)
        .getProductById(productid);

    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(loadedproducts.title ?? ""),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Card(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    loadedproducts.title ?? "",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              background: Hero(
                tag: productid,
                child: Image.network(
                  loadedproducts.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return Image.asset("Assets/spinner.gif");
                    }
                    return child;
                  },
                ),
              ), //this is the part we see during expanding
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                    text: ' रू   ',
                    style: buildTextStyle()
                        .copyWith(color: Colors.black, fontSize: 22),
                    children: [
                      TextSpan(
                          text: loadedproducts.price.toString() ?? '',
                          style:
                              buildTextStyle().copyWith(color: Colors.green)),
                      TextSpan(text: ' /-', style: buildTextStyle())
                    ]),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Card(
              color: Colors.grey,
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Description',
                        textAlign: TextAlign.center,
                        style: buildTextStyle()
                            .copyWith(fontSize: 25, color: Colors.black),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        loadedproducts.description ?? "",
                        textAlign: TextAlign.center,
                        style: buildTextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 800,
            ),
          ]) // this show how to render content
              ),
        ],
        // child: Column(
        //   children: [
        //     Container(
        //       height: 300,
        //       width: double.infinity,
        //       child:
        //     ),

        //   ],
        // ),
      ),
    );
  }

  TextStyle buildTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }
}
