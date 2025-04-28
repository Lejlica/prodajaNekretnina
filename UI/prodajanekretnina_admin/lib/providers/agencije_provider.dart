import 'package:prodajanekretnina_admin/models/agencija.dart';
import 'package:prodajanekretnina_admin/providers/base_provider.dart';

class AgencijaProvider extends BaseProvider<Agencija> {
  AgencijaProvider() : super("Agencija");

  @override
  Agencija fromJson(data) {
    // TODO: implement fromJson
    return Agencija.fromJson(data);
  }
}
