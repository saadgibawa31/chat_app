class RemoveChatFromMessages < ActiveRecord::Migration[7.2]
  def change
    remove_column :messages, :chat_id, foreign_key: true
  end
end
