#!/usr/bin/env ruby
require 'rack'
require 'socket'
require 'optparse'

ENV['RACK_ENV'] = "production"

# Options :
#   --root (mandatory)
#   --port (optional)
#   --interface (optional)
#   --extension ?

handler_options = { :Port => 10080 }
app_options     = { :root => "." }

OptionParser.new do |parser|
  parser.on "-p", "--port PORT" do |port|
    handler_options[ :Port ] = port.to_i
  end
  parser.on "-r", "--root ROOT_DIR" do |root_dir|
    app_options[ :root ]     = root_dir
  end
  parser.on "-i", "--interface IPADDR" do |ipaddr|
    handler_options[ :Host ] = ipaddr
  end
end.parse!

puts "Root directory:\t#{File.absolute_path app_options[:root] }"
puts "Server port:\t#{handler_options[:Port]}"
Socket::getaddrinfo(Socket.gethostname,"http", nil, :STREAM).each do |family, port, hostname, ip, *_|
  puts "Server IP:\t#{ip[/^[^%]*/]}"
end

app     = Rack::Directory.new app_options[:root]
handler = Rack::Handler.pick %w/ thin webrick /
handler.run app, handler_options
