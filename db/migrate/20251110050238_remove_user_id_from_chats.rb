class RemoveUserIdFromChats < ActiveRecord::Migration[7.2]
  def change
    remove_column :chats, :receiver_id, type: :Bigint, index: true, foreign_key: true
    # remove_reference :chats, :sender_id, index: true, foreign_key: true
  end
end
