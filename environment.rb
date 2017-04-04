lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'wr_api'
require 'rubygems'
require 'bundler'

Bundler.setup(:default, WrApi.env.to_sym)

initializers = [
  "active_support",
  "active_model_serializers",
  "logger",
  "sequel",
]

initializers_path = File.expand_path("../config/initializers", __FILE__)

initializers.each do |initializer|
  require "#{ initializers_path }/#{ initializer }"
end
