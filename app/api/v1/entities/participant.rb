module V1

  module Entities

    class Participant < Grape::Entity

      expose :id
      expose :chat_id
      expose :user_id

    end

  end

end