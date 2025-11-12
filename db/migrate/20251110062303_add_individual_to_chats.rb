class AddIndividualToChats < ActiveRecord::Migration[7.2]
  def change
    add_column :chats, :individual, :boolean, null: false

    Chat.update_all(individual: 'true')
  end
end
