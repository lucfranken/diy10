class AddDefaultStatusForReceipts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :receipts, :status, 0
  end
end
