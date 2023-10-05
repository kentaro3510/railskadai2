class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :checkin_date
      t.date :checkout_date
      t.string :name_of_hotel
      t.integer :number_of_people
      t.integer :length_of_stay
      t.integer :amount_of_price
      t.references :room
      t.references :user
      t.timestamps
    end
  end
end