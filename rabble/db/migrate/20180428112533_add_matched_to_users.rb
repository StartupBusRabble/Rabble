class AddMatchedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :matched, :boolean, null: false, default: false
  end
end
