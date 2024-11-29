require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'
require 'pry'

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
  @posts = Post.all
  erb :index
end

post "/post" do
    if params[:upload_photo]
      image = params[:upload_photo]
      tempfile = image[:tempfile]
      upload = Cloudinary::Uploader.upload(tempfile.path)
      img_url = upload['url']
    end

    post = Post.create(
      subject_name: "数学B"
    )
    Image.create(
      image_url: img_url,
      post_id: post.id
    )
    redirect '/'
end

get "/id/:id" do
  @image = Image.find(params[:id])
  erb :detail
end
