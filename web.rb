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
  path = "/3/gallery/album/"
  uri = URI("https://api.imgur.com#{path}")
  request = Net::HTTP::Get.new(path, headers)

  Net::HTTP.new(uri.host, uri.port).start {|http| http.request(request) }
end