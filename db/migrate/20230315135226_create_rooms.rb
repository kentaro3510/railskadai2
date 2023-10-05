class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name_of_hotel
      t.text :introduction
      t.integer :price
      t.text :address
      t.references :user

      t.timestamps
    end
  end
end