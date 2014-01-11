require 'sinatra'
require 'net/https'
require 'net/http'
require 'json'

get '/' do
  File.read(File.join('public', 'index.html'))
end

post '/' do
  request.body.rewind
  payload = JSON.parse(request.body.read)

  images = payload['imgs']
  status_code 400 if images.nil?

  title = payload['title']
  album = create_album(title)

  upload_images(images, album['deletehash'])

  { 'id' => album['id'] }.to_json
end

def upload_images(images, deletehash)
  images.each do |image|
    imgur_request("/3/image?image=#{image}&album=#{deletehash}&type=URL", 'post')
  end
end


def create_album(title)
  path = '/3/album'
  path += "?title=#{title}" unless title.nil?

  response = imgur_request(path, 'post')
  body = JSON.parse(response.body)
  body['data']
end

def imgur_request(path, type)
  headers = { 'Authorization' => "Client-ID #{ENV['IMGUR_API_KEY']}" }

  uri = URI("https://api.imgur.com#{path}")

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = create_request(path, type, headers)
  http.request(request)
end

def create_request(path, type, headers)
  if type == 'post'
    Net::HTTP::Post.new(path, headers)
  else
    Net::HTTP::Get.new(path, headers)
  end
end