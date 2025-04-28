import 'dart:convert';
import 'dart:typed_data';

import 'package:prodajanekretnina_mobile/providers/base_provider.dart';
import 'package:prodajanekretnina_mobile/models/status.dart';

class StatusProvider extends BaseProvider<Status> {
  StatusProvider() : super("Status");

  @override
  Status fromJson(data) {
    // TODO: implement fromJson
    return Status.fromJson(data);
  }
}
