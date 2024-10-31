class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :level
      t.string :kind
      t.string :shift

      t.timestamps
    end
  end
end
