import 'package:flutter/material.dart';
//import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:prodajanekretnina_mobile/providers/korisnici_provider.dart';
import 'dart:developer';
import 'package:prodajanekretnina_mobile/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:prodajanekretnina_mobile/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late KorisniciProvider _userProvider = KorisniciProvider();

  bool isPayed = false;
  String make = "";

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<KorisniciProvider>();
  }

  void alertBox(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /*@override
  Widget build(BuildContext context) {
    make = AppLocalizations.of(context)!.purchase;
    return Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.payment),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))),
        body: Center(
          child: isPayed == true
              ? Text(
                  AppLocalizations.of(context)!.su_payed,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )
              : ElevatedButton.icon(
                  icon: const Icon(Icons.paypal),
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(0, 48, 135, 1)),
                  onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              HttpOverrides.global = MyHttpOverrides();
                              return UsePaypal(
                                  sandboxMode: true,
                                  clientId:
                                      'AZkL37Viqql10TlDRH-phzZyRO-5CzaQ_tX4gidYXEbRF-sJS2S0nZ60q-CtSPG3sgR4d7mYKyV99Oh4',
                                  secretKey:
                                      'EIDWu9u9z122pgdaN9JOsLelVZsdZb5k0knNWHVh_xt_6EFJRpuL6CnmFibS51s3-QcZ1PiEqaBkAqSW',
                                  returnURL: "https://samplesite.com/return",
                                  cancelURL: "https://samplesite.com/cancel",
                                  transactions: const [
                                    {
                                      "amount": {
                                        "total": '10.12',
                                        "currency": "USD",
                                        "details": {
                                          "subtotal": '10.12',
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },
                                      "description":
                                          "The payment transaction description.",
                                      "item_list": {
                                        "items": [
                                          {
                                            "name": "eLibary Membership",
                                            "quantity": 1,
                                            "price": '10.12',
                                            "currency": "USD"
                                          }
                                        ],
                                      }
                                    }
                                  ],
                                  note:
                                      "Contact us for any questions on your order.",
                                  onSuccess: (Map params) async {
                                    try {
                                      // Dodaj ovdje bilo koje druge akcije koje želiš izvršiti nakon uspješnog plaćanja.
                                      // Na primjer, možeš prikazati poruku o uspješnom plaćanju ili izvršiti određene promjene u aplikaciji.
                                      print("success");
                                      if (mounted) {
                                        setState(() {
                                          isPayed = true;
                                        });
                                      }
                                    } on Exception catch (e) {
                                      // Obradi greške ako su potrebne.
                                      // TODO
                                    }
                                    //Authorization.username = null;
                                    // Authorization.password = null;
                                  },
                                  onError: (error) {},
                                  onCancel: (params) {
                                    alertBox(
                                        context,
                                        AppLocalizations.of(context)!.error,
                                        AppLocalizations.of(context)!
                                            .cancel_payment);
                                  });
                            },
                          ),
                        )
                      },
                  label: Text(
                    make,
                    style: const TextStyle(fontSize: 18),
                  )),
        ));
  }*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaymentDemoApp',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PaypalCheckoutView(
                  sandboxMode: true,
                  clientId:
                      "ATK0JSyRAbys9cOlLdJD7dOD2VO0gG_BmGCCyI5hXJKiJ8R8voykKUx3y8knkC8s8JNkVNuahVKXybeQ",
                  secretKey:
                      "EHgWlt_b_1cHhuM1JQtX-z0RzWOxTqS6qN2uoppq6kabAff2wZwiz9F5RqJQ0QFL1H4K9C7Uc5jalzKw",
                  transactions: const [
                    {
                      "amount": {
                        "total": '70',
                        "currency": "USD",
                        "details": {
                          "subtotal": '70',
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description": "The payment transaction description.",
                      // "payment_options": {
                      //   "allowed_payment_method":
                      //       "INSTANT_FUNDING_SOURCE"
                      // },
                      "item_list": {
                        "items": [
                          {
                            "name": "Apple",
                            "quantity": 4,
                            "price": '5',
                            "currency": "USD"
                          },
                          {
                            "name": "Pineapple",
                            "quantity": 5,
                            "price": '10',
                            "currency": "USD"
                          }
                        ],

                        // shipping address is not required though
                        //   "shipping_address": {
                        //     "recipient_name": "Raman Singh",
                        //     "line1": "Delhi",
                        //     "line2": "",
                        //     "city": "Delhi",
                        //     "country_code": "IN",
                        //     "postal_code": "11001",
                        //     "phone": "+00000000",
                        //     "state": "Texas"
                        //  },
                      }
                    }
                  ],
                  note: "Contact us for any questions on your order.",
                  onSuccess: (Map params) async {
                    log("onSuccess: $params");
                    Navigator.pop(context);
                  },
                  onError: (error) {
                    log("onError: $error");
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    print('cancelled:');
                    Navigator.pop(context);
                  },
                ),
              ));
            },
            child: const Text('Pay with paypal'),
          ),
        ),
      ),
    );
  }
}
