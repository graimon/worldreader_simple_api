require 'tasks/db/base'

module Tasks
  module Db
    class Dropper < Base

      def sql_sentence
        "DROP DATABASE #{ database_name };"
      end

    end
  end
end
