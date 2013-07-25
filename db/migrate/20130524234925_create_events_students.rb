class CreateEventsStudents < ActiveRecord::Migration
  def change
    create_table :events_students do |t|
      t.belongs_to :event
      t.belongs_to :student
    end
  end
end
