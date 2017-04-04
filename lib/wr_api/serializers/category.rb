module WrApi
  module Serializers
    class Category

      attr_reader :category

      def initialize category
        @category = category
      end

      def to_json
        if category.present?
          as_json.to_json
        else
          "Not found.".to_json
        end
      end

      def as_json
        {
          :id           => category.id, 
          :iconcolor    => category.iconcolor, 
          :iconurl      => category.iconurl, 
          :name         => category.name, 
          :description  => category.description, 
          :parent_id    => category.parent_id, 
          :listorder    => category.listorder
        }
      end

    end
  end
end