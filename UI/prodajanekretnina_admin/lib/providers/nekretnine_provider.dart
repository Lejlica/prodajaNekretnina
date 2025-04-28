import "package:prodajanekretnina_admin/models/nekretnine.dart";
import "package:prodajanekretnina_admin/providers/base_provider.dart";

class NekretnineProvider extends BaseProvider<Nekretnina> {
  NekretnineProvider() : super("Nekretnine");

  @override
  Nekretnina fromJson(data) {
    // TODO: implement fromJson
    return Nekretnina.fromJson(data);
  }
}
