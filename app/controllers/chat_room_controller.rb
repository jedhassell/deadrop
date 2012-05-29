class ChatRoomController < ApplicationController
  def index
    @messages = ChatMessage.where(chat_name: params[:key]).order_by(:create_time)
    unless (@messages.empty?)
      render 'index'
    else
      render 'create_chat_room'
    end
  end

  def index_blank
    redirect_to "/chat_room/#{(0..5).map { rand(36).to_s(36) }.join}"
  end

  def create_chat_room_from_form
    message = ChatMessage.new()
    message['chat_name'] = params[:key]
    message['data'] = params[:encrypted_object]
    message['create_time'] = Time.now
    message.save!

    redirect_to action: 'index'
  end
end