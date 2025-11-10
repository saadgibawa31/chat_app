class User < ApplicationRecord
  has_secure_password
  
  has_many :messages
  has_many :sent_chats, class_name: "Chat", foreign_key: "sender_id"
  has_many :received_chats, class_name: "Chat", foreign_key: "receiver_id"
  
end