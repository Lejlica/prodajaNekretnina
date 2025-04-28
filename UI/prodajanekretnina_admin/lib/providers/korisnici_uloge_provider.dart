import 'package:prodajanekretnina_admin/models/korisnici_uloge.dart';
import 'package:prodajanekretnina_admin/providers/base_provider.dart';

class KorisniciUlogeProvider extends BaseProvider<KorisniciUloge> {
  KorisniciUlogeProvider() : super("KorisnikUloge");

  @override
  KorisniciUloge fromJson(data) {
    // TODO: implement fromJson
    return KorisniciUloge.fromJson(data);
  }
}
