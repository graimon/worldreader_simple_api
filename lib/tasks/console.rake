desc "Starts a Pry session with the project loaded (alias: rake c)"

task :console do
  require "pry"
  
  Pry.start
end

task :c => :console
