import 'package:prodajanekretnina_admin/models/gradovi.dart';
import 'package:prodajanekretnina_admin/providers/base_provider.dart';

class GradoviProvider extends BaseProvider<Grad> {
  GradoviProvider() : super("Grad");

  @override
  Grad fromJson(data) {
    // TODO: implement fromJson
    return Grad.fromJson(data);
  }
}
