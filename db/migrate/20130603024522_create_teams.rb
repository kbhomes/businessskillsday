class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.belongs_to :chapter
      t.belongs_to :event

      t.timestamps
    end
  end
end
