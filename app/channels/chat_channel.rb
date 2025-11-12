class ChatChannel < ApplicationCable::Channel
 def subscribed
    chat = Chat.find_by(id: params[:chat_id])

    if chat.nil?
      reject
      return
    end

    if chat.users.include?(current_user)
      stream_from "chat_#{chat.id}"
      Rails.logger.info "Subscribed to chat_#{chat.id} as #{current_user.id}"
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
