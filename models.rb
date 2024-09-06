require "bundler/setup"
Bundler.require

ActiveRecord::Base.establish_connection

class Post < ActiveRecord::Base
  belongs_to :category
  has_many :image
end

class Category < ActiveRecord::Base
  has_many :post
end

class Image < ActiveRecord::Base
  belongs_to :post
end
