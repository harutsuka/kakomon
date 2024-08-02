require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'

before do 
    Dotenv.load
    Cloudinary.config do |config|
        config.cloud_name = ENV['CLOUD_NAME']
        config.api_key  = ENV['CLOUDINARY_API_KEY']
        config.api_secret = ENV['CLOUDINARY_API_SECRET']
        config.secure  = true
    end 
end

get "/" do
    erb :index
end

get "/new" do
  erb :new
end

post "/new" do
    if params[:upload_photo]
      image = params[:upload_photo]
      tempfile = image[:tempfile]
      upload = Cloudinary::Uploader.upload(tempfile.path)
      img_url = upload['url']
    end

    post = Post.create(
        image_url: img_url
    )
    redirect '/'
end

get "/:category_id" do
    erb :index
end