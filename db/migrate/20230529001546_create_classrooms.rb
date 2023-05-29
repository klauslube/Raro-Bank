class CreateClassrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :classrooms do |t|
      t.string :name, null: false, limit: 100
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.index %i[name], unique: true

      t.timestamps
    end
  end
end
