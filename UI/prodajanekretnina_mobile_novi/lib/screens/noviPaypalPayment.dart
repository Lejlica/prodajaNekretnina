import 'dart:core';
import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:prodajanekretnina_mobile_novi/screens/noviPaypal.dart';
import 'package:url_launcher/url_launcher.dart';


class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  final Function(String url) onCheckoutUrlGenerated;

  PaypalPayment({required this.onFinish,required this.onCheckoutUrlGenerated});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var checkoutUrl;
  var executeUrl;
  var accessToken;
  
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });

          if (checkoutUrl != null) {
            widget.onCheckoutUrlGenerated(checkoutUrl);
          }
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
              Navigator.pop(context);
            },
          ),
        );
        // ignore: deprecated_member_use
        // _scaffoldKey.currentState!.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  String itemName = 'iPhone X';
  String itemPrice = '1.99';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"]
      }
    ];

    // checkout invoice details
    String totalAmount = '1.99';
    String subTotalAmount = '1.99';
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Gulshan';
    String userLastName = 'Yadav';
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName + " " + userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
     
    return temp;
    
  }
@override
  Widget build(BuildContext context) {
    print("checkout $checkoutUrl");

    // Ako checkout URL nije prazan, pokreni checkout proces
    if (checkoutUrl.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.open_in_browser),
              onPressed: () async {
                // Otvorimo checkout URL u vanjskom pregledniku
                if (await canLaunch(checkoutUrl)) {
                  await launch(checkoutUrl);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ne mogu otvoriti URL')),
                  );
                }
              },
            ),
          ],
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      // Ako checkout URL nije dostupan, prikazuj indikator učitavanja
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
      
    }
    
  }

  // Ovdje obradite povratne URL-ove pomoću deep linking-a
  Future<void> handleRedirect(String url) async {
    // Provjeri da li je URL povratak ili otkazivanje
    if (url.contains(returnURL)) {
      final uri = Uri.parse(url);
      final payerID = uri.queryParameters['PayerID'];
      if (payerID != null) {
        // Pozovi uslugu za izvršenje plačanja
        services
            .executePayment(executeUrl, payerID, accessToken)
            .then((id) {
          widget.onFinish(id); // Pozivamo callback funkciju s ID-om
          Navigator.of(context).pop();
        });
      } else {
        Navigator.of(context).pop(); // Ako nije PayerID, vraćamo
      }
    } else if (url.contains(cancelURL)) {
      // Ako korisnik otkaže, zatvori ekran
      Navigator.of(context).pop();
    }
   
  }
  
  /*late WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    print("checkout ${checkoutUrl}");

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          //backgroundColor: Theme.of(context).appBarTheme.color,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.open_in_browser),
              onPressed: () {
                // Dodajte logiku za otvaranje checkout-a ovde
                launch(checkoutUrl); // Ovde koristimo url_launcher paket
              },
            ),
          ],
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }*/
}
