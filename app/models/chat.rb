class Chat < ApplicationRecord
  has_many :participants
  has_many :users, through: :participants
  has_many :messages, through: :participants
end
