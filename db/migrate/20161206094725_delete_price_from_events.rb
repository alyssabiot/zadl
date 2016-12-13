class DeletePriceFromEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :price
    remove_column :events, :currency
  end
end
