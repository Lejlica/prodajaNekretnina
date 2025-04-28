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
  TextEditingController _nekretninaIdController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _obilazakProvider = context.read<ObilazakProvider>();
    print(_obilazakProvider);
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

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "ID nekretnine"),
              controller: _nekretninaIdController,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                print("login proceed");
                // Navigator.of(context).pop();

                var data = await _obilazakProvider.get(filter: {
                  'nekretninaId': _nekretninaIdController.text,
                });

                setState(() {
                  result = data;
                });

                // print("data: ${data.result[0].naziv}");
              },
              child: Text("Pretraga")),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          columns: [
            const DataColumn(
              label: Expanded(
                child: Text(
                  'ID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Vrijeme obilaska',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Nekretnina ID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
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
                            DataCell(Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                                .format(DateTime.parse(
                                    e.vrijemeObilaska?.toString() ?? "")))),
                            DataCell(Text(e.nekretninaId?.toString() ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
