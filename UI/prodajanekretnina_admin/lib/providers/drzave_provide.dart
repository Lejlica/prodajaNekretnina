import 'package:prodajanekretnina_admin/models/drzave.dart';
import 'package:prodajanekretnina_admin/providers/base_provider.dart';

class DrzaveProvider extends BaseProvider<Drzava> {
  DrzaveProvider() : super("Drzava");

  @override
  Drzava fromJson(data) {
    // TODO: implement fromJson
    return Drzava.fromJson(data);
  }
}
