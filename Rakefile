ENV["APP_ENV"] ||= "development"

require ::File.expand_path('../environment',  __FILE__)

tasks_dir = ::File.expand_path("../lib/tasks", __FILE__)

::Dir["#{ tasks_dir }/**/*.rake"].each do |task_file|
  import task_file
end
