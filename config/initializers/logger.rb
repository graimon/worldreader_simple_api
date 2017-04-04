level = WrApi.production? ? Logger::INFO : Logger::DEBUG

require 'logger'

log_path = File.expand_path("../../../log", __FILE__)
log_file = "#{log_path}/#{WrApi.env}.log"

$logger = Logger.new(log_file)
$logger.level = level
