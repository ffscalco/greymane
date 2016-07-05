class ChangeEventPriceType < ActiveRecord::Migration
  def change
    remove_column :events, :price, :decimal
    add_monetize :events, :price, amount: { null: false, default: 0 }, currency: { present: false }
  end
end
