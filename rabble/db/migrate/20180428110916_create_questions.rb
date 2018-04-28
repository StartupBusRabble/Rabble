class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :name, null: false

      t.references :questionnaire
      t.timestamps
    end
  end
end
