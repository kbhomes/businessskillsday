class CreateEventResults < ActiveRecord::Migration
  def change
    create_table :event_results do |t|
      t.belongs_to :event
      t.belongs_to :first_place_student
      t.belongs_to :second_place_student
      t.belongs_to :third_place_student
      t.belongs_to :fourth_place_student
      t.belongs_to :fifth_place_student

      t.timestamps
    end
  end
end
