import 'package:prodajanekretnina_mobile_novi/models/korisnici.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PaymentCanceledPage extends StatefulWidget {
  Korisnik user;
  PaymentCanceledPage({super.key, required this.user});

  @override
  State<PaymentCanceledPage> createState() => _PaymentCanceledPageState();
}

class _PaymentCanceledPageState extends State<PaymentCanceledPage> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 2, 89, 1.0),
        foregroundColor: Colors.white,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
        title: Center(
          child: Text(
            'Payment was interrupted',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
            'Payment was not successful, it was either cancelled or error occured.',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.black),
          ),
      ));}
}