class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    render "index.html"
  end

  def show
    if valid_page?
       render "application/#{params[:page]}"
     else
       render file: "public/404.html", status: :not_found
     end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/application/#{params[:page]}.html.erb"))
  end
end
