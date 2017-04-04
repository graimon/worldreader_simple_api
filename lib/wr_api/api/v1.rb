module WrApi
  class Api
    class V1 < Grape::API
      
      autoload :Base,       'wr_api/api/v1/base'
      autoload :Books,      'wr_api/api/v1/books'
      autoload :Categories, 'wr_api/api/v1/categories'

      version :v1
      mount Api::V1::Books
      mount Api::V1::Categories

    end
  end
end
