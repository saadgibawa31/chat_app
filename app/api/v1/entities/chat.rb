module V1

  module Entities

    class Chat < Grape::Entity

      expose :chat_id
      expose :participant, using: Entities::Participant

    end

  end

end