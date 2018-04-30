class AddMbValueToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mb_value, :string
  end
end
