import 'dart:io';

import 'package:json_to_csv/json_to_csv.dart' show Settings;
import 'package:yaml/yaml.dart';

/// A class of arguments which the user can specify in pubspec.yaml
class YamlArguments {
  static const filesPath = 'files_path';
  static const mainFile = 'main_file';
  static const outputFile = 'output_file';
  static const csvDelimiter = 'csv_delimiter';
}

/// A class which parses yaml
class YamlParser {
  /// The path to the pubspec file path
  static const pubspecFilePath = 'pubspec.yaml';

  /// The section id for package settings in the yaml file
  static const yamlPackageSectionId = 'json_to_csv';

  /// Returns the package settings from pubspec
  static Settings? packageSettingsFromPubspec() {
    final yamlMap = _packageSettingsAsYamlMap();
    if (yamlMap != null) {
      final filesPath = yamlMap[YamlArguments.filesPath];
      if (filesPath == null) {
        print('Error! files not defined!');
        exit(0);
      }

      final mainFile = yamlMap[YamlArguments.mainFile];
      if (mainFile == null) {
        print('Error! mainFile not defined!');
        exit(0);
      }

      final outputFile = yamlMap[YamlArguments.outputFile];
      if (outputFile == null) {
        print('Error! outputFile not defined!');
        exit(0);
      }

      return Settings(
        pathToFiles: filesPath,
        pathToMainFile: mainFile,
        outputFilepath: outputFile,
        csvDelimiter: yamlMap[YamlArguments.csvDelimiter] ?? ';',
      );
    }

    return null;
  }

  /// Returns the package settings from pubspec as a yaml map
  static Map<dynamic, dynamic>? _packageSettingsAsYamlMap() {
    final file = File(pubspecFilePath);
    final yamlString = file.readAsStringSync();
    final Map<dynamic, dynamic> yamlMap = loadYaml(yamlString);
    return yamlMap[yamlPackageSectionId];
  }
}
