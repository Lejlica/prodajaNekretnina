import "package:prodajanekretnina_admin/models/kategorijeNekretnina.dart";
import "package:prodajanekretnina_admin/providers/base_provider.dart";

class KategorijeNekretninaProvider extends BaseProvider<KategorijaNekretnine> {
  KategorijeNekretninaProvider() : super("Kategorija");

  @override
  KategorijaNekretnine fromJson(data) {
    // TODO: implement fromJson
    return KategorijaNekretnine.fromJson(data);
  }
}
