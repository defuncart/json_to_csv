import 'dart:io';

import 'package:json_to_csv/json_to_csv.dart';

import 'utils/yaml_parser.dart';

void main() {
  final settings = YamlParser.packageSettingsFromPubspec();
  if (settings == null) {
    print('Error! Settings for json_to_csv not found in pubspec.');
    exit(0);
  }

  JsonCSVConverter.generate(settings);
}
