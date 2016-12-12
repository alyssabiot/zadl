class AddFieldsToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :state, :string
    add_column :bookings, :payment, :json
    add_monetize :bookings, :amount, currency: { present: false }
  end
end
