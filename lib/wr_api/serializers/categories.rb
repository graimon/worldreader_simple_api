module WrApi
  module Serializers
    class Categories

      attr_reader :categories, :total_results, :params

      def initialize categories, total_results, params
        @categories          = categories
        @total_results  = total_results
        @params         = params
      end

      def to_json
        {
          :per_page      => params.per_page,
          :page          => params.page,
          :total_pages   => total_pages,
          :total_results => total_results,
          :categories         => categories_json
        }.to_json
      end

    private

      def categories_json
        categories.map do |affiliate|
          Affiliate.new(affiliate).as_json
        end
      end

      def total_pages
        (total_results / params.per_page.to_f).ceil
      end

    end
  end
end