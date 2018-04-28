class AddChatChannelToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :chat_name, :string
  end
end
