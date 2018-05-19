class AddStatusToReceipts < ActiveRecord::Migration[5.2]
  def change
    add_column :receipts, :status, :integer
  end
end
