class AddReimbursedToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :reimbursed, :string, default: "pending"
  end
end
