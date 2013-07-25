class ChangeStudents < ActiveRecord::Migration
  def change
    remove_column :students, :event1_id
    remove_column :students, :event2_id
    remove_column :students, :event3_id
  end
end
