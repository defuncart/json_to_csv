# json_to_csv

A tool to convert multiple json files to csv.

## Getting Started

Given json files of the form

```json
{
    "helloWorld": "Hello World!"
}
```

```json
{
    "helloWorld": "Hallo Welt!"
}
```

a csv file 

```csv
key;en;de;
helloWorld;Hello World!;Hallo Welt!;
```

is generated.

Note that the column headers `en`, `de` are automatically inferred from json basename.

### Add dependency

Firstly, add the package as a dev dependency:

```yaml   
dev_dependencies: 
  json_to_csv:
```

### Define Settings

Next define arb_generator package settings in `pubspec.yaml`.

```yaml
json_to_csv:
  files_path: 'assets/json/'
  main_file: 'assets/json/en.json'
  output_file: 'assets/test.csv'
  csv_delimiter: ';'
```

| Setting            | Description                                                                 |
| ------------------ | ----------------------------------------------------------------------------|
| files_path         | A path to folder containing json files.                                     |
| main_file          | A path to folder containing main json file (i.e. en.json).                  |
| output_file        | A path to save the generated csv file.                                      |
| csv_delimiter      | A delimiter to separate columns in the input CSV file. Defaults to `;`.     |

### Run package

Ensure that your current working directory is the project root. Depending on your project, run one of the following commands:

```sh
dart run json_to_csv
```

or

```sh
flutter pub run json_to_csv
```

## Collaboration

Spotted any issues? Please open [an issue on GitHub](https://github.com/defuncart/arb_generator/issues)! Would like to contribute a new language or feature? Fork the repo and submit a PR!