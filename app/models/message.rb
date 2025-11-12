class Message < ApplicationRecord
  belongs_to :participant
  has_one :chat, through: :participant
  has_one :user, through: :participant
end