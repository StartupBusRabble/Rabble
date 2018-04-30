class Matchmaker < ApplicationController
  def match_users_based_on(current_user)
    matched_joined_users = User.select('users.id', 'users.matched', 'compatibility_scores.compared_user', 'compatibility_scores.score').joins(:compatibility_scores).where('matched' => false).where('id' => current_user.id ).where('score > 0').order('score DESC').limit(3)

    if matched_joined_users.count == 3
      chat_channel = generate_unique_chat_channel_name()
      new_group = Group.create(chat_name: chat_channel)
      Event.create(venue: "After party", address: "The place", date: "Monday night", groups_id: new_group.id)

      current_user.groups_id = new_group.id
      current_user.matched = true
      matched_joined_users.each do |matched_joined_user|
        matched_user = User.find_by(id: matched_joined_user.compared_user)
        matched_user.groups_id = new_group.id
        matched_user.matched = true
        matched_user.save
      end
      current_user.save
    end
  end

  private
  def generate_unique_chat_channel_name
    return Group.count
  end
end
