require "bundler/setup"
Bundler.require

ActiveRecord::Base.establish_connection

class Post < ActiveRecord::Base
end

class Category < ActiveRecord::Base
end

class Image < ActiveRecord::Base
end
