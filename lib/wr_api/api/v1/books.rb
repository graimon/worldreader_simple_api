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

          params do
            requires :uuid, type: String, desc: 'Book UUID'
          end
          route_param :uuid do
            desc 'Shows a Book'
            get do
              book = Models::Book.get params[:uuid]

              status :not_found if book.blank?
              Serializers::Book.new(book)
            end
          end
        end
      end

    end
  end
end