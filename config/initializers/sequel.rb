require 'yaml'
require 'pg'
require 'sequel'

# Load configuration for the current environment
#
config_file = ::File.expand_path("../../database.yml" ,__FILE__)
config      = YAML.load_file(config_file)[WrApi.env]

# Set tenant resource to a global constant
database = Sequel.connect(config)
Object.const_set "DB", database

[:pg_array_ops, :pg_json_ops].each do |ext|
  Sequel.extension ext
end

[:pg_array, :pg_json].each do |ext|
  DB.extension ext
end