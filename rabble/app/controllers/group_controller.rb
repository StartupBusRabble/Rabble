class GroupController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user && current_user.groups_id?
      @chatName = Group.find(current_user.groups_id).chat_name
      @event = Event.find_by_id(Group.find(current_user.groups_id).id)
      @matchedUsers = User.where(groups_id: current_user.groups_id).where.not(id: current_user.id)
    end
    render "group.html"
  end

end
