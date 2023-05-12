import 'package:flutter/material.dart';
import 'package:flutter_flavors/flavor.config.dart';
import 'package:flutter_flavors/main_common.dart';

void main() {
  mainCommon(
    FlavorConfig(
      appTitle: 'AKASO',
      imageLocation: '',
      theme: ThemeData.dark(),
    ),
  );
}
