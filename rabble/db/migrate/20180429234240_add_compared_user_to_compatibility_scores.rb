class AddComparedUserToCompatibilityScores < ActiveRecord::Migration[5.0]
  def change
    add_column :compatibility_scores, :compared_user, :integer
  end
end
