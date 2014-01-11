require 'sinatra'
require 'net/https'
require 'net/http'
require 'net/https'

get '/' do
  imgur
end


def imgur
  headers    = {
      'Authorization' => 'Client-ID ' + ENV['IMGUR_API_KEY']
  }
  path = "/3/album/"
  uri = URI("https://api.imgur.com#{path}")
  request = Net::HTTP::Post.new(path, headers)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  response = http.request(request)
  response.body
end