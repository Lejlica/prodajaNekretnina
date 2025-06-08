import "package:prodajanekretnina_mobile_novi/models/nekretnine.dart";
import "package:prodajanekretnina_mobile_novi/providers/base_provider.dart";

class NekretnineeProvider extends BaseProvider<Nekretnina> {
  NekretnineeProvider() : super("Nekretnine");

  @override
  Nekretnina fromJson(data) {
    // TODO: implement fromJson
    return Nekretnina.fromJson(data);
  }
}