class ChangeGradeOfPosts < ActiveRecord::Migration[6.1]
  def change
      change_column :posts,:grade,'integer USING grade::integer'
  end
end
