class CreateUsersQuestionnairesJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :questionnaires
  end
end
