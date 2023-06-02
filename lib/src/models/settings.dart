class Settings {
  Settings({
    required this.pathToFiles,
    required this.pathToMainFile,
    required this.outputFilepath,
    this.csvDelimiter = ';',
  });

  /// The path to JSON files
  final String pathToFiles;

  /// The path to the main JSON file
  final String pathToMainFile;

  /// The output filepath
  final String outputFilepath;

  /// The CSV delimiter
  final String csvDelimiter;
}
