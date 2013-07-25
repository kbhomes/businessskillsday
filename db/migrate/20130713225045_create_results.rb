class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :rank
      t.belongs_to :event
      t.integer :participant_id # Will be either the Student or the Team, dependent on the type of the Result (StudentResult vs TeamResult)
      t.string :type

      t.timestamps
    end
  end
end
