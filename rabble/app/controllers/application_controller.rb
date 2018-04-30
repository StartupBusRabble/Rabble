class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    if (current_user && !current_user.is_user_ready_for_match)
      redirect_to questionnaire_index_url
    elsif current_user && current_user.is_user_ready_for_match
      redirect_to group_index_url
    else
      render "index.html"
    end
  end
end
