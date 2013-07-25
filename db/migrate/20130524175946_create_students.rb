class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.integer :grade

      t.belongs_to :chapter

      t.belongs_to :event1
      t.belongs_to :event2
      t.belongs_to :event3

      t.timestamps
    end
  end
end
