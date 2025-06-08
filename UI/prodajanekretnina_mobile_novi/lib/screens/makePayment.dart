import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prodajanekretnina_mobile_novi/screens/noviPaypalPayment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class makePayment extends StatefulWidget {
  @override
  _makePaymentState createState() => _makePaymentState();
}

class _makePaymentState extends State<makePayment> {
  TextStyle style = TextStyle(fontFamily: 'Open Sans', fontSize: 15.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: new AppBar(
          backgroundColor: Colors.white,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Platite nekretninu koristeći PayPal',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Open Sans'),
              ),
            ],
          ),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
  onPressed: () {
    print("Pokrećem PaypalPayment i čekam URL...");

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalPayment(
          onFinish: (number) async {
            print('order id: ' + number);
          },
          onCheckoutUrlGenerated: (checkoutUrl) async {
            print("Dobijen checkout URL: $checkoutUrl");
            if (await canLaunch(checkoutUrl)) {
              await launch(checkoutUrl);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Ne mogu otvoriti PayPal URL")),
              );
            }
          },
        ),
      ),
    );
  },
  child: Text('Plati koristeći PayPal'),
),

              ],
            ),
          )),
    );
  }
}
