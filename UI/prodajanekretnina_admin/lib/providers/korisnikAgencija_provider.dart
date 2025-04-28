import "package:prodajanekretnina_admin/models/korisnici.dart";
import "package:prodajanekretnina_admin/models/korisnikAgencija.dart";
import "package:prodajanekretnina_admin/providers/base_provider.dart";

class KorisnikAgencijaProvider extends BaseProvider<KorisnikAgencija> {
  KorisnikAgencijaProvider() : super("KorisnikAgencija");

  @override
  KorisnikAgencija fromJson(data) {
    // TODO: implement fromJson
    return KorisnikAgencija.fromJson(data);
  }
}
