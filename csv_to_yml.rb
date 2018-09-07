#!/usr/bin/ruby

require 'logger'
require 'smarter_csv'
require 'yaml'
require 'zaru'

def validate_args!
  raise ArgumentError.new('Please supply a CSV file') if ARGV[0].nil?
  raise ArgumentError.new('Please supply the desired file extension for output files') if ARGV[1].nil?
  raise ArgumentError.new('Please supply a destination directory') if ARGV[2].nil?
end

def create_yml_file(args = {}, file_ext, dest_dir)
  headers = args.keys
  todo_name = Zaru.sanitize!(args[:id].to_s)
  todo_path = File.join dest_dir, "#{todo_name}.#{file_ext.to_s}"
  data = headers.inject({}) { |h,header| h.merge(header => args[header]) }
  File.open(todo_path, 'w+') { |f| f.puts YAML::dump data }
  return "#{todo_name}.#{file_ext.to_s}"
end

validate_args!

file = ARGV[0]
file_ext = ARGV[1]
dest_dir = ARGV[2]

logger = Logger.new(STDOUT)
logger.level = Logger::INFO
logger.info('Make TODOs started')

csv_processed = SmarterCSV.process(file)

csv_processed.each do |row|
  raise Exception.new('Column named "id" is required for intended todo filename') if row[:id].nil?
  raise Exception.new('Duplicate values in id column; id values must be unique') if csv_processed.uniq { |e| e[:id] }.length != csv_processed.length
  todo_filename = create_yml_file(row, file_ext, dest_dir)
  logger.info("YML file #{todo_filename} created.")
end

logger.info("Make TODOs complete.  Files available at #{dest_dir}.")