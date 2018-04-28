class AddIsUserReadyForMatchToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_user_ready_for_match, :boolean, null: false, default: false
  end
end
