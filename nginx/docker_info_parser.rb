r = Nginx::Request.new
info = JSON::parse(File.open("/root/info/docker_info.json").read)
proxy_base = r.uri.split('/')[1]
app = proxy_base.split(":")[0]
port = proxy_base.split(":")[1]
container = info.find do |container|
  container["Names"][0].split("/")[1] == app
end
proxy = container["NetworkSettings"]["Networks"]["bridge"]["IPAddress"] + ":" + port.to_s + "/"
Nginx.errlogger Nginx::LOG_ERR, proxy
proxy
