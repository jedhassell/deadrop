class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    # create random string here for index
  end

  def create_drop
    drop_name = params[:drop_name]
    # add code here to check to see if drop exist?

    drop_name = (0..5).map { rand(36).to_s(36) }.join if drop_name.empty?

    redirect_to "/#{drop_name}"
  end
end
