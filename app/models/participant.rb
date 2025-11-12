class Participant < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  has_many :messages

end