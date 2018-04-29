class AddUsersToCompatibilityScores < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :compatibility_score, foreign_key: true
    add_reference :compatibility_scores, :user, foreign_key: true
  end
end
