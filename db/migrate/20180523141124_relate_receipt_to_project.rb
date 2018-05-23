class RelateReceiptToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :receipts, :project, foreign_key: true
    remove_column :receipts, :user_id
  end
end
