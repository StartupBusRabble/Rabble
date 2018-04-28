class AddUsersReferenceToQuestionnaire < ActiveRecord::Migration[5.0]
  def change
    add_reference(:questionnaires, :user)
  end
end
