module WrApi
  class Api
    class V1
      class Categories < Base
          
        helpers do
          def current_params
            @current_params ||= Params.new(params)
          end
        end
        
        resource :categories do
          desc 'Index of Categories'
          get do
            categories = Models::Category.all current_params.offset, current_params.per_page
            count = Models::Category.count
            Serializers::Categories.new(categories, count, current_params)
          end

          params do
            requires :id, type: Integer, desc: 'Category ID'
          end
          route_param :id do
            desc 'Shows a Category'
            get do
              category = Models::Category.get params[:id]

              status :not_found if category.blank?
              Serializers::Category.new(category)
            end
            
            desc 'Shows all Books in Category'
            get 'books' do
              category = Models::Category.get params[:id]
              if category.blank?
                status :not_found
                Serializers::Category.new(category)
              else
                Serializers::Books.new(category.books, category.books_count, params)
              end
            end
            
          end
        end
      end

    end
  end
end