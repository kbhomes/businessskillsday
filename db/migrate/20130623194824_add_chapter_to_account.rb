class AddChapterToAccount < ActiveRecord::Migration
  def change
    change_table :accounts do |t|
      t.belongs_to :chapter
    end
  end
end
