class ChangeReceiptValueFieldType < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :receipts do |t|
        dir.up   { t.change :value, :integer }
        dir.down { t.change :value, :decimal }
      end
    end
  end
end
