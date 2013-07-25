class CreateAdvisers < ActiveRecord::Migration
  def change
    create_table :advisers do |t|
      t.string :name

      t.belongs_to :chapter

      t.timestamps
    end
  end
end
