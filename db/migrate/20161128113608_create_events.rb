class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :starts_at
      t.string :ends_at
      t.references :user, foreign_key: true
      t.integer :min_participants
      t.integer :max_participants
      t.float :price, default: 0
      t.string :photo
      t.string :location
      t.string :currency, default: "EUR"
      t.boolean :notif_subscription, default: false
      t.boolean :notif_cancellation, default: true
      t.boolean :notif_message, default: false
      t.boolean :withdrawed, default: false

      t.timestamps
    end
  end
end
