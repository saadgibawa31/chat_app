class User < ApplicationRecord
  has_secure_password

  has_many :participants
  has_many :chats, through: :participants
  has_many :messages, through: :participants

  validates( 
    :email, 
    presence: true,
    format: {with: /(^[A-Za-z].*)[A-Za-z0-9]+@(gmail|yahoo|hotmail)+\.[a-zA-Z]{1,3}\z/,message: "Email is invalid"},
    uniqueness: true
  )

  
end