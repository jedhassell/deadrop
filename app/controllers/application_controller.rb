class ApplicationController < ActionController::Base
  protect_from_forgery

  #def create_chat_room
  #  chat_room_name = params[:chat_room_name]
  #  chat_room_name = get_random_name if chat_room_name.empty?
  #
  #  redirect_to controller: "chat_room", id: chat_room_name
  #end

end
