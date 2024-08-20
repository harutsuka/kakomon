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
  
      if image.is_a?(Hash)
        tempfile = image[:tempfile]
        upload = Cloudinary::Uploader.upload(tempfile.path)
        img_url = upload['url']
  
        post = Post.new(img_url: img_url)
        if post.save
          flash[:notice] = "画像投稿できたよ"
        else
          flash[:notice] = "画像投稿できなかったよ"
        end
      else
        flash[:alert] = "ファイルが正しくアップロードされてないよ"
      end
    end
    @posts = Post.all
    
    redirect '/'
end

get "/:category_id" do
    erb :index
end
