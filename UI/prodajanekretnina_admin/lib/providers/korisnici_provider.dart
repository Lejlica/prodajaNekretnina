import "package:prodajanekretnina_admin/models/korisnici.dart";
import "package:prodajanekretnina_admin/providers/base_provider.dart";

class KorisniciProvider extends BaseProvider<Korisnik> {
  KorisniciProvider() : super("Korisnici");

  @override
  Korisnik fromJson(data) {
    // TODO: implement fromJson
    return Korisnik.fromJson(data);
  }
}
