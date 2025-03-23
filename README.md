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
    git:
      url: https://github.com/defuncart/json_to_csv
```

### Define Settings

Settings can either be defined as command line arguments or in `pubspec.yaml`.

| Setting            | Description                                                                 |
| ------------------ | ----------------------------------------------------------------------------|
| files_path         | A path to folder containing json files.                                     |
| main_file          | A path to folder containing main json file (i.e. en.json).                  |
| output_file        | A path to save the generated csv file.                                      |
| csv_delimiter      | A delimiter to separate columns in the input CSV file. Defaults to `;`.     |

#### Command Line Arguments

```sh
dart run json_to_csv --files_path="assets/json/" --main_file="assets/json/en.json" --output_file="assets/test.csv" --csv_delimiter=";"
```

#### pubspec.yaml

```yaml
json_to_csv:
  files_path: 'assets/json/'
  main_file: 'assets/json/en.json'
  output_file: 'assets/test.csv'
  csv_delimiter: ';'
```

### Run package

Ensure that your current working directory is the project root, then run the following command:

```sh
dart run json_to_csv
```

#### Global Activation

The package can be global activated and used as a cli tool as follows:

```sh
dart pub global activate -sgit https://github.com/defuncart/json_to_csv

json_to_csv --files_path="assets/json/" --main_file="assets/json/en.json" --output_file="assets/test.csv" --csv_delimiter=";"
```

The package can be deactivated as follows:

```sh
dart pub global deactivate json_to_csv
```

## Collaboration

Spotted any issues? Please open [an issue on GitHub](https://github.com/defuncart/json_to_csv/issues)! Would like to contribute a new feature? Fork the repo and submit a PR!
