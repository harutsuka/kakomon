class AddCourseToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts,:course,:integer
  end
end
