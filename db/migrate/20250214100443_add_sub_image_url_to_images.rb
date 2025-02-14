class AddSubImageUrlToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images,:sub_image_url,:string
  end
end
