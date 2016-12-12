class ChangeDatesTypeForEvents < ActiveRecord::Migration[5.0]
  def up
    remove_column :events, :starts_at, :string
    remove_column :events, :ends_at, :string
    add_column :events, :starts_at, :datetime
    add_column :events, :ends_at, :datetime
  end

  def down
    remove_column :events, :starts_at, :string
    remove_column :events, :ends_at, :string
    add_column :events, :starts_at, :string
    add_column :events, :ends_at, :string
  end
end
