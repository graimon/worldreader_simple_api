desc "Prints all routes from the grape API"
task :routes do
  format = "%46s  %3s %7s %50s"
  WrApi::Api.routes.each do |grape_route|
    info = grape_route.instance_variable_get :@options

    puts format % [
      info[:description] ? info[:description][0..45] : '',
      info[:version],
      info[:method],
      grape_route.pattern.path.gsub(':version', info[:version])
    ]
  end
end
