module V1
  class Chats < Grape::API

    helpers V1::Helpers::AuthHelper
    before { authenticate_user! }

    resource :chats do

      desc 'List all chats of current user'

      get do
        Chat.joins(:participants).select('chats.*, participants.user_id as user_id')

        present chats, with: V1::Entities::Chat
      end

      desc 'Creating a new chat'

      params do
        requires :individual, type: Boolean, desc: 'Is Individual?', default: true
        optional :user_id, type: Integer, desc: 'Participant2 user Id' 
        optional :user_ids, type: Array[Integer], desc: "User Id for group chat"
      end

      post do
        
        # error!('No current user', 401) unless @current_user
        
        if params[:individual]
          
          unless params[:user_id]

            error!("User Id Required", 404)
            
          end

          receiver = User.find(params[:user_id])
          
          
          existing_chat = Chat.joins(:participants)
          .where(individual: true)
          .where(participants: {user_id: [@current_user.id, receiver.id]})
          .group('chats.id')
          .having('count(DISTINCT participants.user_id) = 2' )
          .first
          
          
          if existing_chat 
            message = Message.joins(:participant)
            .where(participants: {chat_id: existing_chat.id})
            .order(created_at: :asc)
            

            present message, with: V1::Entities::Message
            
          else 
            chat = Chat.create!({
              individual: true
            })
            
            chat.participants.create!({
              user_id: @current_user.id
            })
            
            chat.participants.create!({
              user_id: receiver.id
            })
            
            present chat, with: V1::Entities::Chat

            # {
            #   chat_id: chat.id, 
            #   participants: chat.users,
            #   messages: "No messages yet"
            # }
            
          end
          
        else
          
          unless params[:user_ids]
            
            error!("Atleast one user required to create a group chat")
            
          end
          
          chat = Chat.create!({
            individual: false
          })

          chat.participants.create!({
            user_id: @current_user
          })

          params[:user_ids].each do |id|
            
            chat.participants.create!({
              user_id: id
            })
            
          end
          
          present chat, with: V1::Entities::Chat
          
        end
        
      end
      
    end
    
  end
  
end
