class AddNineTenToEvents < ActiveRecord::Migration
  def change
    add_column :events, :nine_ten, :boolean, :default => false
  end
end
