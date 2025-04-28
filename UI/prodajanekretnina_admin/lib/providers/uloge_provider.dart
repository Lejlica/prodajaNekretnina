import "package:flutter/material.dart";
import "package:prodajanekretnina_admin/models/uloge.dart";
import "package:prodajanekretnina_admin/providers/base_provider.dart";

class UlogeProvider extends BaseProvider<Uloge> {
  UlogeProvider() : super("Uloge");

  @override
  Uloge fromJson(data) {
    // TODO: implement fromJson
    return Uloge.fromJson(data);
  }
}
