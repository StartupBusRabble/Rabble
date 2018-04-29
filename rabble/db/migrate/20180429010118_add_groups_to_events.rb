class AddGroupsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :groups, foreign_key: true
  end
end
