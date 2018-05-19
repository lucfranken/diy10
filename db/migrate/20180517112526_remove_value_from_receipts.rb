class RemoveValueFromReceipts < ActiveRecord::Migration[5.2]
  def change
    remove_column :receipts, :value
  end
end
