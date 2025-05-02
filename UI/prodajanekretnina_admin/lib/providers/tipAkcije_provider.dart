import "package:prodajanekretnina_admin/models/tipAkcije.dart";
import "package:prodajanekretnina_admin/providers/base_provider.dart";

class TipAkcijeProvider extends BaseProvider<TipAkcije> {
  TipAkcijeProvider() : super("TipAkcije");

  @override
  TipAkcije fromJson(data) {
    // TODO: implement fromJson
    return TipAkcije.fromJson(data);
  }
}
