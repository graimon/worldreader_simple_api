require 'grape'

module WrApi
  class Api < Grape::API
    autoload :V1, 'wr_api/api/v1'

    rescue_from :all do |error|
      header    = "============ Error ============"
      message   = "Message: #{error.message}"
      backtrace = "Backtrace: #{error.backtrace.join("\n")}"
      footer    = "==============================="
      
      message = "\n#{header}\n#{message}\n#{backtrace}\n#{footer}"
      $logger.error(message)
      error! message, 400
    end

    prefix :api
    mount Api::V1
  end
end
