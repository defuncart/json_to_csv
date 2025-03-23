import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../models/settings.dart';

class JsonCSVConverter {
  JsonCSVConverter._();

  static Future<void> generate(Settings settings) async {
    final dir = Directory(settings.pathToFiles);
    if (!await dir.exists()) {
      print('Directory ${settings.pathToFiles} does not exist. Exiting.');
      exit(0);
    }

    final files = (await dir.list().toList()).whereType<File>().where((file) => p.extension(file.path) == '.json');
    if (files.isEmpty) {
      print('No json files found at ${settings.pathToFiles}. Exiting');
      exit(0);
    }

    final mainFile = File(settings.pathToMainFile);
    if (!await mainFile.exists()) {
      print('Main file mainFile does not exist. Exiting.');
      exit(0);
    }

    final remainingFiles = files.where((file) => file.path != mainFile.path);

    final mainFileJson = await _readJsonFile(mainFile.path);
    final remainingFilesJson = await _readJsonFiles(remainingFiles.map((file) => file.path));

    final sb = StringBuffer();
    sb.write('key');
    sb.write(settings.csvDelimiter);
    sb.write(p.basenameWithoutExtension(mainFile.path));
    sb.write(settings.csvDelimiter);
    for (final (index, file) in remainingFiles.indexed) {
      sb.write(p.basenameWithoutExtension(file.path));
      // do not add delimited after final column
      if (index < remainingFiles.length - 1) {
        sb.write(settings.csvDelimiter);
      }
    }
    sb.writeln();

    for (final kvp in mainFileJson.entries) {
      final key = kvp.key;
      sb.write(key);
      sb.write(settings.csvDelimiter);
      sb.write(kvp.value);
      sb.write(settings.csvDelimiter);
      for (final (index, json) in remainingFilesJson.indexed) {
        if (json.containsKey(key)) {
          sb.write(json[key]);
          // do not add delimited after final column
          if (index < remainingFilesJson.length - 1) {
            sb.write(settings.csvDelimiter);
          }
        }
      }
      sb.writeln();
    }

    final outputFile = File(settings.outputFilepath);
    if (!await outputFile.exists()) {
      await outputFile.create(recursive: true);
    }
    await outputFile.writeAsString(sb.toString());
  }

  static Future<Map<String, dynamic>> _readJsonFile(String filepath) async {
    final input = await File(filepath).readAsString();
    return jsonDecode(input);
  }

  static Future<List<Map<String, dynamic>>> _readJsonFiles(Iterable<String> filepaths) async {
    final returnValue = <Map<String, dynamic>>[];
    for (final filepath in filepaths) {
      returnValue.add(await _readJsonFile(filepath));
    }
    return returnValue;
  }
}
