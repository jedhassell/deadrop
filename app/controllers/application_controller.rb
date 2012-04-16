class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
      # create random string here for index
  end

  def create_drop
    drop_name = params[:drop_name]
    # add code here to check to see if drop exist?

    redirect_to controller: 'deadrop', action: drop_name
  end
end
