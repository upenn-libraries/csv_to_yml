## README for `csv_to_yml`

This is a Ruby script that generates YML files from CSV inputs.  These YML files can be used on their own or as part of workflows involving the [todo_runner](https://github.com/upenn-libraries/todo_runner) gem.  

## Requirements

* Ruby 2.3.0 or higher
* A CSV file that complies with the CSV requirements outlined below

## CSV requirements

This script makes the following assumptions about the CSV input it recieves:

* It is formatted horizontally, with the data for one YML file per row.
* The first row is a row of headers used to populate the YML file.
* There is a column called `id` (case insensitive), which contains unique values to be used as the filename for the YML file.

### Usage

The first argument is the CSV file input, the second argument is the desired file extension for the outputted YML files, and the third argument is the absolute or relative path on the filesystem where the files should be created. 

#### Examples

To make standard YML files:

```bash
ruby csv_to_yml.rb input_file.csv yml destination/
```

To make todo_runner-compliant YML files:

```bash
ruby csv_to_yml.rb input_file.csv todo destination/
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/upenn-libraries/csv_to_yml](https://github.com/upenn-libraries/csv_to_yml).

## License

This code is available as open source under the terms of the [Apache 2.0 License](https://opensource.org/licenses/Apache-2.0).