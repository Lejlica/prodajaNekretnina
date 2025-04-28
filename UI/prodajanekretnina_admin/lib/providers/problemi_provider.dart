import "package:flutter/material.dart";
import "package:prodajanekretnina_admin/models/problemi.dart";
import "package:prodajanekretnina_admin/providers/base_provider.dart";

class ProblemProvider extends BaseProvider<Problem> {
  ProblemProvider() : super("Problem");

  @override
  Problem fromJson(data) {
    // TODO: implement fromJson
    return Problem.fromJson(data);
  }
}
