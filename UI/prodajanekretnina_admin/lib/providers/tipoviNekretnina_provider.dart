import 'package:prodajanekretnina_admin/models/tipoviNekretnina.dart';
import 'package:prodajanekretnina_admin/providers/base_provider.dart';

class TipoviNekretninaProvider extends BaseProvider<TipNekretnine> {
  TipoviNekretninaProvider() : super("Tip");

  @override
  TipNekretnine fromJson(data) {
    // TODO: implement fromJson
    return TipNekretnine.fromJson(data);
  }
}
