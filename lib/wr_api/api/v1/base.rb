module WrApi
  class Api
    class V1
      class Base < Grape::API
        
        autoload :Params, 'wr_api/api/v1/base/params'
        
        params do
          optional :page,     type: Integer, desc: 'Page number'
          optional :per_page, type: Integer, desc: 'Per page amount'
        end
        
        format :json
        content_type :json, 'application/json'

      end
    end
  end
end