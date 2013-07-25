class RemoveRankFromResult < ActiveRecord::Migration
  def up
    remove_column :results, :rank
  end

  def down
    add_column :results, :rank, :integer
  end
end
