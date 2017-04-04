module WrApi
  module Models
    class Book
      
      class << self
        
        def table
          DB[:book]
        end
        
        def get uuid
          row = table.where(:uuid => uuid).first
          new row if row
        end
        
      end
      
      attr_accessor :uuid, :id, :title, :author, :language, :createtime
      
      def initialize data
        @uuid = data[:uuid]
        @id = data[:id]
        @title = data[:title]
        @author = data[:author]
        @language = data[:language]
        @createtime = data[:createtime]
      end
      
    end
  end
end