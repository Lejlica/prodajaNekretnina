import 'dart:convert';
import 'dart:typed_data';

import 'package:prodajanekretnina_admin/providers/base_provider.dart';
import 'package:prodajanekretnina_admin/models/slike.dart';

class SlikeProvider extends BaseProvider<Slika> {
  SlikeProvider() : super("Slike");

  @override
  Slika fromJson(data) {
    // TODO: implement fromJson
    return Slika.fromJson(data);
  }
}
