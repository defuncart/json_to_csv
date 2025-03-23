import 'dart:io';

import 'package:args/args.dart';
import 'package:json_to_csv/json_to_csv.dart';

import 'utils/yaml_parser.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addSeparator('A tool to convert multiple json files to csv.')
    ..addFlag('help', abbr: 'h', negatable: false, defaultsTo: false, help: 'Displays help.')
    ..addSeparator('')
    ..addOption('files_path', help: 'A path to folder containing json files.')
    ..addOption('main_file', help: 'A path to folder containing main json file (i.e. en.json).')
    ..addOption('output_file', help: 'A path to save the generated csv file.')
    ..addOption('csv_delimiter', help: 'A delimiter to separate columns in the input CSV file. Defaults to `;`.');

  Settings? settings;
  try {
    final args = parser.parse(arguments);

    if (args['help']) {
      print(parser.usage);
      exit(0);
    } else {
      final filesPath = args['files_path'];
      final mainFile = args['main_file'];
      final outputFile = args['output_file'];
      final csvDelimiter = args['csv_delimiter'];

      if (filesPath != null && mainFile != null && outputFile != null) {
        settings = Settings(
          pathToFiles: filesPath,
          pathToMainFile: mainFile,
          outputFilepath: outputFile,
          csvDelimiter: csvDelimiter,
        );
      }
    }
  } on FormatException catch (e) {
    print(e.message);
    exit(0);
  }

  Settings? settingsFromYaml;
  try {
    settingsFromYaml = YamlParser.packageSettingsFromPubspec();
  } catch (_) {
    // settings could not be parsed from pubspec - do nothing as tool may be used as cli
  }

  if (settings == null && settingsFromYaml == null) {
    print('Error! Settings for json_to_csv neither supplied via cli nor found in pubspec.');
    exit(0);
  }

  if (settings != null && settingsFromYaml != null) {
    print('Warning! Setting defined via cli and in pubspec, cli has priority.');
  }

  JsonCSVConverter.generate(settings ?? settingsFromYaml!);
}
