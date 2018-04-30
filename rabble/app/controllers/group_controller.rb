class GroupController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user && current_user.groups_id?
      @group = Group.find(current_user.groups_id)
      @event = Event.where(groups_id: Group.find(current_user.groups_id).id).take
      @matchedUsers = User.where(groups_id: current_user.groups_id).where.not(id: current_user.id)
    end
    render "group.html"
  end

  def show
    @groupChatName = Group.find_by(id: params[:id]).chat_name
    render "show.html"
  end

end
