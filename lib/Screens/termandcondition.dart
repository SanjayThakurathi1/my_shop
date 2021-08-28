import 'package:flutter/material.dart';

class Termandcondition extends StatelessWidget {
  static const routeName = "/termandCondation";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Terms and Conditions",
          style: TextStyle(
              color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  child: Text(
                    "Welcome to MyShop",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "These terms and conditions outline the rules and regulations for the use of App Name's MyShop",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "By accessing this website we assume you accept these terms and conditions. Do not continue to use Website Name if you do not agree to take all of the terms and conditions stated on this page.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  shadowColor: Colors.black,
                  child: Container(
                    child: Text(
                      "The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: “Client”, “You” and “Your” refers to you, the person log on this website and compliant to the Company's terms and conditions. “The Company”, “Ourselves”, “We”, “Our” and “Us”, refers to our Company. “Party”, “Parties”, or “Us”, refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client's needs in respect of provision of the Company's stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Shipping and Return policy",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    "you have to Contact yourself to the client but if u get difficulties then our team will help you",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    "Data Protection",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                Description(),
                Container(
                  child: Text(
                    "Data Protection",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "myshop will guarentee for your privacy",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
