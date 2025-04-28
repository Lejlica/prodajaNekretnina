import 'package:prodajanekretnina_admin/models/nekretninaAgenti.dart';
import 'package:prodajanekretnina_admin/providers/base_provider.dart';

class NekretninaAgentiProvider extends BaseProvider<NekretninaAgenti> {
  NekretninaAgentiProvider() : super("NekretninaAgenti");

  @override
  NekretninaAgenti fromJson(data) {
    // TODO: implement fromJson
    return NekretninaAgenti.fromJson(data);
  }
}
