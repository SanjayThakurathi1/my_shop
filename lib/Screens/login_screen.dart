import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/WelcomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "WELCOME TO MYSHOP",
          style: TextStyle(
              color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            color: Colors.lightBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Text(
              "User?",
              style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            onPressed: () {},
          ),
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            color: Colors.lightBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Text(
              "Retailer?",
              style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
