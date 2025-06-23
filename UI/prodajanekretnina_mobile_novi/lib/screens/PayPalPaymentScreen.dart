import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:prodajanekretnina_mobile_novi/main.dart';
import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:prodajanekretnina_mobile_novi/models/nekretnine.dart';
import 'package:prodajanekretnina_mobile_novi/screens/payment_success_page.dart';
import 'package:prodajanekretnina_mobile_novi/screens/payment_canceled_page.dart';
import 'package:prodajanekretnina_mobile_novi/providers/kupovine_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPalPaymentScreen extends StatefulWidget {

  final double price;
  final Korisnik korisnik;
  final Nekretnina nekretnina;

  const PayPalPaymentScreen({
    super.key,
  
    required this.price,
    required this.korisnik,
    required this.nekretnina,
  });

  @override
  State<PayPalPaymentScreen> createState() => _PayPalPaymentScreenState();
}

class _PayPalPaymentScreenState extends State<PayPalPaymentScreen> {
  bool _cookiesCleared = false;
int? kupovinaId;
bool _kupovinaKreirana = false;

 final kupovinaProvider = KupovinaProvider();
  @override
  void initState() {
    print("Initializing PayPalPaymentScreen with korisnik: ${widget.korisnik.korisnikId}, nekretnina: ${widget.nekretnina.nekretninaId}, price: ${widget.price}");
    super.initState();
    _clearCookies();
    _createKupovina();
  }

  Future<void> _clearCookies() async {
    final cookieManager = WebViewCookieManager();
    await cookieManager.clearCookies();
    if (!mounted) return;
    setState(() {
      _cookiesCleared = true;
    });
  }
Future<void> _createKupovina() async {
   if (_kupovinaKreirana) return;  // Spreči ponovni poziv
  _kupovinaKreirana = true;
  if (widget.korisnik.korisnikId == null) {
    print("Error: korisnikId je null!");
    return;
  }
  if (widget.nekretnina.nekretninaId == null) {
    print("Error: nekretninaId je null!");
    return;
  }
  if (widget.price <= 0) {
    print("Error: cijena je manja ili jednaka 0!");
    return;
  }

  final kupovinaRequest = {
    "korisnikId": widget.korisnik.korisnikId,
    "nekretninaId": widget.nekretnina.nekretninaId,
    "price": widget.price,
    "isPaid": false,
    "isConfirmed": false,
    "payPalPaymentId": ""
  };

  try {
    var novaKupovina = await kupovinaProvider.insert(kupovinaRequest);
    kupovinaId = novaKupovina.kupovinaId; // Izvuci id iz objekta
    print('Kupovina kreirana s id: $kupovinaId');
    if (!mounted) return;
    setState(() {});
  } catch (e) {
    print('Greška pri kreiranju kupovine: $e');
  }
}




  @override
  Widget build(BuildContext context) {
    final completer = Completer<bool>();
   

    if (!_cookiesCleared || kupovinaId == null) {
  return const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}


    return Scaffold(
      appBar: AppBar(
        title: const Text('PayPal Payment'),
        backgroundColor: Colors.deepPurple,
      ),
      body: UsePaypal(
        sandboxMode: true,
        clientId: "ATK0JSyRAbys9cOlLdJD7dOD2VO0gG_BmGCCyI5hXJKiJ8R8voykKUx3y8knkC8s8JNkVNuahVKXybeQ",
  	secretKey: "EHgWlt_b_1cHhuM1JQtX-z0RzWOxTqS6qN2uoppq6kabAff2wZwiz9F5RqJQ0QFL1H4K9C7Uc5jalzKw",

        returnURL: "https://samplesite.com/return",
        cancelURL: "https://samplesite.com/cancel",
        transactions: [
          {
            "amount": {
              "total": widget.price.toStringAsFixed(2),
              "currency": "USD",
            },
            "description": "Payment for property purchase #${widget.nekretnina.nekretninaId}.",
            "item_list": {
              "items": [
                {
                  "name": "Nekretnina #${widget.nekretnina.nekretninaId}",
                  "quantity": 1,
                  "price": widget.price.toStringAsFixed(2),
                  "currency": "USD"
                }
              ]
            }
          }
        ],
        note: "Thank you for your purchase!",
        onSuccess: (params) async {
  final paymentId = params['paymentId'];
  print("paymentId: $paymentId");

  await kupovinaProvider.addPayPalPaymentId(widget.nekretnina.nekretninaId!, paymentId);

  if (!mounted) return;

  Navigator.of(context).pop(true); 
},

      
        onError: (error) {
          completer.complete(false);
          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PaymentCanceledPage(user: widget.korisnik),
            ),
          );
        },
        onCancel: (params) {
          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PaymentCanceledPage(user: widget.korisnik),
            ),
          );
        },
      ),
    );
  }
}
