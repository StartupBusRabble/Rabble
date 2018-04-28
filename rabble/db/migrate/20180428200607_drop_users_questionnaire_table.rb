class DropUsersQuestionnaireTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :questionnaires_users
  end
end
