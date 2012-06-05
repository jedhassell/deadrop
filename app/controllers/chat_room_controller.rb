require 'animals'
class ChatRoomController < ApplicationController
  def index
    @messages = ChatMessage.where(chat_name: params[:key]).order_by(:create_time, :desc)
    @count = @messages.count
    unless (@messages.empty?)
      render 'index'
    else
      render 'create_chat_room'
    end
  end

  def index_blank
    redirect_to "/chat_room/#{(0..5).map { rand(36).to_s(36) }.join}"
  end

  def get_new_messages
    current_count = params[:message_count].to_i
    mongo_count = ChatMessage.where(chat_name: params[:key]).count
    @messages = []
    unless (current_count == mongo_count)
      @messages = ChatMessage.where(chat_name: params[:key]).order_by(:create_time, :desc).limit(mongo_count - current_count)
    end
    render :partial => 'messages'
  end

  def create_chat_room_from_form
    #make username unique to keep from spoofing
    session[:animal] ||= Animals::Names.sample
    message = ChatMessage.new()
    message['chat_name'] = params[:key]
    message['data'] = params[:encrypted_message]
    message['username'] = "#{session[:animal]} #{params[:username].empty? ? '' : "(#{params[:username]})"}"
    message['create_time'] = Time.now
    message.save!

    redirect_to action: 'index'
  end

  def create_message
    session[:animal] ||= Animals::Names.sample
    message = ChatMessage.new()
    message['chat_name'] = params[:key]
    message['data'] = params[:encrypted_message]
    message['username'] = "#{session[:animal]} #{params[:username].empty? ? '' : "(#{params[:username]})"}"
    message['create_time'] = Time.now
    message.save!

    render nothing: true
  end
end