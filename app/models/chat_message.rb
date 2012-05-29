class ChatMessage
  include Mongoid::Document
  index :chat_name
  index :create_time
end