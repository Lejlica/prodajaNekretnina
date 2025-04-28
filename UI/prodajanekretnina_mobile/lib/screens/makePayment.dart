import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prodajanekretnina_mobile/screens/noviPaypalPayment.dart';
import 'package:url_launcher/url_launcher.dart';

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
                'Paypal Payment Example',
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
                /*ElevatedButton(
                  onPressed: () {
                    // make PayPal payment

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PaypalPayment(
                          onFinish: (number) async {
                            // payment done
                            print('order id: ' + number);
                          },
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Pay with Paypal',
                    textAlign: TextAlign.center,
                  ),
                ),*/
                ElevatedButton(
                  onPressed: () {
                    launch(
                        "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-2E5829364T6502018");
                  },
                  child: Text("Plati koristeci paypal"),
                )
              ],
            ),
          )),
    );
  }
}
