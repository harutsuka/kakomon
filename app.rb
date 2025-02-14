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

helpers do
  def gradeList
    ["1年","2年","3年","4年","5年"]
  end
  def termList
    ["前期中間","前期末","後期中間","学年末"]
  end
  def courseList
    ["共通","Mコース","Dコース","Eコース","Iコース"]
  end
end

get "/" do
  grade = params[:grade] || 0
  course = params[:course] || 0
  term = params[:term] || 0
  @posts = Post.where(grade:grade,course:course,term:term)
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
      subject_name: params[:subject_name],
      term: params[:term],
      grade: params[:grade],
      memo: params[:memo],
      course: params[:course]
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
