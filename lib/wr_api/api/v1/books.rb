module WrApi
  class Api
    class V1
      class Books < Base
          
        helpers do
          def current_params
            @current_params ||= Params.new(params)
          end
        end
        
        resource :books do
          desc 'Index of Books'
          get do
            books = Models::Book.all current_params.offset, current_params.per_page
            count = Models::Book.count
            Serializers::Books.new(books, count, current_params)
          end

          desc 'Shows a Book'
          params do
            requires :id, type: Integer, desc: 'Book ID'
          end
          route_param :id do
            get do
              book = Models::Book.get params[:id]

              status :not_found if book.blank?
              Serializers::Book.new(book)
            end
          end
        end
      end

    end
  end
end