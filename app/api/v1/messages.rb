module V1

  class Messages < Grape::API

    helpers V1::Helpers::AuthHelper

    before{ authenticate_user!}

    resource :messages do

      desc 'Fetching All Messages of Current User'
      params do
        requires :chat_id, type: Integer, desc: 'Chat Id'
      end
      post do
        chat = Chat.find(params[:chat_id])

        unless (chat.users.include?(@current_user))
          error!("Access Denied", 403)
        end

        messages = Message.joins(:participant)
                          .where(participants: {chat_id: chat.id})
                          .order(created_at: :asc)

        present messages, with: V1::Entities::Message
        
      end


      desc 'Creating new message'

      params do
        requires :chat_id, type: Integer, desc: 'Chat Id'
        requires :content, type: String, desc: 'Message Body'
      end

      post :new do

        chat = Chat.find(params[:chat_id])
        unless (chat.users.include?(@current_user))
          error!("Access Denied", 403)
        end

        participant = chat.participants.find_by(user_id: @current_user.id)

        message = Message.create!({
          participant_id: participant.id,
          message: params[:content]
        })

        ActionCable.server.broadcast("chat_#{chat.id}", message)

        present messages, with: V1::Entities::Message


      end

    end
  end
end


        
  