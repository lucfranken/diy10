class ChangeReceiptValueColumnToValueCentsForMoneyPlugin < ActiveRecord::Migration[5.2]
  def change
    add_monetize :receipts, :value
  end
end