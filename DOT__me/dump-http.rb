#!/usr/bin/env ruby
require 'rack'
require 'socket'
require 'pp'
require 'date'
require 'rexml/document'

handler_options = { :Port => 55542, :Host => "0.0.0.0", }

puts "Server port:\t#{handler_options[:Port]}"

Socket::getaddrinfo(Socket.gethostname,"http", nil, :STREAM).each do |family, port, hostname, ip, *_|
  puts "Server IP:\t#{ip[/^[^%]*/]}"
end

def reserve_env_key? key
  case key
  when *%w{ REQUEST_METHOD REQUEST_PATH QUERY_STRING REQUEST_URI REMOTE_ADDR }
    true
  when /^(HTTP|CONTENT)_/
    true
  else
    false
  end
end

def prettify_xml xml
  doc = REXML::Document.new xml
  out = StringIO.new
  formatter = REXML::Formatters::Pretty.new
  formatter.write(doc, out)
  out.string.freeze
end

app = lambda do |env|
  req = env.select{|k| reserve_env_key? k}.to_h
  body = env["rack.input"]&.read

  pretty_body = case req['CONTENT_TYPE']
                when /xml/
                  prettify_xml body
                else
                  body
                end
  puts "----#{DateTime.now}----"
  query = Rack::Utils.parse_nested_query req['QUERY_STRING']

  path = req['REQUEST_PATH']

  res_headers = {'Content-Type' => 'text/plain', 'Access-Control-Allow-Origin' => '*'}

  res = if /customer-message/i.match(path) && query['echostr']
          # for custom service validation
          ['200', res_headers, query['echostr']]
        elsif /customer-message/i.match(path)
          # for custom service message
          ['200', res_headers, 'success']
        elsif /always-error/i.match(path)
          # for error
          ['502', res_headers, "baaaaaaaaaaad gateway"]
        else
          ['200', res_headers, "suuuuuuuuuccess"]
        end
  pp req: req, query: query
  puts ":req =>", pretty_body
  pp res: res
  STDOUT.flush
  res
end

handler = Rack::Handler.pick %w/ thin webrick /
handler.run app, handler_options
