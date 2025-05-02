import "package:prodajanekretnina_admin/models/nekretninaTipAkcije.dart";
import "package:prodajanekretnina_admin/providers/base_provider.dart";

class NekretninaTipAkcijeProvider extends BaseProvider<NekretninaTipAkcije> {
  NekretninaTipAkcijeProvider() : super("NekretninaTipAkcije");

  @override
  NekretninaTipAkcije fromJson(data) {
    // TODO: implement fromJson
    return NekretninaTipAkcije.fromJson(data);
  }
}
