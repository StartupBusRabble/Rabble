class CreateCompatibilityScores < ActiveRecord::Migration[5.0]
  def change
    create_table :compatibility_scores do |t|
      t.integer :score
    end
  end
end
