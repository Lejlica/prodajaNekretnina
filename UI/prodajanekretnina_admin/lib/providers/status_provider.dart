
import 'package:prodajanekretnina_admin/providers/base_provider.dart';
import 'package:prodajanekretnina_admin/models/status.dart';

class StatusProvider extends BaseProvider<Status> {
  StatusProvider() : super("Status");

  @override
  Status fromJson(data) {
    // TODO: implement fromJson
    return Status.fromJson(data);
  }
}
