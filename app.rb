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

helpers do
  def gradeList
    ["1年","2年","3年","4年","5年"]
  end
  def termList
    ["前期中間","前期末","後期中間","学年末","その他"]
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
  main_image_urls = []

  if params[:uploaded_image_main]
    params[:uploaded_image_main].each do |image|
      tempfile = image[:tempfile]
      upload = Cloudinary::Uploader.upload(tempfile.path)
      main_image_urls << upload['url']
    end
  end

  if params[:uploaded_image_sub]
    image = params[:uploaded_image_sub]
    tempfile = image[:tempfile]
    upload = Cloudinary::Uploader.upload(tempfile.path)
    sub_image_url = upload['url']
  end

  post = Post.create(
    subject_name: params[:subject_name],
    term: params[:term],
    grade: params[:grade],
    memo: params[:memo],
    course: params[:course]
  )

  main_image_urls.each do |url|
    Image.create(
      post_id: post.id,
      main_image_url: url,
      sub_image_url: sub_image_url,
    )
  end
  
  redirect '/'
end

get "/id/:id" do
  @post = Post.find(params[:id])
  @image = Image.where(post_id: params[:id])
  erb :detail
end

post "/id/:id/delete" do
  Post.find(params[:id]).destroy
  redirect "/"
end
