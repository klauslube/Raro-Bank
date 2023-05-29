class AddClassroomToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :classroom, foreign_key: true, optional: true
  end
end
