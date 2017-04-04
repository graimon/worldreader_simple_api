require 'sequel'

module Tasks
  module Db
    class Base

      attr_reader :database

      def initialize database
        @database = database
      end

      def call
        connection << sql_sentence
      end

    private

      def sql_sentence
        raise NotImplementedError, "SQL sentence not defined"
      end

      def database_name
        config.fetch :database
      end

      def connection
        @connection ||= Sequel.connect(base_options)
      end

      def base_options
        keys = [ :adapter, :user, :host, :port, :password ]

        config.select { |key| keys.include? key }
      end

      def config
        @config ||= database.opts
      end

    end
  end
end
