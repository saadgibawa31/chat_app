module V1
  class Chats < Grape::API

    helpers V1::Helpers::AuthHelper
    before { authenticate_user! }

    resource :chats do

      desc 'List all chats'

      get do
        Chat.where("sender_id = ? OR receiver_id = ?", @current_user.id, @current_user.id)
      end

      desc 'Creating a new chat'

      params do
        requires :receiver_id, type: Integer, desc: 'Receiver Id'
      end

      post do

        receiver = User.find(params[:receiver_id])

        chat = Chat.find_by(sender_id: @current_user.id, receiver_id: receiver.id) || 
              Chat.find_by(sender_id: receiver.id, receiver_id: @current_user.id) ||
              Chat.create!(sender_id: @current_user.id, receiver_id: receiver.id)

        {chat_id: chat.id, sender_id: chat.sender_id, receiver_id: chat.receiver_id}

      end

    end

  end

end
