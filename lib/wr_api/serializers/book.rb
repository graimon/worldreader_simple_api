module WrApi
  module Serializers
    class Book

      attr_reader :book

      def initialize book
        @book = book
      end

      def to_json
        if book.present?
          as_json.to_json
        else
          "Not found.".to_json
        end
      end

      def as_json
        {
          :uuid       => book.uuid, 
          :id         => book.id, 
          :title      => book.title, 
          :author     => book.author, 
          :language   => book.language, 
          :createtime => book.createtime
        }
      end

    end
  end
end