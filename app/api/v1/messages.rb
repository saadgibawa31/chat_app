module V1

  class Messages < Grape::API

    helpers V1::Helpers::AuthHelper

    before{ authenticate_user!}

    resource :messages do

      desc 'Fetching All Messages'
      params do
        requires :chat_id, type: Integer, desc: 'Chat Id'
      end
      post do
        # next "hello world"
        chat = Chat.find(params[:chat_id])

        unless ([chat.receiver_id, chat.sender_id].include?(@current_user.id))
          error!("Access Denied", 403)
        end

        chat.messages.order(:created_at)
      end


      desc 'Creating new message'

      params do
        requires :chat_id, type: Integer, desc: 'Chat Id'
        requires :content, type: String, desc: 'Message Body'
      end

      post :new do

        chat = Chat.find(params[:chat_id])
        unless ([chat.receiver_id, chat.sender_id].include?(@current_user.id))
          error!("Access Denied", 403)
        end

        message = Message.create!({
          chat_id: params[:chat_id],
          # sender_id: @current_user.id,
          message: params[:content]
        })

        {message_details: message, sender_id:@current_user.id}
      end

    end
  end
end


        
  