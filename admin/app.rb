require 'json'
require 'docker'
require 'yaml'
require 'sinatra'
require 'sinatra/reloader' if development?

config = YAML.load_file('config.yml')
docker_host = config.fetch('docker_host', ENV['DOCKER_HOST'])
Docker.url = docker_host

get "/" do
  cons = Docker::Container.all(:running => true)
  @info = cons.map{ |con| con.info }
  File.open("info/docker_info.json", "w") do |file|
    file.puts(JSON.pretty_generate(@info))
  end
  @docker_host = docker_host.match(/[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}/).to_s
  @proxy_container = @info.find{|con| con["Image"] == "matsumotory/ngx-mruby:latest" }
  erb :index
end
