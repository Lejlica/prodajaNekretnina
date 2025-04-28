import 'package:prodajanekretnina_admin/models/lokacije.dart';
import 'package:prodajanekretnina_admin/providers/base_provider.dart';

class LokacijeProvider extends BaseProvider<Lokacija> {
  LokacijeProvider() : super("Lokacija");

  @override
  Lokacija fromJson(data) {
    // TODO: implement fromJson
    return Lokacija.fromJson(data);
  }
}
