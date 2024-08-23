require "bundler/setup"
Bundler.require

ActiveRecord::Base.establish_connection

class Post < ActiveRecord::Base
end

class Category < ActiveRecord::Base
    validates :title, presence: true
    belongs_to :user
    belongs_to :list
end

class Image < ActiveRecord::Base
end
