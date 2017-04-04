module WrApi
  module Models
    class Category
      
      class << self
        
        def table
          DB[:category]
        end
        
        def get id
          row = table.where(:id => id).first
          new row if row
        end
        
        def all offset, limit
          table.limit(limit).offset(offset).collect do |row|
            new row
          end
        end
        
        def count
          table.count
        end
        
      end
      
      attr_accessor :id, :iconcolor, :iconurl, :name, :description, :parent_id, :listorder
      
      def initialize data
        @id           = data[:id]
        @iconcolor    = data[:iconcolor]
        @iconurl      = data[:iconurl]
        @name         = data[:name]
        @description  = data[:description]
        @parent_id    = data[:parent_id]
        @listorder    = data[:listorder]
      end
      
      def books offset, limit
        books_scope.limit(limit).offset(offset).collect do |row|
          Book.new row
        end
      end
      
      def books_count
        books_scope.count
      end
      
      private
      
      def books_scope 
        self.class.table.join(:category_book, :categories_id => :id).
          join(:book, :id => :books_id).select(Sequel.lit("book.*"))
      end
      
    end
  end
end