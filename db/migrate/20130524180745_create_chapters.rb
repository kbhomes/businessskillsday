class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :contact
      t.string :email
      t.boolean :invoice_sent

      t.timestamps
    end
  end
end
