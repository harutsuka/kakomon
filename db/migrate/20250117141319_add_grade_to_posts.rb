class AddGradeToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts,:grade,:string
  end
end
