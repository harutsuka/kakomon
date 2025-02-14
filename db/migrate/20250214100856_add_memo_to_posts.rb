class AddMemoToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts,:memo,:string
  end
end
