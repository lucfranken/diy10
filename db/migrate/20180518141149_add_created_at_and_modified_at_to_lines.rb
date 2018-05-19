class AddCreatedAtAndModifiedAtToLines < ActiveRecord::Migration[5.2]
  def change
    add_column :lines, :created_at, :datetime
    add_column :lines, :modified_at, :datetime
  end
end
