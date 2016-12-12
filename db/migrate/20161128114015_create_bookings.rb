class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.boolean :on_waiting_list, default: false
      t.boolean :cancelled, default: false
      t.text :cancellation_message

      t.timestamps
    end
  end
end
