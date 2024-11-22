class AddSubjectNameAndTermToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts,:subject_name,:string
    add_column :posts,:term,:integer
  end
end
