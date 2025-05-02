import "package:prodajanekretnina_admin/models/obilazak.dart";
import "package:prodajanekretnina_admin/providers/base_provider.dart";

class ObilazakProvider extends BaseProvider<Obilazak> {
  ObilazakProvider() : super("Obilazak");

  @override
  Obilazak fromJson(data) {
    // TODO: implement fromJson
    return Obilazak.fromJson(data);
  }
}
