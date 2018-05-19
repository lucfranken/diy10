class CreateAdminSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.string :name

      t.timestamps
    end

    add_reference :receipts, :supplier, foreign_key: true
  end
end
