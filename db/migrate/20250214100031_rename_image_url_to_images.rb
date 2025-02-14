class RenameImageUrlToImages < ActiveRecord::Migration[6.1]
  def change
    rename_column :images,:image_url,:main_image_url
  end
end
