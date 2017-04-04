module WrApi
  class Api
    class V1
      class Base
        class Params

          attr_reader :raw_params

          def initialize raw_params
            @raw_params = raw_params.to_hash.deep_symbolize_keys
          end

          def offset
            page * limit
          end

          def per_page
            raw_params.fetch(:per_page, WrApi::DEFAULT_PAGE_SIZE).to_i
          end
          alias :limit :per_page
          
          def page
            raw_params.fetch(:page, 0).to_i
          end

        end
      end
    end
  end
end