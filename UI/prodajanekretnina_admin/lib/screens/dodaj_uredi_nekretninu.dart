// import 'dart:convert';

// import 'package:flutter/material.dart';

// class DodajUrediNekretninu extends StatefulWidget {
//   const DodajUrediNekretninu({Key? key}) : super(key: key);

//   @override
//   _DodajUrediNekretninuState createState() => _DodajUrediNekretninuState();
// }

// class _DodajUrediNekretninuState extends State<DodajUrediNekretninu> {
  
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dodaj/Uredi Nekretninu'),
//       ),
//       body: Row(children: [
//         Column(
          
//         children: [ 
//           Card(
//             child: Row(children: [
//               ValueListenableBuilder<String?>(
//           valueListenable: agentDropdownValue,
//           builder: (context, value, _) {
//             return DropdownButton<String>(
//               value: value,
//               hint: Text('Izaberi opciju'),
//               items: options.map((String opcija) {
//                 return DropdownMenuItem<String>(
//                   value: opcija,
//                   child: Text(opcija),
//                 );
//               }).toList(),
//               onChanged: (novaVrednost) {
//                 selectedValue.value = novaVrednost;
//               },
//             );
//           },
//         )
//             ],),
//           )
//         ],)
//       ],)
//     );
//   }
// }