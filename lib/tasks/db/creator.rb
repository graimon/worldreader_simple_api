require 'tasks/db/base'

module Tasks
  module Db
    class Creator < Base

      def sql_sentence
        "CREATE DATABASE #{ database_name };"
      end

    end
  end
end
