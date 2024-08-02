require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'

get "/" do
    erb :index
end

post "/new" do
    erb :new
end

get "/:category_id" do
    erb :index
end