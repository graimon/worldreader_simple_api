module WrApi
  module Serializers
    class Books

      attr_reader :books, :total_results, :params

      def initialize books, total_results, params
        @books          = books
        @total_results  = total_results
        @params         = params
      end

      def to_json
        {
          :per_page      => params.per_page,
          :page          => params.page,
          :total_pages   => total_pages,
          :total_results => total_results,
          :books         => books_json
        }.to_json
      end

    private

      def books_json
        books.map do |affiliate|
          Affiliate.new(affiliate).as_json
        end
      end

      def total_pages
        (total_results / params.per_page.to_f).ceil
      end

    end
  end
end