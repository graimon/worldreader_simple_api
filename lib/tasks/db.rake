namespace :db do

  desc "Creates the main database for all tenants"
  task :create do
    require_relative 'db/creator'
    creator = Tasks::Db::Creator.new(DB)
    creator.call
  end

  desc "Drops the main database for all tenants"
  task :drop do
    require_relative 'db/dropper'
    dropper = Tasks::Db::Dropper.new(DB)
    dropper.call
  end

  desc "Runs pending migrations"
  task :migrate do
    require 'sequel'

    migrations_path = ::File.expand_path("../../../db/migrations", __FILE__)
    Sequel.extension :migration

    Sequel::Migrator.run(DB, migrations_path)
  end

  desc "Drops, creates and migrates"
  task :reset do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
  end

end
