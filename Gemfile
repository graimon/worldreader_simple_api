source "https://rubygems.org"

# === HTTP ===
gem "grape"
gem 'grape-middleware-logger'
#gem "faraday"

# === Web Server ===
gem 'puma'

# === Tasks ===
gem "rake"
#gem 'whenever'

# === Database ===
gem "sequel"
gem "sequel_pg", :require => 'sequel'

# === Tools ===
gem "activesupport"
gem "activemodel"
gem "active_model_serializers"
gem 'json'

# === Status ===
#gem "rack-health"

# === debugging, development and testing ===
group :development, :test do
  gem "pry"
  gem 'pry-byebug'
end

# ==== Deployment ===
#group :production, :staging do
#  gem "capistrano", "2.15.5",   :require => false
#  gem "rvm-capistrano",         :require => false
#  gem "capistrano-shared_file", :require => false
#  gem "hiera-eyaml"
#end

group :test do
  gem "rspec"
  gem "rack-test"
  gem "database_cleaner"
  gem 'faker'
end
