class DropEventResultsTable < ActiveRecord::Migration
  def up
    drop_table :event_results
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
