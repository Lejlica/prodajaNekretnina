import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prodajanekretnina_admin/models/obilazak.dart';
import 'package:prodajanekretnina_admin/models/search_result.dart';
import 'package:prodajanekretnina_admin/screens/glavni_ekran.dart';
import 'package:prodajanekretnina_admin/providers/obilazak_provider.dart';
import 'package:prodajanekretnina_admin/screens/zahtjevi_za_obilazak_detalji.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ZahtjeviZaObilazakScreen extends StatefulWidget {
  Obilazak? obilazak;
  ZahtjeviZaObilazakScreen({Key? key, this.obilazak}) : super(key: key);

  @override
  State<ZahtjeviZaObilazakScreen> createState() =>
      _ZahtjeviZaObilazakScreenState();
}

class _ZahtjeviZaObilazakScreenState extends State<ZahtjeviZaObilazakScreen> {
  late ObilazakProvider _obilazakProvider;
  SearchResult<Obilazak>? result;
 
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _obilazakProvider = context.read<ObilazakProvider>();
    print(_obilazakProvider);
  }

  @override
void initState() {
  super.initState();
  _obilazakProvider = ObilazakProvider();
  _onRefresh(); // pozivaš API ili postavljaš početne vrijednosti
}

  FutureOr<void> _onRefresh() async {
    var data = await _obilazakProvider.get(filter: {});
    setState(() {
      result = data;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Zahtjevi za obilascima",
      child: Container(
        child: Column(children: [_buildSearch(), _buildDataListView()]),
      ),
    );
  }


bool isOdobrenaChecked = false;
Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        width: 1000,
        height: 80,
        padding: const EdgeInsets.all(16.0),
        child: Row(
  mainAxisAlignment: MainAxisAlignment.start, 
  children: [
    Checkbox(
      value: isOdobrenaChecked,
      onChanged: (value) {
        setState(() {
          isOdobrenaChecked = value!;
        });
      },
    ),
    const Text("Odobrena"),
    const SizedBox(width: 10), 
    ElevatedButton(
      onPressed: () async {
        var data = await _obilazakProvider.get(
          filter: {
            'isOdobren': isOdobrenaChecked,
          },
        );

        setState(() {
          result = data;
        });
      },
      child: const Text("Pretraži"),
    ),
  ],
),

      ),
    );
  }
  Widget _buildDataListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        showCheckboxColumn: false,
          columns: const [
            DataColumn(
              label: Expanded(
                child: Text(
                  'ID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Vrijeme obilaska',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Nekretnina ID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
                      label: Text(
                        'Odobren',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
          ],
          rows: result?.result
                  .map((Obilazak e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ZahtjeviZaObilazakDetaljiScreen(
                                          obilazak: e,
                                        ),
                                      ),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.obilazakId?.toString() ?? "")),
                            DataCell(Text(
                        
                        DateFormat('dd.MM.yyyy HH:mm')
                            .format(DateTime.parse(e.vrijemeObilaska?.toString() ?? "")) +
                            "h",
                      ),),
                            DataCell(Text(e.nekretninaId?.toString() ?? "")),
                            DataCell(
                              Icon(
                                e.isOdobren == true
                                    ? Icons.check
                                    : Icons.access_time,
                                color: e.isOdobren == true
                                    ? Colors.green
                                    : Colors.orange,
                                size: 24,
                              ),
                            ),
                          ]))
                  .toList() ??
              []),
    );
  }
}

