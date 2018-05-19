class CreateLines < ActiveRecord::Migration[5.2]
  def change
    create_table :lines do |t|
      t.string :description
      t.integer :amount
      t.integer :price_cents
      t.string :price_currency
      t.integer :price_total_cents
      t.string :price_total_currency
      t.references :user, foreign_key: true
      t.references :receipt, foreign_key: true
    end
  end
end
